# Defined via `source`
function hear_myself --wraps='pactl load-module module-loopback latency_msec=1' --description 'alias hear_myself pactl load-module module-loopback latency_msec=1'
  pactl load-module module-loopback latency_msec=1 $argv; 
end
