#!/bin/bash
#
UPDATES=$(/usr/lib/update-notifier/apt-check 2>&1| awk -F';' '{ sum=$1+$2; print sum }');

if (( UPDATES !=0 )); then
    alacritty --hold --command bash -c 'echo "Getting updaes..." && sudo apt update && sudo apt upgrade && echo "Finished updating"'
fi
