#!/bin/dash

time=$(date +%Y-%m-%d_%H:%M:%S)
screenshots_dir="$(xdg-user-dir PICTURES)/Screenshots"
file="Screenshot_${time}.png"

if [ ! -d "$screenshots_dir" ]; then
	mkdir -p "$screenshots_dir"
fi

countdown() {
	seq "$1" -1 1 | while read -r sec; do
		notify-send -t 1000 -h string:x-dunst-stack-tag:screenshot "Taking shot in: $sec"
		sleep 1
	done
}

shot() {
	mode="$1"
	shift
	extra_args="$*"
	hyprshot -m "$mode" --raw --freeze "$extra_args" | satty --filename - --output-filename "$screenshots_dir/$file"
}

shotnow() {
	shot output -m HDMI-A-2
}

shotdelayed() {
	countdown "$1"
	sleep 0.5
	shot output -m HDMI-A-2
}

shotwin() {
	shot window
}

shotactive() {
	shot window -m active
}

shotarea() {
	shot region
}

if [ "$1" = "--now" ]; then
	shotnow
elif [ "$1" = "--delay" ] && [ "$2" -ge 1 ] && [ "$2" -le 9 ]; then
	shotdelayed "$2"
elif [ "$1" = "--win" ]; then
	shotwin
elif [ "$1" = "--active" ]; then
	shotactive
elif [ "$1" = "--area" ]; then
	shotarea
else
	echo "Available options: --now --delay [1-9] --win --active --area"
fi

exit 0
