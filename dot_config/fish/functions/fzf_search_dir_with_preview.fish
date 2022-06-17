function fzf_search_dir_with_preview  --description "Search for a file in a directory with a preview and open with editor" 
    set dir $argv   
    set file (fd . $dir | fzf --preview-window noborder --delimiter $dir --with-nth -1  --height=95% --preview "preview_file_for_fzf {}")

    if test -n "$file";
      $EDITOR $file
    end

    commandline -f repaint
end

