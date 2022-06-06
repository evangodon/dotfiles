
#------- Prompt ---------#
if type -q starship
  starship init fish | source
end

#------- Greeting ---------#
set fish_greeting  # remove fish default greeting

# Display panes  FIXME
# if not set -q NVIM_LISTEN_ADDRESS
#     $__fish_config_dir/panes 
# end



#------- FZF ---------#
bind \co fzf

if type -q fzf_configure_bindings
    fzf_configure_bindings --directory=\cp
end

if type -q rg
    set -x FZF_DEFAULT_COMMAND "rg --files --hidden --glob \"!{node_modules,.git}\""
    set -Ux FZF_DEFAULT_OPTS "--color=bg+:#302D41,bg:#1E1E2E,spinner:#F8BD96,hl:#F28FAD --color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96 --color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD"
end


#------- Environment variables ---------#

# Set default editor
set -gx EDITOR (type -p nvim)

# nvm
if type -q (which node)
  set -gx nvm_default_version 16
end

# Set path for kb cli
set -gx KB_PATH /home/evan/notes/knowledge-base

# PNPM
set -gx PNPM_HOME "/home/evan/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH

# Show snap packages in rofi launcher
set -gx XDG_DATA_DIRS /usr/share/:/usr/local/share/:/var/lib/snapd/desktop

# Secrets 
if test -e $__fish_config_dir/.env.local
    source $__fish_config_dir/.env.local
end

# GoLang
set GOROOT '/Users/evan.godon/.go'
set GOPATH '/Users/evan.godon/go'
set PATH $GOPATH/bin $GOROOT/bin $PATH

switch (uname)
    case Linux
      return
    case Darwin
      # Homebrew
      set -gx HOMEBREW_PREFIX "/opt/homebrew";
      set -gx HOMEBREW_CELLAR "/opt/homebrew/Cellar";
      set -gx HOMEBREW_REPOSITORY "/opt/homebrew";
      set -q PATH; or set PATH '';
      set -gx PATH "/opt/homebrew/bin" "/opt/homebrew/sbin" $PATH;
      set -q MANPATH; or set MANPATH '';
      set -gx MANPATH "/opt/homebrew/share/man" $MANPATH;
      set -q INFOPATH; or set INFOPATH '';
      set -gx INFOPATH "/opt/homebrew/share/info" $INFOPATH;
end



