
function pomo --description 'start a pomodoro timer'
  if ! type -q timer  
  echo "timer not installed"
  echo "Install here 'https://github.com/caarlos0/timer'"
    return
  end

  timer 10 && notify "Work session done" 
end
