#!/bin/dash

STATE_FILE="$HOME/.zen_mode_state"

if [ -f "$STATE_FILE" ]; then
  hyprctl keyword general:gaps_in 5
  hyprctl keyword general:gaps_out 12
  hyprctl keyword decoration:rounding 6
  hyprctl keyword animations:enabled true

  pkill -SIGUSR1 waybar

  makoctl mode -r do-not-disturb

  rm "$STATE_FILE"
else
  hyprctl keyword general:gaps_in 0
  hyprctl keyword general:gaps_out 0
  hyprctl keyword decoration:rounding 0
  hyprctl keyword animations:enabled false

  pkill -SIGUSR1 waybar

  makoctl mode -a do-not-disturb

  touch "$STATE_FILE"
fi
