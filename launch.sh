#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar/colorblocks"

# Terminate already running bar instances
killall  polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
  
polybar -r -q monitor1 -c "$DIR"/config.ini &
polybar -r -q monitor2 -c "$DIR"/config.ini 2>/dev/null &
polybar -r -q monitor1-audio -c "$DIR"/config.ini 2>/dev/null &
polybar -r -q monitor2-audio -c "$DIR"/config.ini 2>/dev/null &
