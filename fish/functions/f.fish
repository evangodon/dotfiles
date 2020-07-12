# Defined in - @ line 1
function f --description 'Fuzzy search for a directory and cd into it.'
  set directory  (fd --type directory | fzf);

  if test -z "$directory";
    return
  end

  cd $directory;
end
