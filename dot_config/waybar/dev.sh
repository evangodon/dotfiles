# /bin/bash
#
# DOCS: https://github.com/Alexays/Waybar/wiki

watchexec -e jsonc,tmpl -- killall -SIGUSR2 waybar
