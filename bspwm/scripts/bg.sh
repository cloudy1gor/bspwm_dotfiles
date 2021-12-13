#/bin/bash

while true; do
        (( RANDOM%2 ==0 )) && feh --randomize --bg-fill ~/Изображения/2\ screens/* || feh --randomize --bg-fill ~/Изображения/*
        sleep 600
done