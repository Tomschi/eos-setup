#!/usr/bin/env bash

# Exit on any error
set -e

# Get the directory where this script is located
EOS_SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for script in "$EOS_SETUP_DIR"/"01-pre"/*.sh; do
  "$script"
done

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

# initialize stow for dotfiles
stow --dir "$HOME/.local/share/dotfiles" --target "$HOME" .
stow --dir "$HOME/.local/share/dotfiles-kde" --target "$HOME" .

# change default shell to zsh
chsh -s /usr/bin/zsh