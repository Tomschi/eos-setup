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
git clone -b intitial github.com:Tomschi/dotfiles.git ~/.local/share/dotfiles
git clone -b intitial github.com:Tomschi/dotfiles-kde.git ~/.local/share/dotfiles-kde
git clone -b intitial github.com:Tomschi/eos-files.git ~/.local/share/eos-files
git clone -b intitial github.com:Tomschi/eos-packages.git ~/.local/share/eos-packages

# TODO: remove, only for script development
git clone -b intitial github.com:Tomschi/dotfiles-kde-orig.git ~/.local/share/dotfiles-kde-orig
git clone -b intitial github.com:Tomschi/eos-files-orig.git ~/.local/share/eos-files-orig
