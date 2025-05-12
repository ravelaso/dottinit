#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

echo "Configuring Ghostty..."
# Example configuration logic
mkdir -p ~/.config/toolname
cp -r "$SCRIPT_DIR/toolname/config/"* ~/.config/toolname/
echo "ToolName configuration completed!"