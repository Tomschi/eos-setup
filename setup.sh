#!/usr/bin/env bash

# Exit on any error
set -e

# Get the directory where this script is located
EOS_SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# rank mirrors
sudo reflector -c AT,LU,DE,FR,ES,IT,CH --protocol https --sort rate --latest 10 --save /etc/pacman.d/mirrorlist \
  && eos-rankmirrors

# update pacman db
sudo pacman -Syu --noconfirm # && sudo grub-mkconfig -o /boot/grub/grub.cfg

# setup btrfs
"$EOS_SETUP_DIR/btrfs/setup-btrfs.sh"

# set XDG user directories lower case
mv ~/Desktop ~/desktop && xdg-user-dirs-update --set DESKTOP ~/desktop
mv ~/Documents ~/documents && xdg-user-dirs-update --set DOCUMENTS ~/documents
mv ~/Downloads ~/downloads && xdg-user-dirs-update --set DOWNLOAD ~/downloads
mv ~/Music ~/music && xdg-user-dirs-update --set MUSIC ~/music
mv ~/Pictures ~/pictures && xdg-user-dirs-update --set PICTURES ~/pictures
mv ~/Public ~/public && xdg-user-dirs-update --set PUBLICSHARE ~/public
mv ~/Templates ~/templates && xdg-user-dirs-update --set TEMPLATES ~/templates
mv ~/Videos ~/videos && xdg-user-dirs-update --set VIDEOS ~/videos

# create user container directory in /var/lib
sudo mkdir -p /var/lib/$USER/containers
sudo chown -R $USER:$USER /var/lib/$USER

# clone repositories
# TODO: final version should use main branch
git clone -b initial github.com:Tomschi/dotfiles.git "$HOME/.local/share/dotfiles"
git clone -b initial github.com:Tomschi/dotfiles-kde.git "$HOME/.local/share/dotfiles-kde"
git clone -b initial github.com:Tomschi/eos-files.git "$HOME/.local/share/eos-files"
git clone -b initial github.com:Tomschi/eos-packages.git "$HOME/.local/share/eos-packages"

# TODO: remove, only for script development
git clone -b initial github.com:Tomschi/dotfiles-kde-orig.git "$HOME/.local/share/dotfiles-kde-orig"
git clone -b initial github.com:Tomschi/eos-files-orig.git "$HOME/.local/share/eos-files-orig"


# install packages
"$HOME/.local/share/eos-packages/sync-packages.sh"
sudo grub-mkconfig -o /boot/grub/grub.cfg

# copy system files
"$HOME/.local/share/eos-files/exec.sh"

sudo systemctl enable --now  yabsnap.timer

# initialize stow for dotfiles
stow --dir "$HOME/.local/share/dotfiles" --target "$HOME" .
stow --dir "$HOME/.local/share/dotfiles-kde" --target "$HOME" .

# change default shell to zsh
sudo chsh -s /usr/bin/zsh "$USER"