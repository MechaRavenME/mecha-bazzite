#!/bin/bash

set -ouex pipefail

### Install packages

# R y RStudio
dnf5 install -y kvantum R 
dnf5 copr enable -y iucar/rstudio && dnf5 install -y rstudio-desktop

# Habilitar repositorio COPR principal
dnf5 copr enable -y solopasha/hyprland

# Instalar Hyprland y dependencias
# Agregamos explícitamente aylurs-gtk-shell (el nombre real del paquete en el COPR, en lugar de solo 'ags' que choca con el juego)
dnf5 install -y \
  hyprland xdg-desktop-portal-hyprland \
  hyprpaper hyprlock hypridle hyprpicker \
  waybar rofi-wayland swaync wlogout \
  grim slurp pavucontrol \
  swww \
  kitty sassc fd-find ripgrep \
  brightnessctl playerctl \
  unzip wget cargo \
  aylurs-gtk-shell \
  gjs 

# --- Instalar Bun (Método de descarga directa) ---
wget https://github.com/oven-sh/bun/releases/latest/download/bun-linux-x64.zip -O bun.zip
unzip bun.zip
mv bun-linux-x64/bun /usr/bin/
rm -rf bun-linux-x64 bun.zip

# --- Instalar Matugen (Compilación segura con Cargo) ---
env CARGO_HOME=/tmp/cargo cargo install matugen
mv /tmp/cargo/bin/matugen /usr/bin/
rm -rf /tmp/cargo

# Disable COPRs so they don't end up enabled on the final image
dnf5 -y copr disable ublue-os/staging
dnf5 -y copr disable iucar/rstudio
dnf5 -y copr disable solopasha/hyprland

#### Example for enabling a System Unit File
systemctl enable podman.socket
