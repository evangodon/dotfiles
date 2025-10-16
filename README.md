# `dotfiles`

My config files managed by [chezmoi](https://www.chezmoi.io/)

## `Setup on a New Machine`

### 1. Install Chezmoi and Apply Dotfiles

```sh
# Install chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)"

# Initialize and apply dotfiles
chezmoi init --apply evangodon
```

### 2. Install Development Tools with Mise

[Mise](https://mise.jdx.dev/) is used to manage all development tools and CLI utilities across macOS and Linux.

```sh
# Run the bootstrap script to install Mise and all tools
./scripts/bootstrap_mise.sh
```

This will install all tools defined in `.mise.toml` including:
- bat, fd, fzf, ripgrep (modern CLI tools)
- neovim, lazygit, lazydocker (development tools)
- starship, stylua, jq (utilities)

### 3. Activate Mise in Your Shell

Add the following to your shell configuration:

**For Fish (already configured in `dot_config/fish/config.fish`):**
```fish
mise activate fish | source
```

**For Bash/Zsh:**
```bash
eval "$(mise activate bash)"  # or zsh
```

### 4. Terminal Setup

1. Install [kitty](https://sw.kovidgoyal.net/kitty/binary/#install-kitty)

2. Install [fish shell](https://fishshell.com/)

3. Install [fisher](https://github.com/jorgebucaran/fisher) 

4. Install a Nerd Font from https://www.nerdfonts.com/font-downloads

## `Managing Packages`

### Adding a New Tool

1. Add the tool to `.mise.toml`:
   ```toml
   [tools]
   your-tool = "latest"  # or specify a version like "1.2.3"
   ```

2. Install it:
   ```sh
   mise install
   ```

### Updating Tools

```sh
# Update all tools to their latest versions
mise upgrade

# Update a specific tool
mise upgrade neovim
```

### Checking Installed Tools

```sh
# List all installed tools and their versions
mise list

# Check which tools are available
mise ls-remote <tool-name>
```
 
