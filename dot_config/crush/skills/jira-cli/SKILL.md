---
name: jira-cli
description: Use Jira CLI to list tickets in epics, filter by assignee, and add comments to tickets. Use when working with Jira tickets, epics, or tracking work progress.
---

# Jira CLI Skill

## Description
Use the Jira CLI to interact with Jira tickets and epics, including listing tickets and filtering by assignee.

## Commands

### List All Tickets in Epic
Get all tickets from a specific epic:
```bash
jira epic list <EPIC-KEY> --plain
```

Example:
```bash
jira epic list LRX-29961 --plain
```

### List My Tickets in Epic
Get all tickets assigned to you from a specific epic:
```bash
jira epic list <EPIC-KEY> --assignee $(jira me) --plain
```

Example:
```bash
jira epic list LRX-29961 --assignee $(jira me) --plain
```

### Add Comment to Ticket
Add a comment to a Jira ticket using a positional argument:
```bash
jira issue comment add <TICKET-KEY> "Your comment here"
```

**Important: Never add a comment of more than one sentence.**

Add a comment from stdin:
```bash
echo "Your comment here" | jira issue comment add <TICKET-KEY>
```

Examples:
```bash
# Simple comment
jira issue comment add LRX-12345 "Updated the PR with requested changes"

# Comment from command output
echo "Deployment completed successfully at $(date)" | jira issue comment add LRX-12345
```

## When to Use
- When you need to see all work items in an epic
- When you want to check your assigned tickets in an epic
- When planning or tracking progress on epic-level work
- When you need to get a quick overview of epic status
- When you need to add updates or comments to tickets
- When documenting progress or blockers on a ticket
