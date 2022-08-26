#!/usr/bin/env bash

## Copyright (C) 2020-2022 Aditya Shakya <adi1090x@gmail.com>
## Everyone is permitted to copy and distribute copies of this file under GNU-GPL3

## Files and Directories
DIR="$HOME/.config/polybar"
SFILE="$DIR/system"
RFILE="$DIR/.system"
MFILE="$DIR/.module"

## Get system variable values for various modules
get_values() {
    CARD=$(light -L | grep 'backlight' | head -n1 | cut -d'/' -f3)
    BATTERY=$(upower -i `upower -e | grep 'BAT'` | grep 'native-path' | cut -d':' -f2 | tr -d '[:blank:]')
    ADAPTER=$(upower -i `upower -e | grep 'AC'` | grep 'native-path' | cut -d':' -f2 | tr -d '[:blank:]')
    INTERFACE=$(ip link | awk '/state UP/ {print $2}' | tr -d :)
}

## Write values to `system` file
set_values() {
    if [[ "$ADAPTER" ]]; then
        sed -i -e "s/adapter = .*/adapter = $ADAPTER/g" 						${SFILE}
    fi
    if [[ "$BATTERY" ]]; then
        sed -i -e "s/battery = .*/battery = $BATTERY/g" 						${SFILE}
    fi
    if [[ "$CARD" ]]; then
        sed -i -e "s/graphics_card = .*/graphics_card = $CARD/g" 				${SFILE}
    fi
    if [[ "$INTERFACE" ]]; then
        sed -i -e "s/network_interface = .*/network_interface = $INTERFACE/g" 	${SFILE}
    fi
}

## Launch Polybar with selected style
launch_bar() {
    CARD=$(light -L | grep 'backlight' | head -n1 | cut -d'/' -f3)
    INTERFACE=$(ip link | awk '/state UP/ {print $2}' | tr -d :)

    if [[ ! -f "$MFILE" ]]; then
        if [[ -z "$CARD" ]]; then
            sed -i -e 's/backlight/backlight/g' "$DIR"/config.ini
            elif [[ "$CARD" != *"intel_"* ]]; then
            sed -i -e 's/backlight/brightness/g' "$DIR"/config.ini
        fi

        if [[ "$INTERFACE" == e* ]]; then
            sed -i -e 's/network/ethernet/g' "$DIR"/config.ini
        fi
        touch "$MFILE"
    fi

    if [[ ! `pidof polybar` ]]; then
        killall -q polybar &
        while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

        if [[ $(xrandr -q | grep " connected" | cut -d ' ' -f1) ]]; then
            polybar -q top -c ~/.config/polybar/config.ini &
            polybar -q top_external -c ~/.config/polybar/config.ini &
        else
            polybar -q top -c ~/.config/polybar/config.ini &
        fi
    else
        polybar-msg cmd restart
    fi
}

# Execute functions
if [[ ! -f "$RFILE" ]]; then
    get_values
    set_values
    touch ${RFILE}
fi
launch_bar
