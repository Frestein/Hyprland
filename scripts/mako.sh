#!/bin/dash

dir="$HOME/.config/hypr"

[ "$(pidof mako)" = "" ] && mako --config="$dir/mako/nord.ini" &
[ "$(pidof mako)" != "" ] && makoctl reload &
