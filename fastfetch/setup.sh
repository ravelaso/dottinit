#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

echo "Configuring Fastfetch..."

mkdir -p "$HOME/.config/fastfetch"

# Copy the config file
cp "$SCRIPT_DIR/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"

echo "Fastfetch configuration completed!"