#!/bin/sh

sxhkd &
xrandr &&
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
xset r rate 300 50
exec bspwm >/tmp/bspwm-$(date +'%F-%k-%M-%S').log 2>&1

# Default terminal
export TERMINAL=/bin/kitty
