#!/bin/dash

dir="$HOME/.config/hypr"

# Export sudo askpass helper
export SUDO_ASKPASS="$dir/scripts/fuzzel_askpass.sh"

# Execute the application
sudo -A env XDG_RUNTIME_DIR="$XDG_RUNTIME_DIR" WAYLAND_DISPLAY="$WAYLAND_DISPLAY" XDG_SESSION_TYPE="$XDG_SESSION_TYPE" "$@"
