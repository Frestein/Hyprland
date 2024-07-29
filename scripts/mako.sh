#!/bin/dash

dir="$HOME/.config/hypr"

# Launch notification daemon
[ -z "$(pidof mako)" ] && mako --config="$dir/mako/config" &
[ -n "$(pidof mako)" ] && makoctl reload &
