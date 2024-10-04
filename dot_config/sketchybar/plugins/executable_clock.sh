#!/usr/bin/env bash

source "$HOME/.config/sketchybar/styles.sh"

sketchybar --set $NAME label="$(date '+%I:%M%p   %a, %b %d' | sed 's/^0//')"

