# Skills

Skills are domain-specific instructions that agents can discover and load on-demand.

## How Discovery Works

1. **Startup** - Crush walks the `skills/` directory looking for `SKILL.md` files
2. **System Prompt** - Only skill metadata (name, description, location) is injected into the prompt
3. **On-demand** - When a task matches a skill's description, the agent reads the full `SKILL.md`

This progressive disclosure prevents context window overload while making skills discoverable.

## Creating a Skill

### Directory Structure

```
skills/
  my-skill/
    SKILL.md           # Required - frontmatter + instructions
    scripts/           # Optional - executable tools
    references/        # Optional - additional context files
```

### SKILL.md Format

Every skill must have a `SKILL.md` file with YAML frontmatter:

```markdown
---
name: my-skill
description: Brief description of what the skill does and when to use it.
---

# My Skill

## Description
Detailed explanation of the skill.

## Commands
...

## When to Use
- Trigger condition 1
- Trigger condition 2
```

### Required Frontmatter Fields

| Field | Description | Constraints |
|-------|-------------|-------------|
| `name` | Skill identifier | 1-64 chars, lowercase, hyphens allowed, must match directory name |
| `description` | What the skill does and when to use it | 1-1024 chars, used for discovery |

### Optional Frontmatter Fields

| Field | Description |
|-------|-------------|
| `license` | License type (e.g., `Apache-2.0`) |
| `compatibility` | Environment requirements (max 500 chars) |
| `metadata` | Key-value pairs (author, version, etc.) |

## Tips

- **Description is key** - Write descriptions that clearly indicate when the skill should be used
- **Be specific** - Include trigger phrases like "Use when..." in the description
- **Keep instructions actionable** - Include concrete commands and examples in the body
- **Reference files** - If a skill needs additional context, add files to the skill directory and reference them

## Reference

Based on the [Anthropic Agent Skills Standard](https://agentskills.io/).
