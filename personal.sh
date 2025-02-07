#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# productivity software 
sudo snap install slack 
sudo snap install onenote-desktop 
sudo snap install chatgpt-desktop 
sudo snap install code --classic

# install cursor
wget https://downloader.cursor.sh/linux/appImage/x64 -O cursor.AppImage
sudo chmod +x cursor.AppImage
sudo mv cursor.AppImage ~/Applications

# Setup Git credentials
echo "Setting up Git credentials..."
git config --global user.name "Tanmay Bishnoi"
git config --global user.email "tbishnoi@torontomu.ca"

# Setup Terminator configs
mkdir -p ~/.config/terminator
curl -sL https://gist.githubusercontent.com/tanmayyb/e608f8f721aa655c305e247e72a02f55/raw -o ~/.config/terminator/config

# Summary
echo "Git credentials configured."
echo "Terminator theme set."
echo "Slack installed."
echo "Onenote-desktop installed."
echo "ChatGPT-desktop installed."
echo "Code installed."
echo "Cursor installed."
echo "Reboot your system if necessary."