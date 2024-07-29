#!/bin/dash

dir="$HOME/.config/hypr"

"$dir/scripts/mpris_inhibitor.sh" || exit 1

hyprlock
