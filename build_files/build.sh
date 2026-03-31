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
  npm unzip wget tar # Añadido 'tar' para extraer Bun

# --- Instalar Bun correctamente en Bazzite (Método de descarga directa) ---
# Descargamos el binario compilado oficial en formato zip/tar para Linux x64
wget https://github.com/oven-sh/bun/releases/latest/download/bun-linux-x64.zip -O bun.zip
unzip bun.zip
# El zip contiene una carpeta, movemos el binario dentro de ella a /usr/bin
mv bun-linux-x64/bun /usr/bin/
# Limpiamos los archivos descargados
rm -rf bun-linux-x64 bun.zip

# --- Instalar Matugen correctamente en Bazzite ---
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
