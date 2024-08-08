#!/bin/dash

# Launch key remapper
[ "$(pidof xremap)" != "" ] && pkill xremap && xremap "$HOME/.xremap.yml"
[ "$(pidof xremap)" = "" ] && xremap "$HOME/.xremap.yml"
