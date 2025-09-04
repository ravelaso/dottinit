#!/bin/bash
set -e
echo "Configuring Zsh..."

# Change shell to zsh
chsh -s "$(command -v zsh)"

# Create .config/zsh directory for themes
mkdir -p ~/.config/zsh
sudo mkdir -p /root/.config/zsh

# Copy zshrc files
cp "$SCRIPT_DIR/zsh/config/zshrc" ~/.zshrc
sudo cp "$SCRIPT_DIR/zsh/config/zshrc" /root/.zshrc

# Copy custom alpha theme to .config/zsh
cp "$SCRIPT_DIR/zsh/themes/alpha.zsh-theme" ~/.config/zsh/
sudo cp "$SCRIPT_DIR/zsh/themes/alpha.zsh-theme" /root/.config/zsh/

echo "Zsh configuration completed!"