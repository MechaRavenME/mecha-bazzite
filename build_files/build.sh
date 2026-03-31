#!/bin/bash

set -ouex pipefail

### Install packages

# R y RStudio
dnf5 install -y kvantum R 
dnf5 copr enable -y iucar/rstudio && dnf5 install -y rstudio-desktop

# Habilitar repositorios COPR actualizados (Nativos para Fedora 43)
dnf5 copr enable -y solopasha/hyprland
dnf5 copr enable -y retrozinndev/ags

# Instalar Hyprland y dependencias
# HE ELIMINADO: wl-clipboard, btop, ImageMagick y nodejs porque Bazzite ya los trae.
# HE CAMBIADO: dart-sass por sassc.
dnf5 install -y \
  hyprland xdg-desktop-portal-hyprland \
  hyprpaper hyprlock hypridle hyprpicker \
  waybar rofi-wayland swaync wlogout \
  grim slurp pavucontrol \
  ags swww \
  kitty sassc fd-find ripgrep \
  brightnessctl playerctl \
  npm cargo

# Instalar dependencias externas (Bun y Matugen)
npm install -g bun
cargo install matugen --root /usr

# Disable COPRs so they don't end up enabled on the final image
dnf5 -y copr disable ublue-os/staging
dnf5 -y copr disable iucar/rstudio
dnf5 -y copr disable solopasha/hyprland
dnf5 -y copr disable retrozinndev/ags

#### Example for enabling a System Unit File
systemctl enable podman.socket
