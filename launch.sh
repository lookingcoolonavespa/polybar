#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar/colorblocks"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
  
polybar -r -q monitor1 -c "$DIR"/config.ini &
polybar -r -q dummy1 -c "$DIR"/config.ini &
polybar -r -q monitor2 -c "$DIR"/config.ini &
polybar -r -q dummy2 -c "$DIR"/config.ini &
