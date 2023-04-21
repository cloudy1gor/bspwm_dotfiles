#!/bin/bash

# Set the source and destination directories
src_dir="$HOME/Documents/bspwm_dotfiles/.config"
dst_dir="$HOME/.config"

# Loop through all the directories in the source directory
for dir in "$src_dir"/*/
do
    # Get the name of the directory
    dir_name=$(basename "$dir")
    
    # Check if the directory already exists in the destination directory
    if [ -d "$dst_dir/$dir_name" ]
    then
        # If it does, append a timestamp to the directory name
        timestamp=$(date +%Y%m%d%H%M%S)
        dir_name="$dir_name-$timestamp"
    fi
    
    # Copy the directory from the source to the destination directory
    cp -r "$dir" "$dst_dir/$dir_name"
done

# Loop through all the files in the source directory
for file in "$src_dir"/*
do
    # Get the name of the file
    file_name=$(basename "$file")
    
    # Check if the file already exists in the destination directory
    if [ -f "$dst_dir/$file_name" ]
    then
        # If it does, append a timestamp to the file name
        timestamp=$(date +%Y%m%d%H%M%S)
        file_name="$file_name-$timestamp"
    fi
    
    # Copy the file from the source to the destination directory
    cp -r "$file" "$dst_dir/$file_name"
done


