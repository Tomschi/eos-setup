#!/usr/bin/env bash

PKGS=(

#    'bleachbit'               # File deletion utility
#    'cmatrix'                 # The Matrix screen animation
#    'cronie'                  # cron jobs
#    'curl'                    # Remote content retrieval
#    'file-roller'             # Archive utility
    'btop'                    # System monitoring via terminal
#    'gufw'                    # Firewall manager
#    'hardinfo'                # Hardware info app
#    'htop'                    # Process viewer
    'fastfetch'                 # Shows system info when you launch terminal
    'fzf'
    'neovim'
#    'ntp'                     # Network Time Protocol to set time via network.
#    'numlockx'                # Turns on numlock in X11
#    'p7zip'                   # 7z compression program
#    'rsync'                   # Remote file sync utility
#    'speedtest-cli'           # Internet speed via terminal
    'stow'
#    'terminus-font'           # Font package with some bigger fonts for login terminal
#    'unrar'                   # RAR compression program
#    'unzip'                   # Zip compression program
#    'wget'                    # Remote content retrieval
#    'terminator'              # Terminal emulator
    'tmux'		       # Terminal emulator
#    'zenity'                  # Display graphical dialog boxes via shell scripts
#    'zip'                     # Zip compression program
    'zoxide'
    'zsh'                      # Interactive shell
#    'zsh-autosuggestions'     # Zsh Plugin
#    'zsh-syntax-highlighting' # Zsh Plugin

)

echo
echo "INSTALLING: ${PKGS[@]}"
sudo pacman -S --noconfirm --needed "${PKGS[@]}"

echo
echo "Done!"
echo
