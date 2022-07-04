#!/usr/bin/env sh

source "$HOME/.config/sketchybar/styles.sh"

sketchybar --set $NAME \
  icon=""            \
  icon.color=$PRIMARY_COLOR  \
  icon.padding_left=$ICON_H_PADDING \
  label="$(date '+%I:%M %d.%m')"

