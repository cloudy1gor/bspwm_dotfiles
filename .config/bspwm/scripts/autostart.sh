#!/bin/bash

declare -a restart=( blueberry mictray kuro copyq plank flameshot telegram-desktop -startintray )
for i in "${restart[@]}"; do
    pgrep -x "$i" | xargs kill
    sleep 0.5
    eval "$i" &
done
