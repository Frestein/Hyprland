#!/bin/env dash

dir="$HOME/.config/hypr"

cliphist list | fuzzel -d -p "Clipboard " --config="$dir/fuzzel/fuzzel.ini" --tabs 1 | cliphist decode | wl-copy
