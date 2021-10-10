# Keyboard Shortcuts
bind \co fzf

if type -q starship
  starship init fish | source
end

# Remove welcome message
set fish_greeting


if type -q rg
    set -x FZF_DEFAULT_COMMAND "rg --files --hidden --glob \"!{node_modules,.git}\""
end

