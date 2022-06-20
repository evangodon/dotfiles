function yr  --description "Find a npm script with fzf and yarn run it" 
  if ! test -e  ./package.json
    echo "No package.json found"
    return 
  end
    
  set script_line (cat package.json | jq .scripts | sed '1d;' | fzf --height 100% $argv)

  if test -z "$script_line";
    echo "No script chosen"
    return
  end

  set script (string split \": $script_line | string trim --left | string replace -a -r \" '')

  yarn run $script[1]
end
