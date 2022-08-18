#!/bin/sh

CHEZMOI_SOURCE_DIR={{ .chezmoi.sourceDir }}

# Set gum variable to correct binary
{{ if eq .chezmoi.os "linux" -}}

gum=$CHEZMOI_SOURCE_DIR/bin/gum_amd64

{{ else if eq .chezmoi.os "darwin" -}}

gum=$CHEZMOI_SOURCE_DIR/bin/gum_macos

{{ end -}}


log_info() {
  $gum style --foreground "#89b4fa" "○ $1"  
  echo ""
}

log_success() {
  $gum style --foreground "#a6e3a1" "✔ $1"  
  echo ""
}

log_error() {
  $gum style --foreground "#f38ba8" "✘ $1"  
  echo ""
}
