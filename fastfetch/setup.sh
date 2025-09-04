#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

echo "Configuring Fastfetch..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"

mkdir -p "$HOME/.config/fastfetch"

# Copy the config file
cp "$SCRIPT_DIR/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"

# Detect OS and set root home
if [[ "$(uname)" == "Darwin" ]]; then
    ROOT_HOME="/var/root"
else
    ROOT_HOME="/root"
fi

# Copy to root
sudo mkdir -p "$ROOT_HOME/.config/fastfetch"
sudo cp "$SCRIPT_DIR/fastfetch/config.jsonc" "$ROOT_HOME/.config/fastfetch/config.jsonc"