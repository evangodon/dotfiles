set fish_greeting ""

# Keyboard Shortcuts
bind \co fzf

starship init fish | source

set -x FZF_DEFAULT_COMMAND "rg --files --hidden --glob \"!{node_modules,.git}\""

