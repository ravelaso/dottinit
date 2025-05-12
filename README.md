# DottInit

DottInit is a modular dotfiles installer designed to make it easy to install and configure tools like Zsh, Alacritty, and more. The installer is dynamic and allows you to easily add new tools by following a few simple steps.

Feel free to fork and add your own tools, this will be kept as it is *(just the tools you see)*, due to my own preferences :)

---

Documentation on how to add new tools is also for me, I tend to forget some stuff, and this is a strict workflow.

---

## How to Add a New Tool

To add a new tool to the installer, follow these steps:

### 1. Create a Folder for the Tool
Each tool should have its own folder containing its setup logic and any related configuration files.

Use the following structure as an example:

```plaintext
dottinit/
├── install.sh          # Main installer script
├── install_package.sh  # Generic package installation logic
├── zsh/                # Zsh folder
│   ├── setup.sh        # Zsh setup script
│   └── .zshrc          # Zsh configuration file
├── alacritty/          # Alacritty folder
│   ├── setup.sh        # Alacritty setup script
│   └── config/         # Alacritty configuration files
│       └── alacritty.yml
├── toolname/           # New tool folder
│   ├── setup.sh        # New tool setup script
│   └── config/         # (Optional) Configuration files for the tool
```

### 2. Create the Setup Script
Inside the new folder, create a script named `setup.sh`. This script should contain the logic for configuring the tool after it has been installed.

#### Example: `toolname/setup.sh`
```bash
#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

echo "Configuring ToolName..."
# Example configuration logic
mkdir -p ~/.config/toolname
cp -r "$SCRIPT_DIR/toolname/config/"* ~/.config/toolname/
echo "ToolName configuration completed!"
```

### 3. Add the Tool to the Installer
Update the `install.sh` script to include the new tool.

#### Step 1: Add the Tool to the `PACKAGES` Array
Add the tool's name to the `PACKAGES` array in `install.sh`:
```bash
PACKAGES=(
    "zsh"
    "alacritty"
    "toolname"
)
```

#### Step 2: Create the `setup.sh` Script
Ensure the `setup.sh` script for the tool is located in the corresponding folder (e.g., `toolname/setup.sh`). The installer will automatically detect and execute it.

---

## Running the Installer

To run the installer, simply execute the `install.sh` script:
```bash
./install.sh
```

The installer will display a summary of the tools to be installed and guide you through the process.

---

## Notes

- Ensure each tool's `setup.sh` script is modular and self-contained.
- The installer will automatically detect and execute the `setup.sh` script for each tool if it exists.
- Keep the folder structure clean and organized for easy maintenance.
- If a tool does not require additional configuration, you can skip creating a `setup.sh` script for it.

---

## Example Workflow

1. Add the tool's name to the `PACKAGES` array in `install.sh`.
2. Create a folder for the tool (e.g., `toolname/`).
3. Add a `setup.sh` script to the folder with the configuration logic.
4. Run the installer and follow the prompts.

---

Happy dotfiles management!