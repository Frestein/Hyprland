#!/bin/dash

dir="$HOME/.config/hypr"

state_file="$dir/.kill_confirmed"

if [ -f "$state_file" ]; then
  rm "$state_file"
  hyprctl dispatch killactive
else
  notify-send -u low -h string:x-dunst-stack-tag:killactive 'You want to close the window?'
  touch "$state_file"
  (sleep 3 && rm -f "$state_file") &
fi
