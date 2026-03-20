# Address PR Comments

Here is the URL to the pull request: $PR_URL

## Step 1: Extract repo and PR number

Parse the PR URL to extract the owner, repo, and PR number.
For example, `https://github.com/vend/monocle/pull/14826` gives you `vend/monocle` and `14826`.

Then fetch the PR's head branch name:
```
gh pr view {pr_number} --repo {owner}/{repo} --json headRefName -q .headRefName
```

Check the current git branch with `git branch --show-current` and verify it matches. If it does not match, stop and inform the user which branch they need to check out before proceeding.

Also run `git status --short` to check for uncommitted changes. If any exist, stop and warn the user — uncommitted changes could conflict with edits made while addressing comments.

## Step 2: Fetch all review comments

Run:
```
gh api repos/{owner}/{repo}/pulls/{pr_number}/comments --paginate | jq '[.[] | {id, user: .user.login, path, line, body}]'
```

Also fetch the review threads to determine which comments are resolved:
```
gh api graphql -f query='query($owner:String!,$repo:String!,$pr:Int!){repository(owner:$owner,name:$repo){pullRequest(number:$pr){reviewThreads(first:100){nodes{isResolved,comments(first:100){nodes{id,body,author{login}}}}}}}}' -f owner={owner} -f repo={repo} -F pr={pr_number}
```

**Only include unresolved comments.** Some comments may have already been resolved — filter those out before proceeding.

For each unresolved thread, check if the PR author has already replied. If a reply from the PR author exists, include it in the table as additional context — this may mean the comment has already been partially addressed or is awaiting further reviewer response rather than a code change.

## Step 3: Categorize and display comments in a table

Classify each comment into one of these categories:

- **Actionable**: The reviewer is requesting a specific code change — e.g., a suggestion block, "use X instead of Y", "add error handling", "rename this". These can be addressed with a code change.
- **Question**: The reviewer is asking a question — e.g., "why did you do X?", "what happens if Y?", "is this intentional?". These require a human response, not a code change.

Present all comments in a numbered table with these columns:

| # | Type | Reviewer | Comment (truncated) |
|---|------|----------|---------------------|

Where **Type** is either `Actionable` or `Question`.

Truncate the comment body to ~80 characters for readability.

## Step 4: Ask which comments to address

Ask the user which comments they want to address. They can specify:
- A list of numbers (e.g., "2, 3, 5")
- A range (e.g., "2-6")
- "all" to address every comment

For **Question** type comments, let the user know these will need a human reply and won't result in code changes unless they specify otherwise.

Wait for the user's response before proceeding.

## Step 5: Address each selected comment

For each selected **Actionable** comment:

1. Read the file referenced in the comment
2. Understand what the reviewer is asking for
3. If the reviewer provided a code suggestion (` ```suggestion ` block), apply it exactly
4. If the reviewer described a change without a suggestion block, use your judgment to make the appropriate code change
5. After making the change, verify it compiles/passes linting

For each selected **Question** comment:

1. Skip it by default — inform the user it needs a human reply
2. If the user explicitly asked to address it, read the surrounding code and attempt to answer the question or make a relevant code change if appropriate

## Step 6: After all changes are made

1. Run the relevant type checker or linter to verify no errors were introduced
2. Show a summary table of what was changed:

| # | Comment | File | What was done |
|---|---------|------|---------------|

3. Ask the user if they want to:
   - **Commit and push** the changes
   - **Add emoji reactions** (👍) to the addressed comments
   - **Resolve the comment threads**

To resolve a thread, use the thread node ID (looks like `PRRT_kwDO...`) from the GraphQL query in Step 2:
```
gh api graphql -f query='mutation{resolveReviewThread(input:{threadId:"THREAD_NODE_ID"}){thread{isResolved}}}'
```

Note: the GraphQL review threads query in Step 2 must include `id` on each node to get the thread node IDs needed for resolution:
```
{nodes{id,isResolved,comments(first:100){nodes{id,body,author{login}}}}}
```


$EXTRA_DIRECTIONS

