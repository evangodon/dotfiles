function custom_fzf_search_dir  --description "Search for a file in a directory with a preview and open with editor" 
    set options_spec 'directory=?' 'extension=?'
    argparse $options_spec -- $argv

    set -l dir (pwd)
    set -l extension_flag 
    set -q _flag_extension && set -l extension_flag --extension $_flag_extension
    set -q _flag_directory && set -l dir $_flag_directory

    set_color blue; echo "Searching files in $dir"
    set file (fd . $extension_flag $dir | fzf --preview-window noborder \
                              --delimiter $dir --with-nth -1 \
                              --height=85% \
                              --margin=0,3,0,1 \
                              --preview "custom_fzf_preview_window {}")

    if test -n "$file";
      $EDITOR $file
    end

    commandline -f repaint
  return
end

