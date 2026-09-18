#!/bin/bash

set -ouex pipefail

/ctx/packages/pkgs.sh 

systemctl enable podman.socket
