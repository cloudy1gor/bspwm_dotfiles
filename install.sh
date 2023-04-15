#!/bin/sh

clear
sudo pacman -Syyu
sudo pacman -S archlinux-keyring
sudo timedatectl set-local-rtc 1 --adjust-system-clock

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

yay --editmenu --nodiffmenu --save

PKGS=(
	'git'
  'curl'
  'wget'
  'wmname'
  'yad'
  'micro'
  'kitty'
  'fish'
  'feh'
  'awesome'

	# Gpu drivers
  'xf86-video-amdgpu'

	# Fonts
  'ttf-jetbrains-mono-nerd'
  'ttf-iosevka-nerd'
  'ttf-ms-win11-auto'

  # File manager & utils
  'thunar'
  'thunar-archive-plugin'
  'thunar-megasync-bin'
  'gvfs'
  'gvfs-mtp'
  'tumbler'
  'ffmpegthumbnailer'
  'tumbler-folder-thumbnailer'
  'unrar'
  'unzip'
  'zip'
  '7-zip-full'
  'ranger'
  'ueberzug'
  'ntfs-3g'
  'gksu'

	# Media
  'mpv'
  'mpd'
  'ncmpcpp'
  'mpc'
  'cava'
  'musikcube-bin'

	# Browsers
 	'librewolf-bin'
  'google-chrome'
  
  'lxappearance'
  'xsettingsd'
  'alsa-utils'
  'bluez'
  'bluez-utils'
  'pulseaudio-bluetooth'
  'blueberry'
  'brightnessctl'
  'timeshift'
  'papirus-icon-theme'
  'neofetch'
  'acpi'
  'capitaine-cursors'
  'telegram-desktop'
  'discord'
  'brightnesctl'
  'feh'
  'capitaine-cursors'
  'telegram-desktop'
  'copyq'
  'ncdu'
  'flameshot'
  'obs-studio'
  'qbittorrent'
  'autorandr'
  'btop'
  'htop'

	# Dev apps
  'neovim'
  'visual-studio-code-bin'
  'phpstorm'
  'jre-openjdk'
  'nodejs-lts-fermium'
  'npm'
  'python'
  'yarn'
  'php'
  'docker'

	# VM
  'qemu-full'
  'virt-manager'
  'virt-viewer'
  'dnsmasq'
  'vde2'
  'bridge-utils'
  'openbsd-netcat'
  'ebtables'
  'iptables'
  'libguestfs'

  # Other
	'wedder'
	'espanso-bin'
  'picom-jonaburg-git'
  'redshift-minimal'
	'figma-linux-bin'
  'obsidian'
  'koreader-bin'
  'zoom'
  'skypeforlinux-stable-bin'
  'peaclock'
  'ksuperkey'
  'mictray'
  'syncthing'
  'khal'
  'keepassxc-git'
)

for PKG in "${PKGS[@]}"; do
  echo "Installing: ${PKG}"
  yay -S "$PKG" --noconfirm --needed
done

sudo systemctl enable --now bluetooth
sudo systemctl enable --now libvirtd.service
sudo usermod -a -G libvirt $(whoami)
sudo systemctl restart libvirtd.service
systemctl --user enable --now mpd.service

chsh -s /usr/bin/fish
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

fisher install PatrickF1/fzf.fish
fisher install IlanCosman/tide@v5
fisher install jethrokuan/z

sudo npm install --global gulp

# Give execution permission for all scripts in the directory
chmod -R +x ~/.config

git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim

tide configure

sudo yay -Yc

# cp -r .config .local ~/
