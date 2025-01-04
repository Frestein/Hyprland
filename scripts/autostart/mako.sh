#!/bin/dash

dir="$HOME/.config/hypr"

[ "$(pidof mako)" = "" ] && mako --config="$dir/mako/config" &
[ "$(pidof mako)" != "" ] && makoctl reload &
