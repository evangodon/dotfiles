
function notify --description 'Send a desktop notification'
  printf '\x1b]99;;%s\x1b\\' $argv
end
