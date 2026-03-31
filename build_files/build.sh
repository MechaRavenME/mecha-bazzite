#!/bin/bash

set -ouex pipefail

### Install packages

# R y RStudio
dnf5 install -y kvantum R 
dnf5 copr enable -y iucar/rstudio && dnf5 install -y rstudio-desktop

# Habilitar repositorios COPR para Hyprland, AGS y swww
dnf5 copr enable -y solopasha/hyprland
dnf5 copr enable -y aylur/ags
dnf5 copr enable -y tofik/swww

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
dnf5 -y copr disable aylur/ags
dnf5 -y copr disable tofik/swww

#### Example for enabling a System Unit File
systemctl enable podman.socket
