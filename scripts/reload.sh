#!/bin/dash

hyprctl reload
pkill -SIGUSR2 waybar
notify-send -u low -h string:x-dunst-stack-tag:hypr-reload 'Config reloaded'

