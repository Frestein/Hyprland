#!/usr/bin/env bash

set -e
set -o pipefail

state=$(hyprctl -j clients)
active_window=$(hyprctl -j activewindow)

current_addr=$(jq -r '.address' <<<"$active_window")

window=$(jq -r '.[] | select(.monitor != -1 ) | "\(.address)\t\(.workspace.name)\t\(.title)@icon@\(.class)"' <<<"$state" |
    column -t -s $'\t' |
    sed -e "s|$current_addr|focused ->|" -e 's|@icon@|\x0icon\x1f|' |
    sort -r |
    fuzzel -d -p "Windows " -w 120 --config="$XDG_CONFIG_HOME/hypr/fuzzel/fuzzel.ini")

addr=$(awk '{print $1}' <<<"$window")
ws=$(awk '{print $2}' <<<"$window")

if [[ "$addr" =~ focused* ]]; then
    echo 'already focused, exiting'
    exit 0
fi

fullscreen_on_same_ws=$(jq -r ".[] | select(.fullscreen > 0)  | select(.workspace.name == \"$ws\") | .address" <<<"$state")

if [[ "$window" != "" ]]; then
    if [[ "$fullscreen_on_same_ws" == "" ]]; then
        hyprctl dispatch focuswindow address:"$addr"
    else
        # If we want to focus app_A and app_B is fullscreen on the same workspace,
        # app_A will get focus, but app_B will remain on top.
        # This monstrosity is to make sure app_A will end up on top instead.
        # XXX: doesn't handle fullscreen 0, but I don't care.
        hyprctl --batch "dispatch focuswindow address:${fullscreen_on_same_ws}; dispatch fullscreen 1; dispatch focuswindow address:${addr}; dispatch fullscreen 1"
    fi
fi
