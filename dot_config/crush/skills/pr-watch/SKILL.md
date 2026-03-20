---
name: pr-watch
description: Poll a GitHub PR until all CI checks pass or fail, then fire a macOS notification. Use when the user wants to be notified when a PR is ready to merge, when checks pass, or when CI finishes.
---

# PR Watch

Polls a GitHub PR on an interval and fires a macOS notification when all checks pass (✅) or any check fails (❌).

## Quick start

```bash
bash ~/.config/crush/skills/pr-watch/watch-pr.sh <PR_URL_OR_NUMBER> [repo]
```

Run in the background so it doesn't block the session:

```bash
bash ~/.config/crush/skills/pr-watch/watch-pr.sh 15288 vend/monocle &
```

## Examples

```bash
# By PR number (infers repo from git remote)
bash ~/.config/crush/skills/pr-watch/watch-pr.sh 15288

# By PR number with explicit repo
bash ~/.config/crush/skills/pr-watch/watch-pr.sh 15288 vend/monocle

# By full URL
bash ~/.config/crush/skills/pr-watch/watch-pr.sh https://github.com/vend/monocle/pull/15288
```

## Options

- **Poll interval** — defaults to 30s. Override with `PR_WATCH_INTERVAL=60` env var.
- **Notification sound** — uses macOS "Glass" sound. Requires `osascript` (built into macOS).
- Requires `gh` CLI to be authenticated.

## Behaviour

- Polls every 30 seconds (configurable)
- Exits 0 and notifies ✅ when all checks pass and none are pending
- Exits 1 and notifies ❌ when any check fails, listing the failing check names
- Prints timestamped status to stdout while running
