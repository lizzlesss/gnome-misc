#!/usr/bin/env bash

set -eoux pipefail

pacman -Syu --noconfirm
pacman -R --noconfirm power-profiles-daemon
pacman -Sy --noconfirm \
    intel-lpmd \
    scx-scheds \
    scx-tools \
    tuned \
    tuned-ppd \
    wget

wget https://github.com/nbfc-linux/nbfc-linux/releases/download/0.5.3/arch-linux-nbfc-linux-git-0.5.3-1-x86_64.pkg.tar.zst
pacman -U --noconfirm ./arch-linux-nbfc-linux-git-0.5.3-1-x86_64.pkg.tar.zst
