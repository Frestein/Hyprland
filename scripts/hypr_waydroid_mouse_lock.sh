#!/bin/dash

dir="$HOME/.config/hypr"

if [ "$(pidof hypr-roblox-lock)" = "" ]; then
  notify-send -u low -h string:x-dunst-stack-tag:hypr-roblox-lock 'Mouse Lock activated'
  "$dir/scripts/hypr-roblox-lock"
else
  killall hypr-roblox-lock
  notify-send -u low -h string:x-dunst-stack-tag:hypr-roblox-lock 'Mouse Lock deactivated'
fi
