#!/bin/bash

arr=("copyq" "flameshot" "plank")

    for value in ${arr[@]}
    do
    isExist=`ps -ef | grep "$value" | grep -v grep | wc -l`
    if [ $isExist == 0 ]
    then
    exec "$value" &
    fi
    done

    