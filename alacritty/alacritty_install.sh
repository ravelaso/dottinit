#!/bin/bash

#!/bin/bash

# Function to install Alacritty
install_alacritty() {
    read -p "Install Alacritty? (y/n): " USE_ALACRITTY
    if [[ "$USE_ALACRITTY" =~ ^[Nn]$ ]]; then
        echo "Skipping Alacritty installation and configuration."
        return
    fi

    # Check if Alacritty is already installed
    if command -v alacritty &>/dev/null; then
        echo "Alacritty is already installed!"
    else
        echo "Alacritty is not installed. Installing Alacritty..."
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            if command -v apt &>/dev/null; then
                sudo apt update && sudo apt install -y alacritty
            elif command -v pacman &>/dev/null; then
                sudo pacman -Syu --noconfirm alacritty
            elif command -v dnf &>/dev/null; then
                sudo dnf install -y alacritty
            else
                echo "Unsupported Linux distribution. Please install Alacritty manually."
                exit 1
            fi
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            echo "Detected macOS. Installing Alacritty via Homebrew..."
            brew install --cask alacritty
        else
            echo "Unsupported OS. Please install Alacritty manually."
            exit 1
        fi
    fi

    # Copy Alacritty configuration
    echo "Copying Alacritty configuration..."
    mkdir -p ~/.config/alacritty
    cp -r "$SCRIPT_DIR/alacritty/config/"* ~/.config/alacritty/
}