#!/bin/dash

dir="$HOME/.config/hypr"

run_command() {
  case "$1" in
  "Logout")
    hyprctl dispatch exit
    ;;
  "Lock")
    hyprlock
    ;;
  "Kill")
    hyprctl kill
    ;;
  "Reload")
    hyprctl reload
    pkill -SIGUSR2 waybar
    notify-send -u low -h string:x-dunst-stack-tag:screenshot "Config reloaded"
    ;;
  "Reboot")
    systemctl reboot
    ;;
  "Shutdown")
    systemctl poweroff
    ;;
  esac
}

options="󰗽 Logout\n Lock\n󰯈 Kill window\n Reload\n Reboot\n Shutdown"
selected_option=$(echo "$options" | fuzzel -d \
  -l 6 \
  -p "Session " \
  --config="$dir/fuzzel/fuzzel.ini")
command=$(echo "$selected_option" | grep -o -E "[a-zA-Z]+")

run_command "$command"
