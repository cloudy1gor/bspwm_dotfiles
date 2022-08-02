#!/bin/sh

clear
sudo pacman -Syyuu
sudo timedatectl set-local-rtc 1 --adjust-system-clock

sudo pacman -S yay --noconfirm --needed

yay --editmenu --nodiffmenu --save

PKGS=(
	'git'
  'curl'
  'wget'
  'yad'
  'bluez'
  'bluez-utils'
  'pulseaudio-bluetooth'
  'blueberry'
  'brightnessctl'
  'feh'
  'timeshift'
  'micro'
  'papirus-icon-theme'
  'neofetch'
  'acpi'
  'ranger'
  'ueberzug'
  'neovim'
  'unrar'
  'unzip'
  'capitaine-cursors'
  'zip'
  'fish'
  'telegram-desktop'
  'discord'
  'brightnesctl'
  'feh'
  'capitaine-cursors'
  'ueberzug'
  'kitty'
  'telegram-desktop'
  'copyq'
  'ncdu'
  'cmus'
  'flameshot'
  'mpv'
  'obs-studio'
  'plank'
  'neovim'
  'qbittorrent'
  'autorandr'
  'bpytop'

  'lib32-mesa'
  'vulkan-radeon'
  'lib32-vulkan-radeon'
  'vulkan-icd-loader'
  'lib32-vulkan-icd-loader'

  'nodejs-lts-fermium'
  'npm'
  'python'
  'yarn'

	'librewolf-bin'
	'timeshift'
	'wedder'
	'espanso-bin'
  'picom-jonaburg-git'
  'redshift-minimal'
  'visual-studio-code-bin'
	'sublime-text-4'
	'figma-linux-bin'
  'google-chrome'
  'keepassxc-git'
  'koreader-bin'
  'zoom'
  'skypeforlinux-stable-bin'
  'ttf-jetbrains-mono'
  'ttf-joypixels'
  'nerd-fonts-noto-sans-regular-complete'
  '7-zip-full'
)

for PKG in "${PKGS[@]}"; do
  echo "Installing: ${PKG}"
  sudo yay -S "$PKG" --noconfirm --needed
done

sudo systemctl enable bluetooth
sudo systemctl start bluetooth

chsh -s /usr/bin/fish
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

fisher install IlanCosman/tide@v5
fisher install matchai/spacefish
fisher install jethrokuan/z


sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

sudo npm install --global gulp

sudo yay -Rs firefox xed meld dex

sudo yay -Yc

# cp -r .config .local ~/
