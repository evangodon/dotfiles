---
name: crush-cli
description: Use Crush CLI (`crush run`) to execute one-off AI coding tasks without opening an interactive session. Use for automated tasks, CI/CD, scripting, or when you need a quick answer without managing sessions.
---

# Crush Run Command Skill

## Description
The `crush run` command executes AI coding tasks non-interactively, perfect for automation, scripts, and one-off queries. It runs a single prompt, completes the task, and exits—no session management required.

## Basic Usage

```bash
# Execute a single task
crush run "explain this function"

# Use a specific model
crush run --model gpt-4o "optimize this code"

# Auto-approve all tool calls (no permission prompts)
crush run --yolo "run the tests and fix any failures"

# Use extended thinking (Claude models only)
crush run --think "analyze the architecture of this codebase"
```

## Command Flags

| Flag | Description |
|------|-------------|
| `--model <model-id>` | Specify which LLM model to use |
| `--yolo` | Auto-approve all tool calls (no permission prompts) |
| `--think` | Enable extended thinking mode (Claude models only) |
| `--debug` | Enable verbose debug logging |
| `--max-turns <n>` | Limit maximum conversation turns (default: no limit) |
| `--context <path>` | Add additional context file(s) |

## Examples

### Quick Code Explanations

```bash
# Explain specific code
crush run "explain what src/handler.go does"

# Analyze a function
crush run "document the processPayment function in detail"
```

### Automated Testing

```bash
# Run tests and report results
crush run --yolo "run all tests and summarize the results"

# Fix failing tests
crush run --yolo "run tests, fix any failures, and verify they pass"
```

### Code Generation

```bash
# Generate boilerplate
crush run "create a new REST endpoint for user management"

# Add features
crush run --yolo "add logging to all database operations"
```

### Code Analysis

```bash
# Find issues
crush run "check for potential security vulnerabilities"

# Review patterns
crush run "identify any repeated code that could be refactored"

# Use extended thinking for complex analysis
crush run --think "analyze the performance implications of the current caching strategy"
```

### Git Operations

```bash
# Create commits with auto-approval
crush run --yolo "stage and commit all changes with an appropriate message"

# Create PRs
crush run --yolo "create a pull request for the current branch"
```

### Refactoring

```bash
# Automated refactoring
crush run --yolo "rename all instances of 'user_id' to 'userId' across the codebase"

# Structural changes
crush run --yolo "extract the validation logic into a separate module"
```

### CI/CD Integration

```bash
# In CI pipeline
crush run --yolo --max-turns 10 "lint the code and fix any issues"

# Pre-commit hook
crush run --yolo "ensure all functions have docstrings"
```

### With Additional Context

```bash
# Add specific context files
crush run --context docs/api-spec.yaml "implement the new endpoints from the spec"

# Multiple context files
crush run --context ARCHITECTURE.md --context CONVENTIONS.md "refactor the auth module"
```

## Scripting Examples

### Bash Script

```bash
#!/bin/bash
# automated-review.sh

echo "Running automated code review..."
crush run --yolo "review all changed files for code quality issues" > review.txt

if grep -q "issue" review.txt; then
  echo "Issues found. See review.txt"
  exit 1
fi
```

### Fish Function

```fish
function auto-fix-tests
    crush run --yolo "run tests, fix failures, and commit the fixes"
end
```

### Make Target

```makefile
.PHONY: ai-review
ai-review:
	crush run --yolo "review the code and suggest improvements" > review.md
```

## Extended Thinking

Extended thinking mode (`--think`) enables deeper reasoning for complex tasks (Claude models only):

```bash
# Architecture analysis
crush run --think "evaluate different approaches for implementing the new feature"

# Performance optimization
crush run --think "analyze bottlenecks and propose optimization strategies"

# Design decisions
crush run --think "compare database schema options for the user permissions system"
```

## Important Notes

### Non-Interactive Mode
- `crush run` exits after completing the task
- No session is created or saved
- Perfect for automation and scripting

### Tool Permissions
- Without `--yolo`, Crush will prompt for permission for each tool call
- Use `--yolo` carefully—it auto-approves all actions including file modifications
- Consider setting `allowed_tools` in config for specific tools

### Model Selection
- If no `--model` is specified, uses your default model
- Model must support the features you're requesting (e.g., `--think` requires Claude)

### Context Limits
- Be mindful of token limits when working with large codebases
- Use `--context` to add specific relevant files
- Consider using `--max-turns` to prevent runaway token usage

## When to Use

- Running automated code analysis or linting
- CI/CD pipeline integrations
- Pre-commit or post-commit hooks
- Quick one-off coding questions
- Scripted refactoring tasks
- Automated testing and fixing
- When you don't need to manage conversations or sessions
- Batch processing multiple repositories or projects
