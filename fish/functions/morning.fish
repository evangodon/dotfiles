# Defined in - @ line 1
function morning --description 'Alias for creating morning jrnl entry'
  jrnl morning < ~/work/lane-notes/jrnl/morning-template.md && jrnl morning -1 --edit $argv;
end
