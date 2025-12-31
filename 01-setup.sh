#!/usr/bin/env bash

# rank mirrors
sudo reflector -c AT,LU,DE,FR,ES,IT,CH --protocol https --sort score --latest 10 --save /etc/pacman.d/mirrorlist \
  && eos-rankmirrors