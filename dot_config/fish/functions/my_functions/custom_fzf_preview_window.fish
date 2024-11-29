function custom_fzf_preview_window  --description "Preview for fzf" 
  set path $argv   

  # Check if path is directory
  if test -d $path;
    lsd --tree --color always  $path
    return 
  end

  # If *.md, use glow 
  if string match -q -- "*.md" $path;
    command cat $path | glow --style dark -
    return 
  end

  # else use cat
  cat --color=always $path
end

