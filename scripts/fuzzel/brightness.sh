#!/bin/dash

dir="$HOME/.config/hypr"
notify_cmd='notify-send -u low -h string:x-dunst-stack-tag:brightness'

get_brightness() {
	ddcutil getvcp 10 | awk '{print $9}' | sed 's/,//'
}

notify_user() {
	eval "$notify_cmd 'Brightness: $(get_brightness)%'"
}

set_brightness() {
	new_brightness="$1"
	ddcutil setvcp 10 "$new_brightness" && notify_user
}

new_brightness=$(fuzzel -d -w 32 --anchor top --y-margin 20 --prompt-only "Enter new brightness (0-100): " --config="$dir/fuzzel/fuzzel.ini")

# Check if input is a valid number and within range
if [ "$new_brightness" != "" ]; then
	if [ "$new_brightness" -ge 0 ] && [ "$new_brightness" -le 100 ]; then
		set_brightness "$new_brightness"
		pkill -SIGRTMIN+9 waybar
	else
		notify-send -u low -h string:x-dunst-stack-tag:brightness "Invalid input."
	fi
fi
