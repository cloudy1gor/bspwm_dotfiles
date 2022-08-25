#!/bin/sh
# Clean system (pacman and yay)
# source https://github.com/arifvn 

echo "[ * Let's clean your system ]"

echo " "

echo "Clean cached packages(/var/cache/pacman/pkg/)?
 1) Not currently installed
 2) Including currently installed
(default 1): ";read cached

echo "Clean orphan packages?
 1) Yes
 2) No
(default 1): ";read orphans

case $cached in
    1   )  sudo pacman -Sc;;
    2   )  sudo pacman -Scc;;
    *   )  sudo pacman -Sc;;
esac

ORPHAN_QUANTITY=$(pacman -Qtdq | wc -l)

if [[ $ORPHAN_QUANTITY -gt 0 ]]; then
    case $orphans in
        Yes|1  )  sudo pacman -Rns $(pacman -Qtdq);;
        No|2   )  continue;;
        *      )  sudo pacman -Rns $(pacman -Qtdq);;
    esac
fi

