#!/bin/sh
# source https://github.com/rxyhn

# You can call this script like this:
# $./volume up
# $./volume down
# $./volume mute

DIR="$HOME/.config/dunst"

function get_volume {
      amixer -D pipewire get Master | grep '%' | head -n 1 | awk -F'[' '{print $2}' | awk -F'%' '{print $1}'
}

function is_mute {
      amixer -D pipewire get Master | grep '%' | grep -oE '[^ ]+$' | grep off
}

function send_notification {
  volume=`get_volume`
  bar=$(seq -s "─" 0 $(($volume / 5)) | sed 's/[0-9]//g')
  if [ "$volume" = "0" ]; then
    icon_name="$DIR/icons/volume-mute.svg"
    bar=""
  else
    if [  "$volume" -lt "10" ]; then
      icon_name="$DIR/icons/volume.svg"
    else
      if [ "$volume" -lt "30" ]; then
        icon_name="$DIR/icons/volume.svg"
      else
        if [ "$volume" -lt "70" ]; then
          icon_name="$DIR/icons/volume.svg"
        else
          icon_name="$DIR/icons/volume.svg"
        fi
      fi
    fi
  fi
  # Send the notification
  # dunstify " Volume " "$bar" -i $icon_name -r 5555 -u normal
  dunstify "Volume $volume% " -i $icon_name -r 5555 -u normal -h int:value:$(($volume))
}

case $1 in
  up)
    # Unmute
	  amixer -D pipewire set Master on > /dev/null
	  # +5%
	  amixer -D pipewire set Master 5%+ > /dev/null
    send_notification
    ;;
  down)
    # Unmute
	  amixer -D pipewire set Master on > /dev/null
    # -5%
	  amixer -D pipewire set Master 5%- > /dev/null
    send_notification
    ;;
  mute)
    # Toggle mute
	  amixer -D pipewire set Master toggle > /dev/null
    if is_mute ; then
      icon_name="$DIR/icons/volume-mute.svg"
      dunstify "Mute" -i $icon_name -r 5555 -u normal -h int:value:0
    else
      send_notification
    fi
    ;;
esac
