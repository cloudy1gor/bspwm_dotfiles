#!/bin/bash

declare -a loop=(copyq flameshot espanso blueberry plank)
for i in "${loop[@]}"; do
	killall -q "$i" | xargs kill
  sleep 1 & $i &
done

killall -q telegram-desktop
sleep 1 && telegram-desktop -startintray &
