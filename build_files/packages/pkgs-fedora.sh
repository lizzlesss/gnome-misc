#!/usr/bin/env bash

set -eoux pipefail

dnf remove -y \
    firefox

dnf remove -y --setopt=install_weak_deps=False \
    gnome-software

dnf install -y \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

dnf swap -y ffmpeg-free ffmpeg --allowerasing
dnf install -y @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin

dnf install -y \
    android-tools \
    intel-media-driver \
    mangohud \
    testdisk \
    qphotorec \
    https://github.com/nbfc-linux/nbfc-linux/releases/download/0.5.3/fedora-44-nbfc-linux-0.5.3-1.x86_64.rpm

# copr
dnf copr enable -y bieszczaders/kernel-cachyos-addons

# Adds required package for the scheduler
dnf install -y \
    --enablerepo="copr:copr.fedorainfracloud.org:bieszczaders:kernel-cachyos-addons" \
    --allowerasing \
    libbpf scx-scheds-git scx-tools-git scx-manager

dnf -y copr disable bieszczaders/kernel-cachyos-addons
