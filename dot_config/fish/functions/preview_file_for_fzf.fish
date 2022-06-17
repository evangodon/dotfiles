function preview_file_for_fzf  --description "Preview for fzf" 
  set path $argv   

  # Check if path is directory
  if test -d $path;
    tree -l 2 $path
    return 
  end

  # If *.md, use glow 
  if string match -q -- "*.md" $path;
    command cat $path | glow --style dark -
    return 
  end

  # else use bat
  cat --color=always $path
end

