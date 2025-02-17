#!/bin/env dash

dir="$HOME/.config/hypr"

run_command() {
  case "$1" in
  "Foot")
    "$dir/scripts/asroot.sh" foot -e
    ;;
  "Neovim")
    "$dir/scripts/asroot.sh" foot -e nvim
    ;;
  "Yazi")
    "$dir/scripts/asroot.sh" foot -e yazi
    ;;
  esac
}

options=" Foot\n Neovim\n󰇥 Yazi"
selected_option=$(echo "$options" | fuzzel -d \
  -l 3 \
  -p "Root " \
  --config="$dir/fuzzel/fuzzel.ini")
command=$(echo "$selected_option" | grep -o -E "[a-zA-Z]+")

run_command "$command"
