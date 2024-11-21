
function cat --description 'Wrap cat with bat if it exists in path'
  if command -v bat &>/dev/null;
    bat $argv
    return
  end

  set realcat (command -v cat)
  $realcat $argv
end
