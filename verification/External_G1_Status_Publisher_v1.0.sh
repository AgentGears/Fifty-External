#!/usr/bin/env bash
set -euo pipefail

TARGET_REPOSITORY="AgentGears/Fifty"
TARGET_COMMIT="6f39aa53e9bb863b6c8fb5c719806f055646de49"
TARGET_TREE="c0153105eeea5b55d890cc0a7e83bbb586ecd890"
STATUS_CONTEXT="fifty/external-verification"
EXPECTED_SUPPLY_MAP_SHA256="f69369be68f079d0e0dcc367e4a8eb5c24626097414d1d909fe303cdc74a17ba"
EXPECTED_DENYLIST_SHA256="10f941528bd53e8dd0ff2465c8b038a85f15f3c87248a098bf8ebfedd81a65d8"

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

receipt_result=$(jq -r '.result // ""' "$RECEIPT")
target_commit=$(jq -r '.target_commit_sha // ""' "$RECEIPT")
observed_commit=$(jq -r '.observed_commit_sha // ""' "$RECEIPT")
target_tree=$(jq -r '.target_tree_sha // ""' "$RECEIPT")
observed_tree=$(jq -r '.observed_tree_sha // ""' "$RECEIPT")
supply_digest=$(jq -r '.observed_supply_map_sha256 // ""' "$RECEIPT")
denylist_digest=$(jq -r '.observed_denylist_sha256 // ""' "$RECEIPT")
clean_before=$(jq -r '.worktree_clean_before // false' "$RECEIPT")
clean_after=$(jq -r '.worktree_clean_after // false' "$RECEIPT")
all_checks_pass=$(jq -r '[.checks[]?.result] | length > 0 and all(. == "PASS")' "$RECEIPT")

state="failure"
description="external verification failed"
if [[ "$receipt_result" == "PASS" \
   && "$target_commit" == "$TARGET_COMMIT" \
   && "$observed_commit" == "$TARGET_COMMIT" \
   && "$target_tree" == "$TARGET_TREE" \
   && "$observed_tree" == "$TARGET_TREE" \
   && "$supply_digest" == "$EXPECTED_SUPPLY_MAP_SHA256" \
   && "$denylist_digest" == "$EXPECTED_DENYLIST_SHA256" \
   && "$clean_before" == "true" \
   && "$clean_after" == "true" \
   && "$all_checks_pass" == "true" ]]; then
  state="success"
  description="bounded verification passed"
fi

payload=$(jq -n \
  --arg state "$state" \
  --arg context "$STATUS_CONTEXT" \
  --arg description "$description" \
  --arg target_url "$TARGET_URL" \
  '{state:$state, context:$context, description:$description, target_url:$target_url}')

response_file=$(mktemp)
http_code=$(curl -sS -o "$response_file" -w '%{http_code}' \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${FIFTY_STATUS_TOKEN}" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "https://api.github.com/repos/${TARGET_REPOSITORY}/statuses/${TARGET_COMMIT}" \
  -d "$payload")

if [[ "$http_code" != "201" ]]; then
  cat "$response_file" >&2 || true
  rm -f "$response_file"
  echo "status publication failed with HTTP $http_code" >&2
  exit 69
fi
rm -f "$response_file"

echo "published ${STATUS_CONTEXT}=${state} for ${TARGET_COMMIT}"
[[ "$state" == "success" ]] || exit 1
