# Defined in - @ line 1
function gts --description 'alias gts=systemctl suspend'
	systemctl suspend $argv;
end
