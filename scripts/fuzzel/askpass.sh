#!/bin/dash

dir="$HOME/.config/hypr"

fuzzel -d -p "Password " --password -l 0 -P 0 --config="$dir/fuzzel/fuzzel.ini"
