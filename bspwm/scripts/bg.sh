#/bin/bash

while true; do
        rm -ir /home/clo/.fehbg
        feh --randomize --bg-fill ~/Изображения/*
        sleep 300
done
