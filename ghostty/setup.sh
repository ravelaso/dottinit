#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

echo "Configuring Ghostty..."

# Determine the configuration directory based on the platform
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/ghostty"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    CONFIG_DIR="$HOME/Library/Application Support/com.mitchellh.ghostty"
else
    echo "Unsupported OS. Skipping Ghostty configuration."
    exit 1
fi

# Copy the config file
cp "$SCRIPT_DIR/ghostty/config" "$CONFIG_DIR/config"

echo "Ghostty configuration completed!"