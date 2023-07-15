#!/bin/bash

declare -a restart=( safeeyes blueberry mictray kuro copyq espanso flameshot megasync )
for i in "${restart[@]}"; do
    pgrep -x "$i" | xargs kill
    sleep 0.5
    eval "$i" &
done

telegram-desktop --startintray &
