set fish_greeting ""

# Keyboard Shortcuts
bind \co fzf

if type -q starship
  starship init fish | source
end


set -x FZF_DEFAULT_COMMAND "rg --files --hidden --glob \"!{node_modules,.git}\""

