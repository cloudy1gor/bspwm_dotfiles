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
  'shell-color-scripts'

  'xf86-video-amdgpu'

  'ttf-jetbrains-mono-nerd'
  'ttf-iosevka-nerd'
  'ttf-ms-win11-auto'
  
  'thunar'
  'thunar-archive-plugin'
  'thunar-megasync-bin'
  'gvfs'
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
  'cmus'
  'flameshot'
  'mpv'
  'obs-studio'
  'qbittorrent'
  'autorandr'
  'btop'

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
  
	'timeshift'
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
  'keepassxc-git'
)

for PKG in "${PKGS[@]}"; do
  echo "Installing: ${PKG}"
  yay -S "$PKG" --noconfirm --needed
done

sudo systemctl enable bluetooth
sudo systemctl start bluetooth
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service
sudo usermod -a -G libvirt $(whoami)
sudo systemctl restart libvirtd.service

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
