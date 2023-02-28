#!/bin/bash

# The name of polybar bar which houses the main audio module and the control modules.
PARENT_BAR="main"
PARENT_BAR_PID=$(pgrep -a "polybar" | grep "$PARENT_BAR" | cut -d" " -f1)

# Set the source audio player here.
# Players supporting the MPRIS spec are supported.
# Examples: audio, vlc, chrome, mpv and others.
# Use `playerctld` to always detect the latest player.
# See more here: https://github.com/altdesktop/playerctl/#selecting-players-to-control
PLAYER="audio"

# Format of the information displayed
# Eg. {{ artist }} - {{ album }} - {{ title }}
# See more attributes here: https://github.com/altdesktop/playerctl/#printing-properties-and-metadata
FORMAT="{{ title }} - {{ artist }}"

# Sends $2 as message to all polybar PIDs that are part of $1
update_hooks() {
        polybar-msg hook audio-play-pause $2 1>/dev/null 2>&1
}

hide() {
    polybar-msg action "#audio.module_hide" 1>/dev/null 2>&1
    polybar-msg action "#audio-play-pause.module_hide" 1>/dev/null 2>&1
    polybar-msg action "#audio-next.module_hide" 1>/dev/null 2>&1
    polybar-msg action "#audio-prev.module_hide" 1>/dev/null 2>&1
}
show() {
    polybar-msg action "#audio.module_show" 1>/dev/null 2>&1
    polybar-msg action "#audio-play-pause.module_show" 1>/dev/null 2>&1
    polybar-msg action "#audio-next.module_show" 1>/dev/null 2>&1
    polybar-msg action "#audio-prev.module_show" 1>/dev/null 2>&1
}

PLAYERCTL_STATUS=$(playerctl  status 2>/dev/null)
EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    STATUS=$PLAYERCTL_STATUS
    show
else
    STATUS="..."
    hide
fi

if [ "$1" == "--status" ]; then
    echo "$STATUS"
else
    if [ "$STATUS" = "Stopped" ]; then
        echo "No music is playing"
    elif [ "$STATUS" = "Paused"  ]; then
        update_hooks "$PARENT_BAR_PID" 2
        playerctl metadata --format "$FORMAT"
    elif [ "$STATUS" = "..."  ]; then
        echo "$STATUS"
    else
        update_hooks "$PARENT_BAR_PID" 1
        playerctl metadata --format "$FORMAT"
    fi
fi
