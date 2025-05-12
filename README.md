# DottInit

DottInit is a modular dotfiles installer designed to make it easy to install and configure tools like Zsh, Alacritty, and more. The installer is dynamic and allows you to easily add new tools by following a few simple steps.

Feel free to fork and add your own tools, this will be kept as it is *(just the tools you see)*, due to my own preferences :)

---

Documentation on how to add new tools is also for me, I tend to forget some stuff, and this is a strict workflow

---
## How to Add a New Tool

To add a new tool to the installer, follow these steps:

### 1. Create a Folder for the Tool
Each tool should have its own folder containing its installation logic and any related configuration files. 

Use the following structure as an example:

```plaintext
dotfiles/
├── install.sh          # Main installer script
├── zsh/                # Zsh folder
│   ├── zsh_install.sh  # Zsh installation script
│   └── zshrc           # Zsh configuration file
├── alacritty/          # Alacritty folder
│   ├── alacritty_install.sh  # Alacritty installation script
│   └── config/         # Alacritty configuration files
│       └── alacritty.yml
├── toolname/           # New tool folder
│   ├── toolname_install.sh   # New tool installation script
│   └── config/         # (Optional) Configuration files for the tool
```

### 2. Create the Installation Script
Inside the new folder, create a script named `toolname_install.sh` (replace `toolname` with the name of your tool). This script should define a function named `install_toolname` that contains the installation logic.

#### Example: `toolname/toolname_install.sh`
```bash
#!/bin/bash

# Function to install ToolName
install_toolname() {
    if ! command -v zsh &>/dev/null; then
        echo "Installing ToolName..."
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            if command -v apt &>/dev/null; then
                sudo apt update && sudo apt install -y ToolName
            elif command -v pacman &>/dev/null; then
                sudo pacman -Syu --noconfirm ToolName
            elif command -v dnf &>/dev/null; then
                sudo dnf install -y ToolName
            else
                echo "Unsupported Linux distribution. Please install ToolName manually."
                exit 1
            fi
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            echo "Detected macOS. Installing ToolName via Homebrew..."
            brew install ToolName
        else
            echo "Unsupported OS. Please install ToolName manually."
            exit 1
        fi
    else
        echo "ToolName is already installed!"
    fi
}
```

### 3. Add the Tool to the Installer
Update the `install.sh` script to include the new tool.

#### Step 1: Source the Installation Script
Add the following line to \`install.sh\` to source the new tool's installation script:
```bash
source "$SCRIPT_DIR/toolname/toolname_install.sh"
```

#### Step 2: Add the Tool to the Function Registry
Add an entry for the new tool in the \`FUNCTION_REGISTRY\` associative array:
```bash
declare -A FUNCTION_REGISTRY=(
    ["install_zsh"]="Zsh installation"
    ["install_alacritty"]="Alacritty installation"
    ["install_toolname"]="ToolName installation"
)
```

#### Step 3: Add the Tool to the Installation Order
Add the new tool to the `INSTALLATION_ORDER` array in the desired execution order:
```bash
INSTALLATION_ORDER=(
    "install_zsh"
    "install_alacritty"
    "install_toolname"
)
```

---

## Running the Installer

To run the installer, simply execute the `install.sh` script:
```bash
./install.sh
```

The installer will display a summary of the tools to be installed and guide you through the process.

---

## Notes

- Ensure each tool's installation script is modular and self-contained.
- Use the `run_installation_step` function in `install.sh` to handle success and error messages for each tool.
- Keep the folder structure clean and organized for easy maintenance.

---