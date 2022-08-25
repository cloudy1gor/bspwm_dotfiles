#!/bin/sh
# Generate randow password.
# source https://my-take-on.tech/2020/07/03/some-tricks-for-sxhkd-and-bspwm/#generate-a-random-password-to-clipboard

tr -dc "a-zA-Z0-9_#@.-" < /dev/urandom | head -c 14 | xclip -selection clipboard && \
	notify-send "Password Generated!" 

