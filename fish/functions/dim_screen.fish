function dim_screen --wraps='redshift -0 3300 -P' --wraps='redshift -O 3300 -P' --description 'alias dim_screen redshift -O 3300 -P'
  redshift -O 3300 -P $argv; 
end
