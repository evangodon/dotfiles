---
title: Kitty Terminal 
---
Links: [[040_Computer]]

# Kitty

## Useful commands
**shows current config**
`kitty --debug-config` 

**To change colour theme without restarting kitty**
`kitty @ set-colors <THEME CONF FILE HERE>`

To connect to another computer and avoid the "unknown terminal" error
`kitty +kitten ssh myserver`

To update Kitty
`curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin`

To list all installed fonts 
`kitty list-fonts`
