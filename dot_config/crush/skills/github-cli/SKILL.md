---
name: github-cli
description: Use GitHub CLI (`gh`) for direct GitHub API operations - searching code, fetching PR data, viewing diffs, managing comments, and tracing commit history. This is a data retrieval tool, NOT an AI. Use for fetching GitHub data or performing GitHub operations. For AI-powered code reviews or analysis, use the copilot skill instead.
---

# GitHub CLI Skill

## Description
Use the GitHub CLI (`gh`) to interact with GitHub's API - fetch data, search repositories, view PRs, and manage reviews. This tool retrieves and displays data; it does not provide AI analysis.

## Commands

### Search Code
Search for code across GitHub organizations:
```bash
gh search code "<search term>" --owner <org-name> --limit 100
```

Example:
```bash
gh search code "vend_sales_import" --owner vend --limit 100
```

### Fetch PR Review Comments
Get all comments from a pull request:
```bash
gh api repos/OWNER/REPO/pulls/PR_NUMBER/comments | jq -r '.[] | "\(.user.login) - \(.path):\(.line)\n\(.body)\n---"'
```

### Fetch PR Comments by User
Filter PR review comments by a specific user:
```bash
gh api repos/OWNER/REPO/pulls/PR_NUMBER/comments | jq -r '.[] | select(.user.login == "USERNAME") | "\(.path):\(.line)\n\(.body)\n---"'
```

### Get PR Diff
View the diff for a pull request:
```bash
gh pr diff <PR_NUMBER>
```

View diff for a PR in a specific repo:
```bash
gh pr diff <PR_NUMBER> --repo OWNER/REPO
```

Get raw unified diff format:
```bash
gh pr diff <PR_NUMBER> --patch
```

Examples:
```bash
# View diff of PR #123 in current repo
gh pr diff 123

# View diff of PR in specific repo
gh pr diff 456 --repo vend/retail-api

# Get patch format for processing
gh pr diff 789 --patch > pr-789.patch
```

### Get Commit History for a File
When `gh blame` isn't available, use the API to get commit history for a specific file:
```bash
gh api repos/OWNER/REPO/commits -X GET -F path=path/to/file --jq '.[0:10] | .[] | "\(.sha[0:7]) \(.commit.author.name) (\(.commit.author.date[0:10])) - \(.commit.message | split("\n")[0])"'
```

Example:
```bash
gh api repos/vend/stocky/commits -X GET -F path=handler/stock_management.go --jq '.[0:10] | .[] | "\(.sha[0:7]) \(.commit.author.name) (\(.commit.author.date[0:10])) - \(.commit.message | split("\n")[0])"'
```

### Compare Commits to Find When Code Was Added
View the diff between two commits for a specific file:
```bash
gh api "repos/OWNER/REPO/compare/PARENT_SHA...COMMIT_SHA" --jq '.files[] | select(.filename == "path/to/file") | .patch'
```

Example:
```bash
gh api "repos/vend/stocky/compare/cf23f91...bac10b5" --jq '.files[] | select(.filename == "handler/stock_management.go") | .patch'
```

### Fetch File Contents at a Specific Commit or Branch
Read a file from a specific commit SHA or branch without cloning:
```bash
gh api "repos/OWNER/REPO/contents/path/to/file?ref=COMMIT_SHA_OR_BRANCH" --jq '.content' | base64 -d
```

Example:
```bash
gh api "repos/vend/jaws/contents/services/job_update_service.go?ref=ff5e82ba" --jq '.content' | base64 -d | sed -n '140,185p'
```

**Important:** The `--ref` flag does NOT work with `gh api repos/.../contents/...` — embed the ref as a query parameter in the URL instead.

### Delete PR Review Comments
Delete outdated or unwanted inline review comments from a pull request:

**Step 1: List all inline comments to get their IDs:**
```bash
gh api /repos/OWNER/REPO/pulls/PR_NUMBER/comments --jq '.[] | {id: .id, user: .user.login, body: .body[0:100], path: .path}'
```

**Step 2: Delete specific comment by ID:**
```bash
gh api --method DELETE /repos/OWNER/REPO/pulls/comments/COMMENT_ID
```

Example:
```bash
# List comments on PR #558
gh api /repos/vend/jaws/pulls/558/comments --jq '.[] | {id: .id, user: .user.login, body: .body[0:100]}'

# Delete comment with ID 2738324838
gh api --method DELETE /repos/vend/jaws/pulls/comments/2738324838
```

**Important distinctions:**
- **Inline review comments** (numeric IDs like `2738324838`) - CAN be deleted using this method
- **Review objects** (IDs like `PRR_kwDOIWAm1M7dqGB6`) - Cannot be deleted via API, only dismissed
- Review summaries will remain in PR timeline even after inline comments are deleted
- You can only delete comments on PRs where you have write access

## When to Use
- When you need to search for code patterns across repositories
- When reviewing pull requests and need to fetch comments or diffs
- When investigating how something is implemented in other repos
- When you need to filter PR feedback by specific reviewers
- When you want to see what changes are in a PR without opening the browser
- When tracing when specific code was introduced (git blame alternative)
- When comparing commits to understand what changed
