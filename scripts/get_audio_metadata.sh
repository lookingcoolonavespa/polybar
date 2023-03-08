#!/bin/bash
#
PLAYERCTL_PLAYING="$(playerctl metadata --format '{{ artist }} - {{ title }}' 2>/dev/null)"
EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    PLAYING=$PLAYERCTL_PLAYING
else
    PLAYING=""
fi

echo "${PLAYING}"

