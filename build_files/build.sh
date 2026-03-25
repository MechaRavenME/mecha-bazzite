#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# 1. Habilitamos el repositorio comunitario para Hyprland
dnf5 -y copr enable solopasha/hyprland

# this installs a package from fedora repos
dnf5 install -y \
    kvantum \
    R \
    rstudio-desktop \
    hyprland \
    waybar \
    wofi \
    mako \
    hyprlock \
    hyprpaper \
    grim \
    slurp \
    xdg-desktop-portal-hyprland

# 3. Deshabilitamos el repositorio para no dejar rastros en el sistema final
dnf5 -y copr disable solopasha/hyprland

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
