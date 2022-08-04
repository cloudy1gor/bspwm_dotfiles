#!/bin/bash

declare -a loop=(plank copyq flameshot espanso blueberry)
for i in "${loop[@]}"; do
	killall -q "$i" | xargs kill
  sleep 1 & $i &
done

killall -q telegram-desktop
sleep 1 && telegram-desktop -startintray &
