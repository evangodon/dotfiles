
#------- Prompt ---------#
if type -q starship
  starship init fish | source
end

#------- Greeting ---------#
set fish_greeting  # remove fish default greeting


#------- Source my functions in the nested functions folder ---------#
for func in $__fish_config_dir/functions/my_functions/*.fish
    source $func
end


#------- Environment variables ---------#

# Set default editor
set -gx EDITOR nvim

# use main editor for reading manpages
set -gx MANPAGER "$EDITOR +Man!"
set -gx MANWIDTH 999 

# Set path for kb cli
set -gx KB_PATH /home/evan/notes/knowledge-base

#------- FZF ---------#
# Use https://minsw.github.io/fzf-color-picker/
source $__fish_config_dir/fzf.fish

#------- Abbreviations ---------#
source $__fish_config_dir/abbr.fish

#------- Keybindings ---------#
if command -v chezmoi >/dev/null 2>&1;
  set chezmoi_source (chezmoi source-path)
  bind \ch "cd $chezmoi_source && custom_fzf_search_dir --directory=$chezmoi_source && cd -"
end

bind \cn search_zk_notebooks 
bind \co "nvim ." 


#------- Aliases ---------#
alias nfz custom_fzf_search_dir
alias reload_fish_config "source $__fish_config_dir/config.fish"
alias openpr "gh pr view --web"



# Secrets 
if test -e $__fish_config_dir/.env.local
    source $__fish_config_dir/.env.local
end

switch (uname)
    case Linux
    # Show snap packages in rofi launcher
    set -gx XDG_DATA_DIRS /usr/share/:/usr/local/share/:/var/lib/snapd/desktop

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


# Created by `pipx` on 2023-03-17 16:47:03
set PATH $PATH /Users/evan.godon/.local/bin

alias assume="source (brew --prefix)/bin/assume.fish"
