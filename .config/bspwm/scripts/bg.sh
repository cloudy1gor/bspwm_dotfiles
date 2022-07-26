#!/bin/bash
killall -q feh

while true; do
	feh --bg-scale --randomize --no-fehbg ~/Pictures/Wallpapers/*
	sleep 15m
done 
