#!/bin/bash

# Get the directory of the current script
SCRIPT_DIR=$(dirname "$(realpath "$0")")

# Source the generic install_package function
source "$SCRIPT_DIR/install_package.sh"

# List of packages to install (in order)
PACKAGES=(
    "zsh"
    "alacritty"
    "ghostty"
    "fastfetch"
)

# Function to print a header
print_header() {
    echo ""
    echo "=========================================="
    echo "      $1"
    echo "=========================================="
    echo ""
}

# Function to print a success message
print_success() {
    printf "\033[32m[✔] %s\033[0m\n" "$1"
}

# Function to print an error message
print_error() {
    printf "\033[31m[✘] %s\033[0m\n" "$1"
}

# Function to handle the installation and configuration of a package
process_package() {
    local package_name=$1

    # Prompt the user
    read -p "Do you want to install $package_name? (y/n): " user_choice
    if [[ "$user_choice" =~ ^[Nn]$ ]]; then
        echo "Skipping $package_name."
        return
    fi

    # Install the package
    if install_package "$package_name"; then
        print_success "$package_name installation completed!"
    else
        print_error "Failed to install $package_name."
        return
    fi

    # Run the package's configuration script
    local config_script="$SCRIPT_DIR/$package_name/setup.sh"
    if [[ -f "$config_script" ]]; then
        echo "Running configuration for $package_name..."
        if SCRIPT_DIR="$SCRIPT_DIR" bash "$config_script"; then
            print_success "$package_name configuration completed!"
        else
            print_error "Failed to configure $package_name."
            return 1  # Ensure the error propagates
        fi
    else
        echo "No configuration script found for $package_name. Skipping configuration."
    fi
}

# Clear the screen and print the welcome message
clear
print_header "Welcome to the Dotfiles Installer"
echo "
▗▄▄▄  ▗▄▖▗▄▄▄▖▗▄▄▄▖▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖▗▄▄▄▖
▐▌  █▐▌ ▐▌ █    █    █  ▐▛▚▖▐▌  █    █  
▐▌  █▐▌ ▐▌ █    █    █  ▐▌ ▝▜▌  █    █  
▐▙▄▄▀▝▚▄▞▘ █    █  ▗▄█▄▖▐▌  ▐▌▗▄█▄▖  █  
                                       
"
echo "=========================================="
echo ""

# Display what will be installed
print_header "Installation Summary"
for package in "${PACKAGES[@]}"; do
    echo "- $package"
done
echo ""
echo "Press Enter to start the installation or Ctrl+C to cancel."
read -p ""

# Start the installation process
print_header "Starting Installation"

# Process each package in the list
for package in "${PACKAGES[@]}"; do
    process_package "$package"
done

# Final success message
print_header "Installation Completed"
echo -e "\e[32mAll tasks completed successfully! Please restart your system.\e[0m"