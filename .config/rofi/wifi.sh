#!/bin/sh

# ┬ ┬┬┌─┐┬
# ││││├┤ │
# └┴┘┴└  ┴

# Author	Niraj
# Github	niraj998

# ┬─┐┌─┐┌─┐┬  ┌─┐┌─┐┌┐┌┌─┐┬┌─┐┌─┐
# ├┬┘│ │├┤ │  │  │ ││││├┤ ││ ┬└─┐
# ┴└─└─┘└  ┴  └─┘└─┘┘└┘└  ┴└─┘└─┘

# rofi config without entry so to make select from available options only
rofiprompt=~/.config/rofi/wifi.rasi

options="-location 3 -xoffset -34 -yoffset 82 -m primary"
# ┌─┐┌┬┐┌─┐┌┬┐┬ ┬┌─┐
# └─┐ │ ├─┤ │ │ │└─┐
# └─┘ ┴ ┴ ┴ ┴ └─┘└─┘

# Power Status
flag=$(cat /sys/class/net/wl*/flags)

if [ "$flag" = "0x1003" ]; then
    power="On"
else
    power="Off"
fi

# Connection Status
state=$(cat /sys/class/net/wl*/operstate)

if [ "$state" = "up" ]; then
    status=$(nmcli | grep "^wlp" | sed 's/\ connected\ to/Connected to/' | cut -d ':' -f2)
else
    status="Disconnected"
fi

# ┌─┐┌─┐┬ ┬┌─┐┬─┐
# ├─┘│ ││││├┤ ├┬┘
# ┴  └─┘└┴┘└─┘┴└─

powertoggle=$( [ "$flag" = "0x1003" ] && echo "Power Off" || echo "Power On" )

powerswitch() {
    if [ "$powertoggle" = "Power Off" ]; then
        nmcli radio wifi off
        elif [ "$powertoggle" = "Power On" ]; then
        nmcli radio wifi on
    fi
}

# ┌─┐┌─┐┌┐┌┌┐┌┌─┐┌─┐┌┬┐
# │  │ │││││││├┤ │   │
# └─┘└─┘┘└┘┘└┘└─┘└─┘ ┴

connections() {
    list=$(nmcli --fields "SECURITY,SSID" device wifi list | tail -n +2 | sed "s/  */ /g" | sed -E "s/WPA*.?/󰍁/g" | sed "s/^--/󰿇/g" | sed "s/󰍁 󰍁/󰍁/g")
    networks=$(printf "$list" | rofi -config $rofiprompt -dmenu -i -p "Select Wifi Network
    $status" $options)
    wifi=$( echo "$networks" | sed "s/󰿇 //g" | sed "s/󰍁 //g" | xargs)
    [ -z "$networks" ] && exit
    nopass="No Password"
    pass=$(printf "$nopass\nCancel" | rofi -config $rofiprompt -dmenu -i -password -p "Wifi Password" $options)

    if [ "$pass" = "" ]; then
        exit
        elif [ "$pass" = "$nopass" ]; then
        nmcli dev wifi con "$wifi" && printf "Exit" | rofi -config $rofiprompt -dmenu -i -p "Successfully Connected to $wifi" $options && exit
        elif [ "$pass" = "Cancel" ]; then
        exit
    else
        nmcli dev wifi con "$wifi" password "$pass" &&  printf "Exit" | rofi -config $rofiprompt -dmenu -i -p "Successfully Connected to $wifi" $options && exit
    fi

    printf "Exit" | rofi -config $rofiprompt -dmenu -i -p "Failed to Connect $wifi" $options && exit
}


# ┌┬┐┌─┐┌┐┌┬ ┬┌─┐┬
# │││├─┤││││ │├─┤│
# ┴ ┴┴ ┴┘└┘└─┘┴ ┴┴─┘

manual() {

    wifi=$(rofi -config $rofiprompt -dmenu -i -p "Enter Wifi Name" $options)


    [ -z "$wifi" ] && exit
    nopass="Run Without Password"
    pass=$(printf "$nopass\nCancel" | rofi -config $rofiprompt -dmenu -i -password -p "Wifi Password" $options)

    if [ "$pass" = "" ]; then
        exit
        elif [ "$pass" = "$nopass" ]; then
        nmcli dev wifi con "$wifi" && printf "Exit" | rofi -config $rofiprompt -dmenu -i -p "Successfully Connected to $wifi" $options && exit
        elif [ "$pass" = "Cancel" ]; then
        exit
    else
        nmcli dev wifi con "$wifi" password "$pass" &&  printf "Exit" | rofi -config $rofiprompt -dmenu -i -p "Successfully Connected to $wifi" $options && exit
    fi

    printf "Exit" | rofi -config $rofiprompt -dmenu -i -p "Failed to Connect $wifi" $options && exit
}

# ┌─┐┌─┐┌┬┐┬┌─┐┌┐┌┌─┐
# │ │├─┘ │ ││ ││││└─┐
# └─┘┴   ┴ ┴└─┘┘└┘└─┘

options1="$powertoggle\nConnections\nConnect Manually"

rofiwifi=$(printf "$options1" | rofi -config $rofiprompt -dmenu -i -p "Wifi
Powered: $power
Status: $status" $options)


case $rofiwifi in
    $powertoggle)
        powerswitch
    ;;
    Connections)
        notify-send "Scanning"
        connections
    ;;
    "Connect Manually")
        manual
esac 2>/dev/null
