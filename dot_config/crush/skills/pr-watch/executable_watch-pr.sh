#!/usr/bin/env bash
# watch-pr.sh — Poll a GitHub PR until all checks pass or any check fails,
# then fire a macOS notification.
#
# Usage: watch-pr.sh <PR_URL_OR_NUMBER> [repo]
# Examples:
#   watch-pr.sh 15288
#   watch-pr.sh 15288 vend/monocle
#   watch-pr.sh https://github.com/vend/monocle/pull/15288

set -euo pipefail

PR_ARG="${1:-}"
REPO="${2:-}"
INTERVAL="${PR_WATCH_INTERVAL:-30}"  # seconds between polls

if [[ -z "$PR_ARG" ]]; then
  echo "Usage: watch-pr.sh <PR_URL_OR_NUMBER> [repo]"
  exit 1
fi

# Parse URL if given
if [[ "$PR_ARG" =~ ^https://github.com/([^/]+/[^/]+)/pull/([0-9]+) ]]; then
  REPO="${BASH_REMATCH[1]}"
  PR_NUMBER="${BASH_REMATCH[2]}"
else
  PR_NUMBER="$PR_ARG"
  if [[ -z "$REPO" ]]; then
    # Try to infer from git remote
    REPO=$(git remote get-url origin 2>/dev/null | sed -E 's|.*github.com[:/]||;s|\.git$||') || true
    if [[ -z "$REPO" ]]; then
      echo "Error: could not determine repo. Pass it as second argument (e.g. vend/monocle)"
      exit 1
    fi
  fi
fi

notify() {
  local title="$1"
  local message="$2"
  osascript -e "display notification \"$message\" with title \"$title\" sound name \"Glass\""
}

echo "👀 Watching PR #$PR_NUMBER in $REPO (polling every ${INTERVAL}s)..."

while true; do
  STATUS=$(gh pr view "$PR_NUMBER" --repo "$REPO" \
    --json statusCheckRollup,title \
    --jq '{
      title: .title,
      total: (.statusCheckRollup | length),
      failing: [.statusCheckRollup[] | select(.conclusion == "FAILURE") | .name],
      pending: [.statusCheckRollup[] | select(.conclusion == "" or .conclusion == null or .state == "PENDING" or .state == "IN_PROGRESS") | .name]
    }' 2>/dev/null) || { echo "Failed to fetch PR status, retrying..."; sleep "$INTERVAL"; continue; }

  TITLE=$(echo "$STATUS" | jq -r '.title')
  TOTAL=$(echo "$STATUS" | jq -r '.total')
  FAILING=$(echo "$STATUS" | jq -r '.failing | length')
  PENDING=$(echo "$STATUS" | jq -r '.pending | length')

  echo "[$(date +%H:%M:%S)] PR #$PR_NUMBER — total: $TOTAL, pending: $PENDING, failing: $FAILING"

  if [[ "$TOTAL" -eq 0 ]]; then
    sleep "$INTERVAL"
    continue
  fi

  if [[ "$FAILING" -gt 0 ]]; then
    FAILING_NAMES=$(echo "$STATUS" | jq -r '.failing | join(", ")')
    echo "❌ Checks failed: $FAILING_NAMES"
    notify "❌ PR #$PR_NUMBER Failed" "$FAILING_NAMES"
    exit 1
  fi

  if [[ "$PENDING" -eq 0 ]]; then
    echo "✅ All checks passed!"
    notify "✅ PR #$PR_NUMBER Ready to merge" "$TITLE"
    exit 0
  fi

  sleep "$INTERVAL"
done
