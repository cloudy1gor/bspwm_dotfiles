#!/bin/sh

sxhkd &
xrandr &&
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
xset r rate 300 50 &
xsettingsd &
exec bspwm &

# Default terminal
export TERMINAL=/bin/kitty
