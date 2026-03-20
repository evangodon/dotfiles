# PR Status

Check the status of this pull request: $PR

`$PR` can be either:
- A full GitHub URL (e.g., `https://github.com/vend/retail-api/pull/123`)
- A repo name and PR number (e.g., `retail-api 123`)

Parse the input to extract the owner, repo, and PR number. If only a repo name is given (no owner), use `gh repo list` or `gh search repos` to resolve the full owner/repo path.

## Steps

1. Check draft status and PR metadata
   • `gh pr view <PR_NUMBER> --repo OWNER/REPO --json isDraft,title,state,author,mergeable,baseRefName,headRefName,reviewDecision,reviews`

2. Check CI status
   • `gh pr checks <PR_NUMBER> --repo OWNER/REPO`

3. Count unresolved review comments
   • ```
     gh api graphql -f query='
       query($owner: String!, $repo: String!, $number: Int!) {
         repository(owner: $owner, name: $repo) {
           pullRequest(number: $number) {
             baseRefName
             headRefName
             commits(last: 1) {
               nodes {
                 commit {
                   statusCheckRollup {
                     state
                   }
                 }
               }
             }
             reviewThreads(first: 100) {
               nodes {
                 isResolved
                 comments(first: 1) {
                   nodes {
                     body
                     author { login }
                   }
                 }
               }
             }
           }
         }
       }
     ' -f owner=OWNER -f repo=REPO -F number=PR_NUMBER --jq '{
       total: (.data.repository.pullRequest.reviewThreads.nodes | length),
       unresolved: [.data.repository.pullRequest.reviewThreads.nodes[] | select(.isResolved == false)] | length,
       resolved: [.data.repository.pullRequest.reviewThreads.nodes[] | select(.isResolved == true)] | length
     }'
     ```

4. Check if the branch is behind the default branch (main or master)
   • `gh api repos/OWNER/REPO/compare/BASE_REF...HEAD_REF --jq '{ahead_by: .ahead_by, behind_by: .behind_by}'`
   • Use `baseRefName` and `headRefName` from step 1 — `behind_by` is how many commits the PR branch is behind base

## Output

Present a summary table:

| Check       | Status |
|-------------|--------|
| Draft       | Yes / No |
| CI Checks   | ✅ Passing / ❌ Failing / ⏳ Pending |
| Approvals   | Approved / Changes Requested / Pending (N approvals) |
| Unresolved  | N comments |
| Mergeable   | Yes / No / Conflicting |
| Behind Base | N commits behind / Up to date |

## Follow-up

If the branch is behind the default branch, ask if I want you to rebase on master.
