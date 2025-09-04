#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

echo "Configuring Fastfetch..."

mkdir -p "$HOME/.config/fastfetch"

# Copy the config file
cp "$SCRIPT_DIR/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"

# Copy to root
sudo mkdir -p "/root/.config/fastfetch"

sudo cp "$SCRIPT_DIR/fastfetch/config.jsonc" "/root/.config/fastfetch/config.jsonc"

echo "Fastfetch configuration completed!"