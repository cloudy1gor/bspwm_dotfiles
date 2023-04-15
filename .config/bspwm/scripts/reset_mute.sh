#!/usr/bin/env bash

sleep 1
amixer -D pipewire set Master off &
sleep 1
amixer -D pipewire set Master on &
