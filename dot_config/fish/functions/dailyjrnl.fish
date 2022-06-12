# Defined in - @ line 1
function dailyjrnl --description 'Create daily jrnl entry'
  jrnl work < ~/work/lane-notes/jrnl/daily-jrnl-template.txt && jrnl work -1 --edit;
end
