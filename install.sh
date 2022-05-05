#!/usr/bin/env bash

sudo clear
sudo pacman -Syyuu
sudo timedatectl set-local-rtc 1 --adjust-system-clock

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
  'micro'
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
  'wedder'
  'capitaine-cursors'
  'zip'
  'fish'
  'telegram-desktop'
  'discord'
  'vivaldi'
  'brightnesctl'
  'feh'
  'capitaine-cursors'
  'ueberzug'
  'kitty'
  'telegram-desktop'
  'llpp'
  'qbittorrent-nox'
  'copyq'
  'ncdu'
  'cmus'
  'flameshot'
  'mpv'
  'zoom'
  'sublime-text-4'
  'obs-studio'
  'plank'
  'neovim'

  'lib32-mesa'
  'vulkan-radeon'
  'lib32-vulkan-radeon'
  'vulkan-icd-loader'
  'lib32-vulkan-icd-loader'

  'nodejs-lts-fermium'
  'npm'
  'python'
  'yarn'
)

for PKG in "${PKGS[@]}"; do
  echo "Installing: ${PKG}"
  sudo pacman -S "$PKG" --noconfirm --needed
done

chsh -s /usr/bin/fish

git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

sudo npm install --global typescript gulp

git clone https://aur.archlinux.org/pikaur.git
cd pikaur
makepkg -fsri

PKGSP=(
  'picom-jonaburg-git'
  'redshift-minimal'
  'snapd'
  'visual-studio-code-bin'
  'google-chrome'
  'keepassxc-git'
  'ttf-jetbrains-mono'
  'ttf-joypixels'
  'nerd-fonts-noto-sans-regular-complete'
)

for PKG in "${PKGSP[@]}"; do
  echo "Installing: ${PKG}"
  sudo pikaur -S "$PKG" --noconfirm --needed
done

sudo systemctl enable --now snapd.socket
sudo snap install btop

sudo pacman -R firefox

cp -r .config .local ~/
