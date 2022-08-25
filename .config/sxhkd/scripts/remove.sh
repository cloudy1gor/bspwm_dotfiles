#!/bin/sh
# Remove installed packages (change to pacman/AUR helper of your choice)
# source: https://github.com/junegunn/fzf/wiki/Examples

yay -Qq | fzf -q "$1" --multi --preview 'yay -Qi {1}' --reverse --prompt="RemovePackage>" | xargs -ro yay -Rns
