#!/bin/dash

notify_cmd='notify-send -u low -h string:x-dunst-stack-tag:brightness'

get_brightness() {
	ddcutil getvcp 10 | awk '{print $9}' | sed 's/,//'
}

notify_user() {
	eval "$notify_cmd 'Brightness: $(get_brightness)%'"
}

inc_brightness() {
	ddcutil setvcp 10 + 25 && notify_user
}

dec_brightness() {
	ddcutil setvcp 10 - 25 && notify_user
}

# Execute accordingly
if [ "$1" = "--get" ]; then
	get_brightness
elif [ "$1" = "--inc" ]; then
	inc_brightness
	pkill -SIGRTMIN+9 waybar
elif [ "$1" = "--dec" ]; then
	dec_brightness
	pkill -SIGRTMIN+9 waybar
else
	echo "$(get_brightness)"% && notify_user
fi
