#!/bin/sh

bssid=$(nmcli device wifi list | sed -n '1!p' | cut -b 9- | rofi -dmenu -p "Select Wifi :" -theme ~/.config/rofi/wifi.rasi | cut -d' ' -f1)
pass=$(echo "" | rofi -dmenu -p "Enter pass : " -theme ~/.config/rofi/wifi.rasi)
nmcli device wifi connect $bssid password $pass
