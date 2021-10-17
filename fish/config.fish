
#------- Prompt ---------#
if type -q starship
  starship init fish | source
end

# Remove welcome message
set fish_greeting



#------- FZF ---------#
bind \co fzf

if type -q fzf_configure_bindings
    fzf_configure_bindings --directory=\cp
end

if type -q rg
    set -x FZF_DEFAULT_COMMAND "rg --files --hidden --glob \"!{node_modules,.git}\""
end


#------- Environment variables ---------#

# Set default editor
set -gx EDITOR (type -p nvim)

# nvm
set -gx nvm_default_version 14 

# PNPM
set -gx PNPM_HOME "/home/evan/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH

# Show snap packages in rofi launcher
set -gx XDG_DATA_DIRS /usr/share/:/usr/local/share/:/var/lib/snapd/desktop
