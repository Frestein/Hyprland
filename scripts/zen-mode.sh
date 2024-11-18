#!/bin/dash

state_file="$HOME/.zen_mode_state"

if [ -f "$state_file" ]; then
  hyprctl keyword general:gaps_in 5
  hyprctl keyword general:gaps_out 12
  hyprctl keyword decoration:rounding 0
  hyprctl keyword animations:enabled true

  pkill -SIGUSR1 waybar

  makoctl mode -r do-not-disturb

  rm "$state_file"
else
  hyprctl keyword general:gaps_in 0
  hyprctl keyword general:gaps_out 0
  hyprctl keyword decoration:rounding 0
  hyprctl keyword animations:enabled false

  pkill -SIGUSR1 waybar

  makoctl mode -a do-not-disturb

  touch "$state_file"
fi
