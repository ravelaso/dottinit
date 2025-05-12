#!/bin/bash

# Generic function to install a package
install_package() {
    local package_name=$1

    echo "Checking if $package_name is installed..."
    if command -v "$package_name" &>/dev/null; then
        echo "$package_name is already installed!"
        return 0
    fi

    echo "$package_name is not installed. Installing $package_name..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command -v apt &>/dev/null; then
            sudo apt update && sudo apt install -y "$package_name"
        elif command -v pacman &>/dev/null; then
            sudo pacman -Syu --noconfirm "$package_name"
        elif command -v dnf &>/dev/null; then
            sudo dnf install -y "$package_name"
        else
            echo "Unsupported Linux distribution. Please install $package_name manually."
            return 1
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "Detected macOS. Installing $package_name via Homebrew..."
        # Check if brew is installed, install it if necessary
        if ! command -v brew &>/dev/null; then
            echo "Homebrew not found. Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            echo "Adding Homebrew to PATH in .zshrc..."
            echo 'export PATH="/opt/homebrew/bin:$PATH"' >> ~/.zshrc
            source ~/.zshrc
        fi
        brew install "$package_name"
    else
        echo "Unsupported OS. Please install $package_name manually."
        return 1
    fi
}