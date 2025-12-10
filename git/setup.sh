#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

echo "Configuring GIT..."

git config --global push.autoSetupRemote true

echo "GIT configuration completed!"