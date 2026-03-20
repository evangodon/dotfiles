# Create Pull Request

You are tasked with creating a pull request for the current branch.

## Steps

1. Get the current branch name and repository information
   • `git branch --show-current` - Get current branch name
   • `git remote get-url origin` - Get repository URL

2. Get the Jira ticket number from the branch name (format: LRX-XXXXX)
   • Extract ticket number from branch name if it follows pattern like `feature/LRX-12345-description`
   • If found, fetch ticket details: `jira issue view LRX-XXXXX --plain`

3. Search for GitHub pull request template in the repository
   • Look for `.github/pull_request_template.md` or `.github/PULL_REQUEST_TEMPLATE.md`
   • If found, use it as the base template for the PR body

4. Get commit history for the PR
   • `git log main..HEAD --oneline` - Get commits that will be in the PR
   • `git diff main...HEAD --stat` - Get summary of changes

5. Create the PR using GitHub CLI
   • Use ticket title as PR title if available
   • Use ticket description as PR body if available, otherwise use commit messages
   • Format: `gh pr create --title "LRX-XXXXX: Title" --body "Description from Jira ticket"`
   • Add any relevant labels or reviewers if specified

5. Ask user if they want to update the Jira ticket status to "Ready for Review"
   • If user confirms, move the ticket to the next status
   • Use: `jira issue move LRX-XXXXX "Ready for Review"` or `jira issue move LRX-XXXXX --next`
   • Confirm the status was updated successfully

## Notes

- If no Jira ticket is found in branch name, proceed with PR creation using commit messages
- Ensure you're on the correct branch before creating the PR
- The PR will be created against the default branch (usually main/master)
- Only attempt to update Jira status if a ticket was found and user confirms
- Remove all lines with a checkbox if that checkbox is unchecked

$EXTRA_INSTRUCTIONS
