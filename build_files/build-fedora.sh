#!/bin/bash

set -ouex pipefail

/ctx/packages/kernel.sh
/ctx/packages/pkgs-fedora.sh 

systemctl enable podman.socket
