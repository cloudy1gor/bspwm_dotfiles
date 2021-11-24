#!/bin/sh

sxhkd &
xrandr &&
xrdb -merge ~/.config/.Xresources &&
xset r rate 300 50
exec bspwm
