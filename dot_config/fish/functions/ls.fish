
function ls --description 'Wrap ls with lsd if it exists in path'
  if command -v lsd &>/dev/null;
    lsd $argv
    return
  end

  set real_ls (command -v ls)
  $real_ls $argv
end
