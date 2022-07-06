#!/usr/bin/env bash

source "$HOME/.config/sketchybar/styles.sh"

sketchybar --set $NAME \
  icon=""            \
  icon.padding_left=$ICON_H_PADDING \
  label="$(date '+%I:%M   %a %d. %b')"

