#!/bin/env dash

dir="$HOME/.config/hypr"

[ "$(printf "Yes\nNo" | fuzzel -d -w 16 -l 2 --config="$dir/fuzzel/fuzzel.ini" -p "Close Window? ")" = "Yes" ] && hyprctl dispatch killactive
