DIR="$HOME/.config/rofi"

rofi_command="rofi -theme $dir/powermenu.rasi"

uptime=$(uptime -p | sed -e 's/up //g')

# Options
shutdown=""
reboot=""
lock=""
suspend=""
logout="󰍃"

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | $rofi_command -p "UP - $uptime" -dmenu -selected-row 2)"
case $chosen in
    $shutdown)
    ans=$($HOME/.config/rofi/confirm.sh)
    if [[ $ans == "yes" ]] || [[ $ans == "YES" ]] || [[ $ans == "y" ]]; then
        systemctl poweroff
    elif [[ $ans == "no" ]] || [[ $ans == "NO" ]] || [[ $ans == "n" ]]; then
        exit
        else
            rofi -theme ~/.config/rofi/askpass.rasi
        fi
        ;;
    $reboot)
    ans=$($HOME/.config/rofi/confirm.sh)
    if [[ $ans == "yes" ]] || [[ $ans == "YES" ]] || [[ $ans == "y" ]]; then
        systemctl reboot
    elif [[ $ans == "no" ]] || [[ $ans == "NO" ]] || [[ $ans == "n" ]]; then
        exit
        else
            rofi -theme ~/.config/rofi/askpass.rasi
        fi
        ;;
    $lock)
        ~/.config/bspwm/scripts/i3lock-fancy/i3lock-fancy.sh
        ;;
    $suspend)
    ans=$($HOME/.config/rofi/confirm.sh)
    if [[ $ans == "yes" ]] || [[ $ans == "YES" ]] || [[ $ans == "y" ]]; then
        mpc -q pause
        amixer set Master mute
        betterlockscreen --suspend
        #betterlockscreen --suspend -u /usr/share/backgrounds/"$Background"
    elif [[ $ans == "no" ]] || [[ $ans == "NO" ]] || [[ $ans == "n" ]]; then
        exit
        else
            rofi -theme ~/.config/rofi/askpass.rasi
        fi
        ;;
    $logout)
    ans=$($HOME/.config/rofi/confirm.sh)
    if [[ $ans == "yes" ]] || [[ $ans == "YES" ]] || [[ $ans == "y" ]]; then
        bspc quit
    elif [[ $ans == "no" ]] || [[ $ans == "NO" ]] || [[ $ans == "n" ]]; then
        exit
        else
            rofi -theme ~/.config/rofi/askpass.rasi
        fi
        ;;
esac
