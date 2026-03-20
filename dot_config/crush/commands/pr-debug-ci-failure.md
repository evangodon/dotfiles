# Debug CI Failure

Here is the URL to the pull request: $PR_URL

## Step 1: Extract repo and PR number

Parse the PR URL to extract the owner, repo, and PR number.
For example, `https://github.com/vend/monocle/pull/14826` gives you `vend/monocle` and `14826`.

## Step 2: Check CI status

Run:
```
gh pr checks {pr_number} --repo {owner}/{repo}
```

This shows all checks and their status (pass/fail).

## Step 3: Identify failing checks

Look for checks with status `fail`. Note the run ID from the URL in the output.

## Step 4: Fetch failure logs

For each failing check, get the logs:
```
gh run view {run_id} --log-failed
```

This returns only the failed job logs.

## Step 5: Extract the actual error

The logs are verbose. Filter for the actual error by looking for:
- Lines containing `error`, `Error`, `ERROR`
- Lines containing `fail`, `FAIL`, `✖`, `✗`
- Lines with `##[error]` (GitHub Actions error annotations)

Focus on the **last** occurrence or the most relevant error message, as earlier errors might be cascading failures.

Common patterns to look for:
- **Lint/Prettier errors**: Look for eslint/prettier messages with file:line:column format
- **Type errors**: TypeScript compiler errors with `TS####` codes
- **Test failures**: Jest/test runner output with assertion failures
- **Build errors**: Webpack/build tool errors with module not found or syntax errors

## Step 6: Summarize the failure

Present a concise summary:

**CI Failure Summary**

| Check | Status | Error |
|-------|--------|-------|
| {check_name} | fail | {concise_error_description} |

Include:
- The specific file and line number if available
- The exact error message (truncated if too long)
- What type of error it is (lint, type, test, build)

## Step 7: Suggest a fix

Based on the error type, suggest how to fix it:

- **Lint/Prettier**: Show the exact formatting or rule violation and how to fix it
- **Type errors**: Explain the type mismatch and suggest the correct type
- **Test failures**: Identify what assertion failed and why
- **Build errors**: Identify missing dependencies or syntax issues

If you can determine the exact fix, offer to apply it automatically.

## Step 8: Ask if user wants the fix applied

If the fix is straightforward (e.g., prettier formatting, missing import), ask:

"Would you like me to fix this and push the changes?"

- If yes, apply the fix, verify it locally, commit, and push
- If no, just provide the summary and suggestion
