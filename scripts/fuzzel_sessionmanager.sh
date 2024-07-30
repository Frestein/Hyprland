#!/bin/dash

dir="$HOME/.config/hypr"

run_command() {
  case "$1" in
  "Logout")
    hyprctl dispatch exit
    ;;
  "Kill")
    hyprctl kill
    ;;
  "Lock")
    hyprlock
    ;;
  "Reload")
    hyprctl reload
    notify-send -u low -h string:x-dunst-stack-tag:screenshot -i /usr/share/archcraft/icons/dunst/picture.png "Config reloaded"
    ;;
  "Reboot")
    systemctl reboot
    ;;
  "Shutdown")
    systemctl poweroff
    ;;
  esac
}

options=$(echo "󰍃 Logout\n Kill\n Lock\n Reload\n Reboot\n Shutdown")
selected_option=$(echo "$options" | fuzzel -d \
  -l 6 \
  -p "Session " \
  --config="$dir/fuzzel/fuzzel.ini")
command=$(echo "$selected_option" | grep -o -E '[a-zA-Z]+')

run_command $command
