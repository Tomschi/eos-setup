#!/usr/bin/env bash

# rank mirrors
sudo reflector -c AT,LU,DE,FR,ES,IT,CH --protocol https --sort score --latest 10 --save /etc/pacman.d/mirrorlist \
  && eos-rankmirrors

# update pacman db
sudo pacman -Syu --noconfirm && sudo grub-mkconfig -o /boot/grub/grub.cfg

# set XDG user directories lower case
mv ~/Desktop ~/desktop && xdg-user-dirs-update --set DESKTOP ~/desktop
mv ~/Documents ~/documents && xdg-user-dirs-update --set DOCUMENTS ~/documents
mv ~/Downloads ~/downloads && xdg-user-dirs-update --set DOWNLOAD ~/downloads
mv ~/Music ~/music && xdg-user-dirs-update --set MUSIC ~/music
mv ~/Pictures ~/pictures && xdg-user-dirs-update --set PICTURES ~/pictures
mv ~/Public ~/public && xdg-user-dirs-update --set PUBLICSHARE ~/public
mv ~/Templates ~/templates && xdg-user-dirs-update --set TEMPLATES ~/templates
mv ~/Videos ~/videos && xdg-user-dirs-update --set VIDEOS ~/videos