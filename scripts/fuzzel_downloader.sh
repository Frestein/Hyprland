#!/bin/dash
# A fuzzel utility to download files from various sites & types
#
# Requirements:
# - wl-clipboard: for clipboard access (wl-paste)
# - yt-dlp: for downloading videos and audio from various sites
# - aria2: for fast downloading (external downloader)
# - fuzzel: a fuzzy finder menu similar to rofi for selecting directories and options
#
# Ensure all dependencies are installed before running the script.

fuzzel_opts="-d --config $HOME/.config/hypr/fuzzel/fuzzel.ini"

error_notify() {
  local message="$1"
  echo "$message"
  notify-send -u low -h string:x-dunst-stack-tag:downloader "$message"
}

# Check for required commands
command -v wl-paste >/dev/null || {
  error_notify "Error: wl-clipboard is not installed."
  exit 1
}
command -v yt-dlp >/dev/null || {
  error_notify "Error: yt-dlp is not installed."
  exit 1
}
command -v aria2c >/dev/null || {
  error_notify "Error: aria2 is not installed."
  exit 1
}
command -v fuzzel >/dev/null || {
  error_notify "Error: fuzzel is not installed."
  exit 1
}

# Get Link
if [ -z "$1" ]; then
  link=$(wl-paste)
else
  link="$1"
fi

# Check if link is empty
if [ -z "$link" ]; then
  error_notify "Error: No link provided. Please provide a link as an argument or copy it to the clipboard."
  exit 1
fi

# Validate if the link is a valid URL
if ! echo "$link" | grep -qE '^(http|https)://'; then
  error_notify "Error: The provided input is not a valid URL."
  exit 1
fi

echo "Link: $link"

# Get Directory
if [ -z "$2" ]; then
  # Add your own directories below
  dirlist=$(find $HOME/Documents/Books $HOME /var/games -type d -maxdepth 1 ! -name '.*' 2>/dev/null)
  dir=$(echo "$dirlist" | fuzzel -p "Download to: " $fuzzel_opts)
  [ -z "$dir" ] && exit 1
  if [ ! -d "$dir" ]; then
    create_directory_option=$(printf "No\nYes" | fuzzel -p "$dir does not exist. Create it? " -l 2 $fuzzel_opts)
    if [ "$create_directory_option" = "Yes" ]; then
      mkdir -p "$dir" || {
        error_notify "Error: Failed to create directory '$dir'."
        exit 1
      }
    fi
  fi
else
  dir="$2"
fi

[ -z "$dir" ] && exit 1
echo "Directory: $dir"
cd "$dir" || {
  error_notify "Error: Failed to change directory to '$dir'."
  exit 1
}

# Log the download attempt
echo "$link\t$dir\t#$(date)" >>~/.downloader_history

# Sort & Download
yttest=$(yt-dlp -e --abort-on-error "$link" 2>/dev/null)
if [ $? -eq 0 ]; then
  echo "Downloader: Youtube-dl"
  type=$(echo "Video\nAudio" | fuzzel -p "Download Type: " -l 2 $fuzzel_opts)
  if [ "$type" = "Video" ]; then
    echo "Downloading Video"
    file=$(yt-dlp -ic --add-metadata "$link" --abort-on-error --external-downloader aria2c --external-downloader-args "-x 16 -s 16 -k 1M" -o "%(title)s.%(ext)s" --get-filename --no-simulate)
  elif [ "$type" = "Audio" ]; then
    echo "Downloading Audio"
    file=$(yt-dlp -xic --add-metadata "$link" --abort-on-error --external-downloader aria2c --external-downloader-args "-x 16 -s 16 -k 1M" -o "%(title)s.%(ext)s" --get-filename --no-simulate)
  fi
else
  echo "Downloader: Aria2c"
  if command -v aria2c >/dev/null; then
    aria2c "$link" -x 16 -s 16 -k 1M
  fi
fi

# Notify if download was successful
if [ -z "$file" ]; then
  notify-send "Error: No file was downloaded."
elif [ -e "$dir/$file" ] && [ -s "$dir/$file" ]; then
  notify-send "Download completed: '$file'."
else
  notify-send "Download aborted."
fi
exit 0
