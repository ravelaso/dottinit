#!/bin/bash
set -e
echo "Configuring Zsh..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"

# Change shell to zsh
chsh -s "$(command -v zsh)"
sudo chsh -s "$(command -v zsh)"

# Detect OS and set root home
if [[ "$(uname)" == "Darwin" ]]; then
    ROOT_HOME="/var/root"
else
    ROOT_HOME="/root"
fi

# Create .config/zsh directory for themes
#mkdir -p ~/.config/zsh
#sudo mkdir -p "$ROOT_HOME/.config/zsh"

# Copy zshrc files
cp "$SCRIPT_DIR/zsh/config/zshrc" ~/.zshrc
sudo cp "$SCRIPT_DIR/zsh/config/zshrc" "$ROOT_HOME/.zshrc"

# Copy custom theme to oh-my-posh
cp "$SCRIPT_DIR/zsh/theme/ravelo.omp.json" ~/.cache/oh-my-posh/themes/ravelo.omp.json
sudo cp "$SCRIPT_DIR/zsh/theme/ravelo.omp.json" "$ROOT_HOME/.cache/oh-my-posh/themes/ravelo.omp.json"

echo "Zsh configuration completed!"