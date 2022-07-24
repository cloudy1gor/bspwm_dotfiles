#!/bin/bash
killall -q copyq flameshot plank espanso

blueberry &
plank &
sleep 1 && flameshot &
sleep 2 && copyq &    
sleep 3 && espanso &
sleep 3 && telegram-desktop -startintray &

