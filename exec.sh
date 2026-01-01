#!/usr/bin/env bash

# Exit on any error
set -e

# Get the directory where this script is located
EOS_SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for script in "$EOS_SETUP_DIR"/"01-pre"/*.sh; do
  "$script"
done

for script in "$EOS_SETUP_DIR"/"02-pacman"/*.sh; do
  "$script"
done

for script in "$EOS_SETUP_DIR"/"03-aur"/*.sh; do
  "$script"
done