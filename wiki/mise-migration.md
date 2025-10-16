# Migration to Mise

This document explains the migration from Homebrew-based package management to Mise.

## What Changed

### Before
- Packages were listed in `scripts/packages.txt` and `scripts/packages.linux.txt`
- Installation was done via `scripts/install_packages.mac.sh` or `scripts/install_packages.arch.sh`
- Packages were installed globally via Homebrew or system package managers
- No version pinning or project-specific tool versions

### After
- All development tools are defined in `.mise.toml` at the repository root
- Installation is done via `mise install` (cross-platform)
- Tools are managed per-user in `~/.local/share/mise`
- Version pinning is supported (currently set to "latest" for all tools)
- Mise is automatically activated in Fish shell via `config.fish`

## Tools Migrated to Mise

The following tools from `packages.txt` have been migrated to `.mise.toml`:
- bat
- bpytop
- fd
- fzf
- jq
- lazydocker
- lazygit
- neovim
- ripgrep
- starship
- stylua

## Tools NOT Migrated

Some tools were not migrated because they either:
1. Don't have Mise plugins available
2. Are better managed by system package managers
3. Require further investigation

These tools remain in the old `packages.txt` for reference:
- broot (no mise plugin found)
- fish (shell - better installed via system package manager)
- github-cli (gh - available as `github-cli` in mise if needed)
- glow (no mise plugin found)
- lsd (no mise plugin found)
- ncdu (no mise plugin found)
- slides (no mise plugin found)
- tldr (available as `tlrc` in mise if needed)
- difftastic (no mise plugin found)
- zk (no mise plugin found)

**Action Required:** These tools should either:
1. Continue to be installed via Homebrew/system package manager
2. Have Mise plugins created/found and added to `.mise.toml`
3. Be removed if no longer needed

## How to Use Mise

### First Time Setup
```bash
# Install Mise and all tools
./scripts/bootstrap_mise.sh
```

### Daily Usage
```bash
# Install all tools from .mise.toml
mise install

# Add a new tool
mise use bat@latest

# Update all tools
mise upgrade

# List installed tools
mise list
```

### Adding a New Tool
1. Check if a plugin exists: `mise ls-remote <tool-name>`
2. Add to `.mise.toml`:
   ```toml
   [tools]
   your-tool = "1.2.3"  # or "latest"
   ```
3. Run `mise install`

## Rollback Plan

If you need to rollback to the old system:
1. `git checkout main`
2. Run `./scripts/install_packages.mac.sh` (or `.arch.sh` on Linux)
3. Remove Mise activation from Fish config if desired

## Next Steps

1. Test the migration on a clean machine or VM
2. Decide what to do with the non-migrated tools
3. Consider pinning specific versions instead of "latest" for critical tools
4. Update `.chezmoiignore` if needed to exclude Mise cache directories
