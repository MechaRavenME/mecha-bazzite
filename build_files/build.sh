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
dnf5 install -y \
  hyprland xdg-desktop-portal-hyprland \
  hyprpaper hyprlock hypridle hyprpicker \
  waybar rofi-wayland swaync wlogout \
  grim slurp pavucontrol \
  ags swww \
  kitty sassc fd-find ripgrep \
  brightnessctl playerctl \
  npm unzip wget # Añadido unzip y wget para los binarios

# --- Instalar Bun correctamente en Bazzite ---
# Descargamos el binario oficial y lo movemos a /usr/bin directamente
curl -fsSL https://bun.sh/install | bash -s "bun-v1.1.8"
# El script instala bun en ~/.bun/bin, lo movemos al sistema
mv ~/.bun/bin/bun /usr/bin/
rm -rf ~/.bun

# --- Instalar Matugen correctamente en Bazzite ---
# Descargamos el binario precompilado de Matugen (mucho más rápido que usar cargo)
wget https://github.com/InioX/matugen/releases/latest/download/matugen-x86_64-unknown-linux-gnu.zip -O matugen.zip
unzip matugen.zip
mv matugen /usr/bin/
rm matugen.zip

# Disable COPRs so they don't end up enabled on the final image
dnf5 -y copr disable ublue-os/staging
dnf5 -y copr disable iucar/rstudio
dnf5 -y copr disable solopasha/hyprland
dnf5 -y copr disable retrozinndev/ags

#### Example for enabling a System Unit File
systemctl enable podman.socket
