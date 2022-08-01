#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar
polybar top -c ~/.config/polybar/config.ini &

if [[ $(xrandr -q | grep 'HDMI-1 connected') ]]; then
    killall -q polybar &
    while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

    polybar -r top -c ~/.config/polybar/config.ini &
    polybar -r top_external -c ~/.config/polybar/config.ini &
fi
