#!/bin/bash

# Get the directory of the current script
SCRIPT_DIR=$(dirname "$(realpath "$0")")

# Source the Zsh and Alacritty function files
source "$SCRIPT_DIR/zsh/zsh_install.sh"
source "$SCRIPT_DIR/alacritty/alacritty_install.sh"

# Function registry (associative array for descriptions)
declare -A FUNCTION_REGISTRY=(
    ["install_zsh"]="Zsh installation"
    ["install_alacritty"]="Alacritty installation"
)

# Ordered list of functions (indexed array for execution order)
INSTALLATION_ORDER=(
    "install_zsh"
    "install_alacritty"
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
    echo -e "\e[32m[✔] $1\e[0m"
}

# Function to print an error message
print_error() {
    echo -e "\e[31m[✘] $1\e[0m"
}

# Function: run_installation_step
# Arguments:
#   $1 - The name of the installation step (e.g., "Zsh")
#   $2 - The function to call for the installation (e.g., "install_zsh")
run_installation_step() {
    local step_name=$1
    local install_function=$2

    echo "Installing $step_name..."
    if $install_function; then
        print_success "$step_name installation completed!"
    else
        print_error "$step_name installation failed!"
    fi
}

# Clear the screen and print the welcome message
clear
print_header "Welcome to the Dotfiles Installer"
echo "
  ____        _   _   _       _ _   
 |  _ \  ___ | |_| |_(_)_ __ (_) |_ 
 | | | |/ _ \| __| __| | '_ \| | __|
 | |_| | (_) | |_| |_| | | | | | |_ 
 |____/ \___/ \__|\__|_|_| |_|_|\__|
"
echo "=========================================="
echo ""

# Display what will be installed
print_header "Installation Summary"
for func in "${INSTALLATION_ORDER[@]}"; do
    echo "- ${FUNCTION_REGISTRY[$func]}"
done
echo ""
echo "Press Enter to start the installation or Ctrl+C to cancel."
read -p ""

# Start the installation process
print_header "Starting Installation"

# Run the installation steps in the specified order
for func in "${INSTALLATION_ORDER[@]}"; do
    run_installation_step "${FUNCTION_REGISTRY[$func]}" "$func"
done

# Final success message
print_header "Installation Completed"
echo -e "\e[32mAll tasks completed successfully! Please restart your system.\e[0m"