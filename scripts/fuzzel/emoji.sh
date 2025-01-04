#!/bin/dash

dir="$HOME/.config/hypr"

rofimoji --prompt "Emoji " --action clipboard --clipboarder wl-copy --selector-args="--config=$dir/fuzzel/fuzzel.ini"
