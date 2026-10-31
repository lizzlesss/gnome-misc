#!/usr/bin/env bash

set -eoux pipefail

pacman -R --noconfirm power-profiles-daemon
pacman -Sy --noconfirm \
    scx-scheds \
    scx-tools \
    tuned \
    tuned-ppd \
    wget

wget https://github.com/nbfc-linux/nbfc-linux/releases/download/0.5.4/arch-linux-nbfc-linux-git-0.5.4-1-x86_64.pkg.tar.zst
pacman -U --noconfirm ./arch-linux-nbfc-linux-git-0.5.4-1-x86_64.pkg.tar.zst
