function fish_user_key_bindings
  fzf_key_bindings
  bind \eg 'test -d .git; and git checkout (string trim -- (git branch | fzf)); and commandline -f repaint'
  bind \eG 'test -d .git; and git checkout (string trim -- (git branch --all | fzf)); and commandline -f repaint'
end
