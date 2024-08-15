#!/bin/dash

dir="$HOME/.config/hypr"

state_file="$dir/.kill_confirmed"

if [ -f "$state_file" ]; then
  rm "$state_file"
  makoctl dismiss -g
  hyprctl dispatch killactive
else
  notify-send -u low -h string:x-dunst-stack-tag:killactive 'You want to close the window?'
  touch "$state_file"
  (sleep 2 && rm -f "$state_file") &
fi
