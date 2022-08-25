#!/bin/sh
# Toggle Touchpad
# source https://github.com/arifvn

CHOICE=$(echo -e "Enable Touchpad\nDisable Touchpad\nEnable Tap to Click\nDisable Tap to Click" | \
	rofi -dmenu -p Touchpad -config $HOME/.config/rofi/wifi.rasi)

case "$CHOICE" in
	'Enable Touchpad')
        synclient TouchpadOff=0;
					;;
	'Disable Touchpad')
        synclient TouchpadOff=1;
					;;
	'Enable Tap to Click')
				synclient TapButton1=1
					;;
	'Disable Tap to Click')
				synclient TapButton1=0
					;;
esac

