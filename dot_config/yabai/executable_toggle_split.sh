#! /usr/bin/env sh

# make this file executable using:
#     chmod +x /path/to/this/script
# create a signal using: 
#     yabai -m signal --add event=window_created action="/path/to/this/script"

# get the window id of the newly created window
wid="${2}"

# if the split is horizontal, toggle it to vertical
# yabai -m query --windows --window "${wid}" | jq -re '.split == "horizontal"' \
#  && yabai -m window "${wid}" --toggle split
yabai -m window --toggle split
