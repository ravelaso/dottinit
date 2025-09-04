#!/bin/bash
set -e

echo "Configuring Zsh..."
chsh -s "$(command -v zsh)"
cp "$SCRIPT_DIR/zsh/config/zshrc" ~/.zshrc
sudo cp "$SCRIPT_DIR/zsh/config/zshrc" /root/.zshrc
echo "Zsh configuration completed!"
