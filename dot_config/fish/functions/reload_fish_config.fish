function reload_fish_config --wraps='source ~/.config/fish/config.fish' --description 'alias reload_fish_config source ~/.config/fish/config.fish'
  source ~/.config/fish/config.fish $argv; 
end
