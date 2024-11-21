function httpcodes --wraps='cat ./httpcodes.txt | fzf' --description 'alias httpcodes cat ./httpcodes.txt | fzf'
  cat ~/.config/fish/functions/httpcodes.txt | fzf $argv; 
end
