#!/usr/bin/env bash
set -u -o pipefail

TARGET_COMMIT="6f39aa53e9bb863b6c8fb5c719806f055646de49"
TARGET_TREE="c0153105eeea5b55d890cc0a7e83bbb586ecd890"
EXPECTED_RUNTIME="go1.27.1"
STATUS_CONTEXT="fifty/external-verification"
CONTRACT_VERSION="1.5"
CHECK_TIMEOUT_SECONDS="${CHECK_TIMEOUT_SECONDS:-600}"
EXPECTED_SUPPLY_MAP_SHA256="f69369be68f079d0e0dcc367e4a8eb5c24626097414d1d909fe303cdc74a17ba"
EXPECTED_DENYLIST_SHA256="10f941528bd53e8dd0ff2465c8b038a85f15f3c87248a098bf8ebfedd81a65d8"

usage() {
  echo "usage: $0 --repo PATH --supply-map PATH --denylist PATH --receipt PATH" >&2
  exit 64
}

REPO=""
SUPPLY_MAP=""
DENYLIST=""
RECEIPT=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --repo) REPO=${2:-}; shift 2 ;;
    --supply-map) SUPPLY_MAP=${2:-}; shift 2 ;;
    --denylist) DENYLIST=${2:-}; shift 2 ;;
    --receipt) RECEIPT=${2:-}; shift 2 ;;
    *) usage ;;
  esac
done
[[ -n "$REPO" && -n "$SUPPLY_MAP" && -n "$DENYLIST" && -n "$RECEIPT" ]] || usage

TMP=$(mktemp -d)
RESULT="FAIL"
STAGE="initialization"
ACTUAL_COMMIT=""
ACTUAL_TREE=""
RUNTIME_LINE=""
SUPPLY_MAP_SHA256=""
DENYLIST_SHA256=""
CLEAN_BEFORE="false"
CLEAN_AFTER="false"

declare -A CHECK_RESULT
declare -A CHECK_DIGEST
for name in unit race static stress panic_legacy panic_current terminology; do
  CHECK_RESULT[$name]="NOT_RUN"
  CHECK_DIGEST[$name]=""
done

sha_file() {
  if [[ ! -f "$1" ]]; then printf ''; return; fi
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | awk '{print $1}'
  else
    shasum -a 256 "$1" | awk '{print $1}'
  fi
}

write_receipt() {
  local verified_at
  verified_at=$(date -u +%Y-%m-%dT%H:%M:%SZ)
  mkdir -p "$(dirname "$RECEIPT")"
  cat > "$RECEIPT" <<JSON
{
  "contract_version": "$CONTRACT_VERSION",
  "status_context": "$STATUS_CONTEXT",
  "result": "$RESULT",
  "terminal_stage": "$STAGE",
  "verified_at_utc": "$verified_at",
  "target_commit_sha": "$TARGET_COMMIT",
  "observed_commit_sha": "$ACTUAL_COMMIT",
  "target_tree_sha": "$TARGET_TREE",
  "observed_tree_sha": "$ACTUAL_TREE",
  "runtime": "${RUNTIME_LINE//\"/\\\"}",
  "approved_supply_map_sha256": "$EXPECTED_SUPPLY_MAP_SHA256",
  "observed_supply_map_sha256": "$SUPPLY_MAP_SHA256",
  "approved_denylist_sha256": "$EXPECTED_DENYLIST_SHA256",
  "observed_denylist_sha256": "$DENYLIST_SHA256",
  "watchdog_seconds_per_check": $CHECK_TIMEOUT_SECONDS,
  "checks": {
    "unit": {"result": "${CHECK_RESULT[unit]}", "output_sha256": "${CHECK_DIGEST[unit]}"},
    "race": {"result": "${CHECK_RESULT[race]}", "output_sha256": "${CHECK_DIGEST[race]}"},
    "static": {"result": "${CHECK_RESULT[static]}", "output_sha256": "${CHECK_DIGEST[static]}"},
    "stress": {"result": "${CHECK_RESULT[stress]}", "output_sha256": "${CHECK_DIGEST[stress]}"},
    "panic_legacy": {"result": "${CHECK_RESULT[panic_legacy]}", "output_sha256": "${CHECK_DIGEST[panic_legacy]}"},
    "panic_current": {"result": "${CHECK_RESULT[panic_current]}", "output_sha256": "${CHECK_DIGEST[panic_current]}"},
    "terminology": {"result": "${CHECK_RESULT[terminology]}", "output_sha256": "${CHECK_DIGEST[terminology]}"}
  },
  "worktree_clean_before": $CLEAN_BEFORE,
  "worktree_clean_after": $CLEAN_AFTER
}
JSON
}

cleanup() {
  local rc=$?
  write_receipt || true
  rm -rf "$TMP"
  exit "$rc"
}
trap cleanup EXIT

fail() {
  STAGE="$1"
  echo "$2" >&2
  exit "${3:-1}"
}

[[ -d "$REPO/.git" ]] || fail repository "repository checkout required" 65
[[ -f "$SUPPLY_MAP" ]] || fail supply_map "supply map not found" 66
[[ -f "$DENYLIST" ]] || fail denylist "denylist not found" 67
command -v timeout >/dev/null 2>&1 || fail watchdog "timeout command not found" 68
command -v grep >/dev/null 2>&1 || fail terminology_tool "grep command not found" 69
SUPPLY_MAP_SHA256=$(sha_file "$SUPPLY_MAP")
DENYLIST_SHA256=$(sha_file "$DENYLIST")
[[ "$SUPPLY_MAP_SHA256" == "$EXPECTED_SUPPLY_MAP_SHA256" ]] || fail supply_map "supply map digest mismatch: $SUPPLY_MAP_SHA256" 70
[[ "$DENYLIST_SHA256" == "$EXPECTED_DENYLIST_SHA256" ]] || fail denylist "denylist digest mismatch: $DENYLIST_SHA256" 71
active_terms=$(grep -Ev '^[[:space:]]*(#|$)' "$DENYLIST" | wc -l | tr -d '[:space:]')
[[ "$active_terms" =~ ^[1-9][0-9]*$ ]] || fail denylist "denylist contains no active terms" 72

cd "$REPO" || fail repository "cannot enter repository" 73
ACTUAL_COMMIT=$(git rev-parse HEAD 2>/dev/null || true)
ACTUAL_TREE=$(git rev-parse HEAD^{tree} 2>/dev/null || true)
[[ "$ACTUAL_COMMIT" == "$TARGET_COMMIT" ]] || fail commit "commit mismatch: $ACTUAL_COMMIT" 74
[[ "$ACTUAL_TREE" == "$TARGET_TREE" ]] || fail tree "tree mismatch: $ACTUAL_TREE" 75
if [[ -z "$(git status --porcelain --untracked-files=all)" ]]; then CLEAN_BEFORE="true"; else fail clean_before "worktree not clean before verification" 76; fi

RUNTIME_LINE=$(go version 2>&1 || true)
RUNTIME_TOKEN=$(printf '%s\n' "$RUNTIME_LINE" | awk '{print $3}')
[[ "$RUNTIME_TOKEN" == "$EXPECTED_RUNTIME" ]] || fail runtime "runtime mismatch: $RUNTIME_LINE" 77

export GOTOOLCHAIN=local
export GOFLAGS="${GOFLAGS:-} -mod=readonly"

run_check() {
  local name=$1
  shift
  STAGE="$name"
  set +e
  timeout --signal=TERM --kill-after=10s "${CHECK_TIMEOUT_SECONDS}s" "$@" >"$TMP/$name.out" 2>&1
  local rc=$?
  set -e
  CHECK_DIGEST[$name]=$(sha_file "$TMP/$name.out")
  if [[ $rc -eq 0 ]]; then
    CHECK_RESULT[$name]="PASS"
    return 0
  fi
  if [[ $rc -eq 124 || $rc -eq 137 ]]; then
    CHECK_RESULT[$name]="TIMEOUT"
  else
    CHECK_RESULT[$name]="FAIL"
  fi
  cat "$TMP/$name.out" >&2 || true
  exit "$rc"
}

set -e
run_check unit go test ./...
run_check race go test -race ./...
run_check static go vet ./...
run_check stress go test -race -count=100 ./verification
run_check panic_legacy env GODEBUG=panicnil=1 go test ./verification -run TestScenarioPanicsBecomeFailuresAndLaterScenarioRuns -count=100
run_check panic_current env GODEBUG=panicnil=0 go test ./verification -run TestScenarioPanicsBecomeFailuresAndLaterScenarioRuns -count=100

STAGE="terminology"
terminology_output="$TMP/terminology.out"
set +e
timeout --signal=TERM --kill-after=10s "${CHECK_TIMEOUT_SECONDS}s" bash -c '
while IFS= read -r term; do
  [[ -z "$term" || "$term" == \#* ]] && continue
  grep -RInF --exclude-dir=.git --binary-files=without-match -- "$term" . 2>/dev/null || true
done < "$1"
' _ "$DENYLIST" > "$terminology_output" 2>&1
terminology_rc=$?
set -e
CHECK_DIGEST[terminology]=$(sha_file "$terminology_output")
if [[ $terminology_rc -eq 124 || $terminology_rc -eq 137 ]]; then
  CHECK_RESULT[terminology]="TIMEOUT"
  cat "$terminology_output" >&2 || true
  exit "$terminology_rc"
fi
if [[ $terminology_rc -ne 0 ]]; then
  CHECK_RESULT[terminology]="FAIL"
  cat "$terminology_output" >&2 || true
  exit "$terminology_rc"
fi
if [[ -s "$terminology_output" ]]; then
  CHECK_RESULT[terminology]="FAIL"
  cat "$terminology_output" >&2
  exit 78
fi
CHECK_RESULT[terminology]="PASS"

STAGE="clean_after"
if [[ -z "$(git status --porcelain --untracked-files=all)" ]]; then CLEAN_AFTER="true"; else fail clean_after "worktree changed during verification" 79; fi

RESULT="PASS"
STAGE="complete"
echo "PASS $ACTUAL_COMMIT"
echo "receipt=$RECEIPT"
exit 0
