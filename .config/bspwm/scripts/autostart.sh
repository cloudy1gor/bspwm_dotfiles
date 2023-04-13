#!/bin/bash

declare -a restart=( blueberry mictray kuro copyq flameshot telegram-desktop )
for i in "${restart[@]}"; do
    pgrep -x "$i" | xargs kill
    sleep 0.5
    eval "$i" &
done

