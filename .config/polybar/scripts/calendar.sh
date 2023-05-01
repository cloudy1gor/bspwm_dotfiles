#!/bin/sh

BAR_HEIGHT=34  # polybar height
BORDER_SIZE=1  # border size from your wm settings
YAD_WIDTH=780  # 222 is minimum possible value
YAD_HEIGHT=330 # 193 is minimum possible value
DATE="$("|%a%|H:%M%")"

eval $(xwininfo -id $(xdotool getactivewindow) |
        sed -n -e "s/^ \+Absolute upper-left X: \+\([0-9]\+\).*/x=\1/p" \
           -e "s/^ \+Absolute upper-left Y: \+\([0-9]\+\).*/y=\1/p" \
           -e "s/^ \+Width: \+\([0-9]\+\).*/WIDTH=\1/p" \
           -e "s/^ \+Height: \+\([0-9]\+\).*/HEIGHT=\1/p")

case "$1" in
--popup)
    if [ "$(xdotool getwindowfocus getwindowname)" = "yad-calendar" ]; then
        exit 0
    fi

    pos_x=$(( $WIDTH + $x - $YAD_WIDTH - 12 ))
    # Y
    if [ "$Y" -gt "$((HEIGHT / 2))" ]; then #Bottom
        : $((pos_y = HEIGHT - YAD_HEIGHT - BAR_HEIGHT - BORDER_SIZE))
    else #Top
        : $((pos_y = BAR_HEIGHT + BORDER_SIZE))
    fi

    yad --calendar --undecorated --fixed --close-on-unfocus --no-buttons \
        --width="$YAD_WIDTH" --height="$YAD_HEIGHT" --posx="$pos_x" --posy="$pos_y" \
        --title="yad-calendar" --borders=0 >/dev/null &
    ;;
*)
    echo "$DATE"
    ;;
esac
