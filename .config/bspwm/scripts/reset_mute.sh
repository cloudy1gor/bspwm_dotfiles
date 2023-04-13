#!/usr/bin/env bash

sleep 3
amixer -D pipewire set Master off &
sleep 2
amixer -D pipewire set Master on &
