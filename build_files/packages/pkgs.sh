#!/usr/bin/env bash

set -eoux pipefail

pacman -Sy --noconfirm \
    intel-lpmd \
    scx-scheds \
    scx-tools \
    wget

wget https://github.com/nbfc-linux/nbfc-linux/releases/download/0.5.3/arch-linux-nbfc-linux-git-0.5.3-1-x86_64.pkg.tar.zst
pacman -U --noconfirm ./arch-linux-nbfc-linux-git-0.5.3-1-x86_64.pkg.tar.zst
