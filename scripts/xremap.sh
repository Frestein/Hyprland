#!/bin/dash

# Launch key remapper
[ -n "$(pidof xremap)" ] && pkill xremap && xremap "$HOME/.xremap.yml"
[ -z "$(pidof xremap)" ] && xremap "$HOME/.xremap.yml"
