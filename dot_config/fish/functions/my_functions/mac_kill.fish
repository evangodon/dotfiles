function mac_kill --description "Kill an application on Macos"
    osascript -e 'tell application "System Events" to get name of every application process whose background only is false' \
      | tr -d ' ' \
      | tr ',' '\n' \
      | fzf --prompt="Select application to kill: " \
      | xargs -I {} sh -c 'killall "{}" && echo "{} has been killed successfully"'
end
