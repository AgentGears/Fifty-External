#!/usr/bin/env bash
set -euo pipefail

TARGET_REPOSITORY="${TARGET_REPOSITORY:-AgentGears/Fifty}"
EXPECTED_CONTEXT="${EXPECTED_CONTEXT:-fifty/external-verification}"

usage() {
  echo "usage: $0 --receipt PATH --target-url URL" >&2
  exit 64
}

RECEIPT=""
TARGET_URL=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --receipt) RECEIPT=${2:-}; shift 2 ;;
    --target-url) TARGET_URL=${2:-}; shift 2 ;;
    *) usage ;;
  esac
done

[[ -n "$RECEIPT" && -n "$TARGET_URL" ]] || usage
[[ -f "$RECEIPT" ]] || { echo "receipt not found" >&2; exit 65; }
[[ -n "${FIFTY_STATUS_TOKEN:-}" ]] || { echo "FIFTY_STATUS_TOKEN is required" >&2; exit 66; }
command -v jq >/dev/null 2>&1 || { echo "jq is required" >&2; exit 67; }
command -v curl >/dev/null 2>&1 || { echo "curl is required" >&2; exit 68; }

result=$(jq -r '.result // ""' "$RECEIPT")
context=$(jq -r '.status_context // ""' "$RECEIPT")
target_commit=$(jq -r '.target_commit_sha // ""' "$RECEIPT")
observed_commit=$(jq -r '.observed_commit_sha // ""' "$RECEIPT")
target_tree=$(jq -r '.target_tree_sha // ""' "$RECEIPT")
observed_tree=$(jq -r '.observed_tree_sha // ""' "$RECEIPT")
approved_supply=$(jq -r '.approved_supply_map_sha256 // ""' "$RECEIPT")
observed_supply=$(jq -r '.observed_supply_map_sha256 // ""' "$RECEIPT")
approved_denylist=$(jq -r '.approved_denylist_sha256 // ""' "$RECEIPT")
observed_denylist=$(jq -r '.observed_denylist_sha256 // ""' "$RECEIPT")
clean_before=$(jq -r '.worktree_clean_before // false' "$RECEIPT")
clean_after=$(jq -r '.worktree_clean_after // false' "$RECEIPT")
all_checks_pass=$(jq -r '[.checks[]?.result] | length > 0 and all(. == "PASS")' "$RECEIPT")

[[ "$result" == "PASS" ]] || { echo "receipt is not PASS" >&2; exit 69; }
[[ "$context" == "$EXPECTED_CONTEXT" ]] || { echo "unexpected status context" >&2; exit 70; }
[[ "$target_commit" =~ ^[0-9a-f]{40}$ ]] || { echo "invalid target commit" >&2; exit 71; }
[[ "$observed_commit" == "$target_commit" ]] || { echo "commit identity mismatch" >&2; exit 72; }
[[ "$target_tree" =~ ^[0-9a-f]{40}$ ]] || { echo "invalid target tree" >&2; exit 73; }
[[ "$observed_tree" == "$target_tree" ]] || { echo "tree identity mismatch" >&2; exit 74; }
[[ -n "$approved_supply" && "$observed_supply" == "$approved_supply" ]] || { echo "supply digest mismatch" >&2; exit 75; }
[[ -n "$approved_denylist" && "$observed_denylist" == "$approved_denylist" ]] || { echo "denylist digest mismatch" >&2; exit 76; }
[[ "$clean_before" == "true" && "$clean_after" == "true" ]] || { echo "worktree cleanliness not established" >&2; exit 77; }
[[ "$all_checks_pass" == "true" ]] || { echo "not all recorded checks passed" >&2; exit 78; }

payload=$(jq -n \
  --arg state "success" \
  --arg context "$EXPECTED_CONTEXT" \
  --arg description "bounded verification passed" \
  --arg target_url "$TARGET_URL" \
  '{state:$state, context:$context, description:$description, target_url:$target_url}')

response_file=$(mktemp)
trap 'rm -f "$response_file"' EXIT
http_code=$(curl -sS -o "$response_file" -w '%{http_code}' \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${FIFTY_STATUS_TOKEN}" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "https://api.github.com/repos/${TARGET_REPOSITORY}/statuses/${target_commit}" \
  -d "$payload")

if [[ "$http_code" != "201" ]]; then
  cat "$response_file" >&2 || true
  echo "status publication failed with HTTP $http_code" >&2
  exit 79
fi

echo "published ${EXPECTED_CONTEXT}=success for ${target_commit}"
