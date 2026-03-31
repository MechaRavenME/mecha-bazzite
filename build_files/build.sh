#!/bin/bash

set -ouex pipefail

### Install packages

# R y RStudio
dnf5 install -y kvantum R 
dnf5 copr enable -y iucar/rstudio && dnf5 install -y rstudio-desktop

# Habilitar repositorio COPR para Hyprland (este sí tiene soporte para F43)
dnf5 copr enable -y solopasha/hyprland

# Bajar manualmente los repos de AGS y swww forzando la versión Fedora 42 para evitar error 404
curl -Lo /etc/yum.repos.d/aylur-ags.repo https://copr.fedorainfracloud.org/coprs/aylur/ags/repo/fedora-42/aylur-ags-fedora-42.repo
curl -Lo /etc/yum.repos.d/tofik-swww.repo https://copr.fedorainfracloud.org/coprs/tofik/swww/repo/fedora-42/tofik-swww-fedora-42.repo

# Instalar Hyprland, utilidades base y las dependencias de Caelestia Shell
dnf5 install -y \
  hyprland xdg-desktop-portal-hyprland \
  hyprpaper hyprlock hypridle hyprpicker \
  waybar rofi-wayland swaync wlogout \
  grim slurp wl-clipboard \
  pavucontrol \
  ags swww \
  kitty dart-sass fd-find ripgrep btop \
  brightnessctl playerctl ImageMagick \
  nodejs npm cargo

# Instalar dependencias externas (Bun y Matugen)
# Caelestia usa Bun como entorno de ejecución y Matugen para generar colores dinámicos
npm install -g bun
cargo install matugen --root /usr

# Disable COPRs so they don't end up enabled on the final image:
# Es vital deshabilitarlos al final para evitar problemas con rpm-ostree en el futuro
dnf5 -y copr disable ublue-os/staging
dnf5 -y copr disable iucar/rstudio
dnf5 -y copr disable solopasha/hyprland

# Eliminar los archivos .repo que descargamos a mano
rm -f /etc/yum.repos.d/aylur-ags.repo
rm -f /etc/yum.repos.d/tofik-swww.repo

#### Example for enabling a System Unit File
systemctl enable podman.socket
