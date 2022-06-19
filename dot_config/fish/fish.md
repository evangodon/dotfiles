# Fish

Don't install default fzf keybindings, use keybindings from `PatrickF1/fzf.fish`

To check keybindings: `bind`


## keybindings
- `Crtr`+`p`: Search history
- `Crtr`+`r`: Search history
- `Crtr`+`g`: Search git commits
- `Crtr`+`v`: Search env variables
- `Crtl`+`h`: Search the chezmoi source files
- `Crtl`+`n`: Search notes in knowledge base

- `CTRL`+`z`: Put a job in the background
- `fg`: Bring last job or specific job to foreground

# To add to $PATH:
`fish_add_path /path/to/add`

# To install all `fisher` plugins
`fisher install (cat fish_plugins)`

# Start without reading config
`fish --no-config`

# Safe to commit to git
- `config.fish`
- `fish_plugins`
- `completions`


