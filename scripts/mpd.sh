#!/bin/dash

[ -z "$(pidof mpd)" ] && mpd && sleep 1 && mpd-mpris &
[ -z "$(pidof mpd-mpris)" ] && mpd-mpris &
