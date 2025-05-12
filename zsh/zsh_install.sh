#!/bin/bash

# Function to install Zsh
install_zsh() {
    read -p "Install ZSH ? (y/n): " USE_ZSH
    if [[ "$USE_ZSH" =~ ^[Nn]$ ]]; then
        echo "Skipping Zsh installation and configuration."
        return
    fi
    if ! command -v zsh &>/dev/null; then
        echo "Installing Zsh..."
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            if command -v apt &>/dev/null; then
                sudo apt update && sudo apt install -y zsh
            elif command -v pacman &>/dev/null; then
                sudo pacman -Syu --noconfirm zsh
            elif command -v dnf &>/dev/null; then
                sudo dnf install -y zsh
            else
                echo "Unsupported Linux distribution. Please install Zsh manually."
                exit 1
            fi
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            echo "Detected macOS. Installing Zsh via Homebrew..."
            brew install zsh
        else
            echo "Unsupported OS. Please install Zsh manually."
            exit 1
        fi
    else
        echo "Zsh is already installed!"
    fi

    # Set Zsh as the default shell
    ZSH_PATH=$(command -v zsh)
    CURRENT_SHELL=$(basename "$SHELL")

    if [ "$CURRENT_SHELL" == "zsh" ]; then
        echo "Zsh is already the default shell. Skipping..."
    else
        if [ -n "$ZSH_PATH" ]; then
            echo "Changing the default shell to Zsh..."
            chsh -s "$ZSH_PATH"
            echo "Default shell changed to Zsh."
        else
            echo "Error: Zsh binary not found. Unable to change the default shell."
            exit 1
        fi
    fi
    # Copy .zshrc
    echo "Copying .zshrc to the home directory..."
    cp "$SCRIPT_DIR/zsh/config/zshrc" ~/.zshrc
}