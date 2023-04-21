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
        # If it does, rename it with a timestamp
        timestamp=$(date +%Y%m%d%H%M%S)
        mv "$dst_dir/$dir_name" "$dst_dir/$dir_name.$timestamp"
    fi
    
    # Copy the directory from the source to the destination directory
    cp -r "$dir" "$dst_dir"
done

