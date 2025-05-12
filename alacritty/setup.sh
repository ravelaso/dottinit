#!/bin/bash
set -e

echo "Configuring Alacritty..."
mkdir -p ~/.config/alacritty
cp -r "$SCRIPT_DIR/alacritty/config/"* ~/.config/alacritty/
echo "Alacritty configuration completed!"