#!/bin/sh
# Install packages using yay (change to pacman/AUR helper of your choice)
# source: https://github.com/junegunn/fzf/wiki/Examples

yay -Sl | awk '{print $1,$2($4=="" ? "" : " *")}' | fzf --multi --preview='yay -Si {2}' --prompt="InstallPackages>" | awk '{print $2}' | xargs -ro yay -Sy

