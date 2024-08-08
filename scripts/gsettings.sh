#!/bin/dash

config="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-3.0/settings.ini"
if [ ! -f "$config" ]; then
  exit 1
fi

gnome_schema="org.gnome.desktop.interface"
icon_theme="$(grep 'gtk-icon-theme-name' "$config" | sed 's/.*\s*=\s*//')"
font_name="$(grep 'gtk-font-name' "$config" | sed 's/.*\s*=\s*//')"
gsettings set "$gnome_schema" icon-theme "$icon_theme"
gsettings set "$gnome_schema" font-name "$font_name"
gsettings set org.gnome.desktop.wm.preferences button-layout "" # Remove window buttons
