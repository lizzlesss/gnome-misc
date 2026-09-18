#!/usr/bin/bash
set -eoux pipefail

#dnf copr enable -y bieszczaders/kernel-cachyos-addons

# Adds required package for the scheduler
#dnf install -y \
    #--enablerepo="copr:copr.fedorainfracloud.org:bieszczaders:kernel-cachyos-addons" \
    #--allowerasing \
    #libcap-ng libcap-ng-devel bore-sysctl cachyos-ksm-settings procps-ng procps-ng-devel uksmd libbpf scx-scheds-git scx-tools-git scx-manager cachyos-settings ananicy-cpp

dnf copr enable -y binarytree/linux-zen-fedora fedora-rawhide-x86_64

# Remove useless kernels
readarray -t OLD_KERNELS < <(rpm -qa 'kernel-*')
if (( ${#OLD_KERNELS[@]} )); then
    rpm -e --justdb --nodeps "${OLD_KERNELS[@]}"
    dnf5 versionlock delete "${OLD_KERNELS[@]}" || true
    rm -rf /usr/lib/modules/*
    rm -rf /lib/modules/*
fi

# Install kernel packages (noscripts required for 43+)
dnf install -y \
    --enablerepo="copr:copr.fedorainfracloud.org:binarytree:linux-power-lto" \
    --allowerasing \
    --setopt=tsflags=noscripts \
    kernel-zen-v3 \
    kernel-zen-v3-devel-matched \
    kernel-zen-v3-devel \
    kernel-zen-v3-modules \
    kernel-zen-v3-core

KERNEL_VERSION="$(rpm -q --qf '%{VERSION}-%{RELEASE}.%{ARCH}\n' kernel-zen-v3)"

# Depmod (required for fedora 43+)
depmod -a "${KERNEL_VERSION}"

# Copy vmlinuz
VMLINUZ_SOURCE="/usr/lib/kernel/vmlinuz-${KERNEL_VERSION}"
VMLINUZ_TARGET="/usr/lib/modules/${KERNEL_VERSION}/vmlinuz"
if [[ -f "${VMLINUZ_SOURCE}" ]]; then
    cp "${VMLINUZ_SOURCE}" "${VMLINUZ_TARGET}"
fi

# Lock kernel packages
dnf versionlock add "kernel-zen-v3-${KERNEL_VERSION}" || true
dnf versionlock add "kernel-zen-v3-modules-${KERNEL_VERSION}" || true


# Thank you @renner03 for this part
export DRACUT_NO_XATTR=1
dracut --force \
  --no-hostonly \
  --kver "${KERNEL_VERSION}" \
  --add-drivers "btrfs nvme xfs ext4" \
  --reproducible -v --add ostree \
  -f "/usr/lib/modules/${KERNEL_VERSION}/initramfs.img"

chmod 0600 "/lib/modules/${KERNEL_VERSION}/initramfs.img"
