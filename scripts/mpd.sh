#!/bin/dash

[ "$(pidof mpd)" = "" ] && mpd && sleep 1 && mpd-mpris &
[ "$(pidof mpd-mpris)" = "" ] && mpd-mpris &
