---
name: runbooks
description: Create and maintain runbooks that document how to manually test or reproduce a flow. Use when the user asks for a runbook, a step-by-step testing guide, or a "how to reproduce" document for a feature or bug fix.
---

# Runbooks Skill

## Description

Runbooks are step-by-step guides for manually testing or reproducing a specific flow.
They live in the repo alongside the code they test and are written for Crush (or a human)
to follow without needing additional context.

## Location

Always write runbooks to:
```
<repo-root>/.crush/runbooks/<kebab-case-name>.md
```

Example: `.crush/runbooks/replace-status.md`

## File naming

- Use kebab-case
- Name after the flow being tested, not the ticket
- Good: `replace-status.md`, `create-service-order.md`, `refund-flow.md`
- Bad: `LRX-28356.md`, `test.md`, `runbook1.md`

## Structure

Every runbook must follow this structure in order:

```markdown
# Runbook: <Flow Name>

<One or two sentences describing what the runbook tests and why it exists.>

---

## Prerequisites

<Bullet list of what must be true before starting: services running, feature flags, credentials, seed data.>

<Include mprocs start command if applicable.>

---

## Getting fresh credentials

<How to obtain a valid session cookie and XSRF token. Always include the DevTools copy instructions
and the vars.env file path.>

---

## Test 1: <Happy path name>

<Brief description.>

<Commands to run — hurl, playwright-cli, SQL via dbhub, etc.>

---

## Test 2: <Edge case or alternate path>

<Brief description.>

### Step A — <First step>
### Step B — <Second step>
...

---

## Retailer reference

| Key | Value |
|---|---|
| Retailer ID | `...` |
| Domain prefix | `...` |
| Base URL | `...` |
| Login | `admin` / `password` |

---

## mprocs process indices (as of last check)

| Service | Index |
|---|---|
| ... | ... |
```

## Key conventions

### Prerequisites section
- List required services, feature flags, and seed data
- Include the exact mprocs batch command to start all needed services

### Credentials
- Always point to `.crush/hurl/vars.env` for hurl variables
- Explain how to get a fresh token from DevTools (copy `cookie` and `x-xsrf-token` from any GraphQL request)

### Test steps
- Number steps with `### Step A`, `### Step B`, etc. (not 1/2/3 — letters make it easier to insert steps later)
- Each step should have a single clear action and the exact command to run
- Include expected output or a screenshot command after each significant action

### Database operations
- Use **mycli** for all SQL queries — see the mycli-cli skill for connection strings
- Always show both the write query and a verification SELECT

### Browser automation
- Use **playwright-cli** commands, not manual browser instructions
- Always take a screenshot after significant interactions: `playwright-cli screenshot`
- Reference the playwright-cli skill for login boilerplate

### Commands
- All bash commands must be copy-pasteable with no substitution needed, or clearly mark placeholders as `<placeholder_name>`
- Prefer `hurl --variables-file .crush/http/vars.env` over inlining credentials

### Retailer reference table
- Always include at the bottom — makes it easy to find IDs without re-reading the whole doc

### mprocs indices table
- Always include — indices change occasionally, note "as of last check" so readers know to verify

## Example

See `.crush/runbooks/replace-status.md` in the monocle repo for a complete example.
