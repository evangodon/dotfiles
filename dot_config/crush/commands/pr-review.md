# PR Review

Here is the url to the pull request to review: $PR_URL

Here is an example of what you can run to review the PR with url `https://github.com/vend/terraform-datastores/pull/1202`

1.  `gh pr view 1202 --repo vend/terraform-datastores --json title,body,author,files,additions,deletions,changedFiles`
  • Get PR metadata: title, description, author, file list, and change stats
2.  `gh pr diff 1202 --repo vend/terraform-datastores`
  • Get the actual diff showing what changed in the code

## Jira Ticket

You can also pull in the ticket using the Jira CLI. Find the Jira ticket number from the PR title or body (e.g. "LRX-30259").
Get the description with: `jira issue view LRX-30259 --plain`
If you cannot find the ticket number, proceed without it.

---

## How to Review

### Step 1: Understand Context

Before reviewing code, understand what the PR is trying to do:
- Read the PR title, description, and linked Jira ticket
- Note the scope: is this a bug fix, new feature, refactor, or infra change?
- Check PR size — flag if it's very large and suggest splitting if appropriate

### Step 2: Review the Diff

Work through the diff with the following priorities in order:

#### 🔴 Blocking (must fix before merge)
- **Security**: hardcoded secrets, SQL injection, insufficient input validation, insecure crypto
- **Bugs**: missing null checks, incorrect error handling, unhandled edge cases, wrong logic
- **Breaking changes**: API contract violations, schema changes without migration, removed functionality

#### 🟡 Important (should fix)
- **Test coverage**: are happy and unhappy paths tested? Are edge cases covered?
- **Performance**: N+1 queries, O(n²) where better is possible, unnecessary recomputation
- **Maintainability**: complex logic that needs simplification, redundant code

#### 🟢 Nitpick (optional, nice to have)
- Naming clarity, comment quality, minor style inconsistencies not caught by linters
- Clearly label these as nitpicks so the author knows they're non-blocking

### Step 3: Write Feedback

Structure each comment as: **observation → evidence → suggestion**

- Be specific — vague comments are unhelpful
- Include code snippets or examples when proposing a fix
- Ask questions rather than issuing demands ("Have you considered...?" not "You must...")
- Assume positive intent — focus on the code, not the person
- Use "we" and "let's" to keep it collaborative

**Examples:**
- ❌ "This is bad code"
- ✅ "This function doesn't handle negative inputs — `calculateTotal(-5)` would return incorrect results. Consider adding a guard clause at the top. Something like: [snippet]"

### Step 4: Summarize

End your review with a brief summary:
- Overall assessment (looks good / needs changes / blocking issues found)
- List of blocking issues (if any) clearly called out
- Acknowledge what was done well

### What to Ignore

- Auto-fixable style issues (linters should catch these)
- Subjective preferences with no clear team standard basis
- Code that is clearly placeholder or will be refactored
