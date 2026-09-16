#!/usr/bin/env bash

set -eoux pipefail

dnf install -y \
    intel-lpmd \
    android-tools \
    mangohud \
    https://github.com/nbfc-linux/nbfc-linux/releases/download/0.5.3/fedora-44-nbfc-linux-0.5.3-1.x86_64.rpm

# copr
dnf copr enable -y bieszczaders/kernel-cachyos-addons

# Adds required package for the scheduler
dnf install -y \
    --enablerepo="copr:copr.fedorainfracloud.org:bieszczaders:kernel-cachyos-addons" \
    --allowerasing \
    libcap-ng libcap-ng-devel cachyos-ksm-settings procps-ng procps-ng-devel uksmd libbpf scx-scheds-git scx-tools-git scx-manager cachyos-settings ananicy-cpp

dnf -y copr enable mochaa/android-udev-rules

dnf -y install \
    android-udev-rules
    
dnf -y copr disable mochaa/android-udev-rules
dnf -y copr disable bieszczaders/kernel-cachyos-addons

