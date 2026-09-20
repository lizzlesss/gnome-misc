#!/usr/bin/env bash

set -eoux pipefail

pacman -Syu --noconfirm
pacman -R --noconfirm power-profiles-daemon
pacman -Sy --noconfirm \
    intel-lpmd \
    intel-media-driver \
    linux-firmware-intel \
    scx-scheds \
    scx-tools \
    starship \
    tuned \
    tuned-ppd \
    vpl-gpu-rt \
    vulkan-intel \
    wget

wget https://github.com/nbfc-linux/nbfc-linux/releases/download/0.5.3/arch-linux-nbfc-linux-git-0.5.3-1-x86_64.pkg.tar.zst
pacman -U --noconfirm ./arch-linux-nbfc-linux-git-0.5.3-1-x86_64.pkg.tar.zst
