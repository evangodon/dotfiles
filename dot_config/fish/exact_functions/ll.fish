# Defined in - @ line 1
function ll --description 'alias ll to lsd -l or ls -alh'
  if type -q lsd
   lsd -al $argv;
  else
    ls -alh
  end
end
