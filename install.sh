#!/usr/bin/env bash

sudo clear

echo
echo "Installing Packages"
echo

PKGS=(
  'git'
  'curl'
  'wget'
  'bluez'
  'bluez-utils'
  'pulseaudio-bluetooth'
  'blueberry'
  'feh'
  'timeshift'
  'papirus-icon-theme'
  'neofetch'
  'acpi'
  'ranger'
  'openssh'
  'ueberzug'
  'neovim'
  'unrar'
  'unzip'
  'llpp'
  'capitaine-cursors'
  'zip'
  'zsh'
  'zsh-completions'
  'zsh-syntax-highlighting'
  'telegram-desktop'
  'discord'

  'transmission-qt'
  'copyq'
  'ncdu'

  'neovim'
  'nodejs-lts-fermium'
  'npm'
  'python'
  'yarn'

	'cmus'
  'flameshot'
  'mpv'         
)

for PKG in "${PKGS[@]}"; do
  echo "Installing: ${PKG}"
  sudo pacman -S "$PKG" --noconfirm --needed
done

cp -r .config .local ~/
