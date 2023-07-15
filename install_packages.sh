#!/bin/sh

clear
sudo pacman -Syyu
sudo pacman -S archlinux-keyring pacman-contrib
sudo timedatectl set-local-rtc 1 --adjust-system-clock

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

yay --editmenu --nodiffmenu --save

PKGS=(
	# Gpu drivers
	'amd-ucode'
  'xf86-video-amdgpu'
  'lib32-mesa'
  'vulkan-radeon'
  'lib32-vulkan-radeon'
  'vulkan-icd-loader'
  'lib32-vulkan-icd-loader'

  # WM & base packages
	'git'
  'xorg-xinput'
  'xorg-xsetroot'
  'curl'
  'wget'
  'wmname'
  'yad'
  'alsa-utils'
  'bluez'
  'bluez-utils'
  'pulseaudio-bluetooth'
  'blueberry'
  'brightnessctl'
  'pavucontrol'
  'micro'
  'kitty'
  'fish'
  'feh'
  'autorandr'
  'bspwm'
  'sxhkd'
  'polybar'
  'rofi'
  'dunst'
  'picom-ftlabs-git'
  'redshift-minimal'
  'safeeyes'
  'wedder'
  'ksuperkey'
  'xbanish'
  'unclutter'
  'copyq'
  'xsettingsd'
  'betterlockscreen'
  'tlp'
  'tlp-rdw'
  'powertop'
  'ufw'
  'iptables'

	# Fonts, icons, cursors, themes
  'ttf-jetbrains-mono-nerd'
  'ttf-iosevka-nerd'
  'ttf-ms-win11-auto'
  'papirus-icon-theme'
  'papirus-folders'
  'capitaine-cursors'
  'whitesur-gtk-theme'

  # File manager & utils
  'thunar'
  'thunar-archive-plugin'
  'xarchiver'
  'gvfs'
  'gvfs-mtp'
  'tumbler'
  'ffmpegthumbnailer'
  'tumbler-folder-thumbnailer'
  'webp-pixbuf-loader'
  'unrar'
  'unzip'
  'zip'
  'p7zip-gui'
  'ranger'
  'ueberzug'
  'ntfs-3g'
  'gksu'

	# Media
  'mpv'
  'mpd'
  'ncmpcpp'
  'cava'

	# Browsers
 	'librewolf-bin'
  'ungoogled-chromium-xdg-bin'
  'vivaldi'

  # Social
  'telegram-desktop'
  'discord'
  'skypeforlinux-stable-bin'
  'zoom'

	# Dev apps
  'neovim'
  'visual-studio-code-bin'
  'phpstorm'
  'docker'
  'docker-compose'
  'git'
  'diff-so-fancy'
  'jre-openjdk'
  'nodejs-lts-fermium'
  'npm'
  'nvm'
  'yarn'
  'php'
  'phpstan'
  'phpmd'
  'composer'
  'mycli'
  'mariadb'
  'pgcli'
  'postgresql'
  'litecli'

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

  # Gaming
  # 'wine'
  # 'wine-mono'
  # 'wine-gecko'
  'portproton'

  # Graphics Utilities
  'gimp'
  'kdenlive'
  'shotcut'
  'handbrake'
  'upscayl-bin'

  # Other
  'fzf'
  'scrcpy'
  'gparted'
  'timeshift'
  'neofetch'
  'acpi'
  'ncdu'
  'flameshot'
  'obs-studio'
  'qbittorrent'
  'gotop-bin'
	'espanso-bin'
	'figma-linux-bin'
  'obsidian'
  'koreader-bin'
  'peaclock'
  'syncthing'
  'veracrypt'
  'libreoffice-fresh'
  'ventoy-bin'
  'stacer-bin'
  'bleachbit'
  'keepassxc'
)

for PKG in "${PKGS[@]}"; do
  echo "Installing: ${PKG}"
  yay -S "$PKG" --noconfirm --needed
done

papirus-folders -C bluegrey
sudo ufw enable
sudo systemctl enable ufw.service
sudo ufw allow ssh
sudo systemctl enable paccache.timer
sudo systemctl enable tlp.service
sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket
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

sudo npm install --global gulp webpack

# Give execution permission for all scripts in the directory
chmod -R +x ~/.config

git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim

# Tool for optimizing battery life
git clone https://github.com/AdnanHodzic/auto-cpufreq.git
cd auto-cpufreq && sudo ./auto-cpufreq-installer
sudo auto-cpufreq --install

tide configure

sudo yay -Yc

