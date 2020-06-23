set fish_greeting ""

bind \co ranger-cd

starship init fish | source

set -x FZF_DEFAULT_COMMAND "rg --files --hidden --glob \"!{node_modules,.git}\""

