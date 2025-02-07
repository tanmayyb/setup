#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Update and upgrade the system
echo "Updating and upgrading system packages..."
sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y

# Install essential packages
echo "Installing essential packages..."
sudo apt install -y curl git cmake build-essential python3 python3-pip
sudo apt install -y  terminator htop net-tools openssh-server

# Install Barrier
echo "Installing Barrier..."
sudo apt install -y barrier
sudo systemctl enable ssh
sudo systemctl start ssh

# Install NoMachine
echo "Installing NoMachine..."
wget https://download.nomachine.com/download/8.15/Linux/nomachine_8.15.3_1_amd64.deb -O nomachine.deb
sudo apt install ./nomachine.deb
rm nomachine.deb

# Clone and set up egpu-switcher
echo "Cloning and setting up eGPU-Switcher..."
curl -L -o egpu-switcher https://github.com/hertg/egpu-switcher/releases/download/0.20.1/egpu-switcher-amd64
sudo cp egpu-switcher /opt/egpu-switcher
sudo chmod 755 /opt/egpu-switcher
sudo ln -s /opt/egpu-switcher /usr/bin/egpu-switcher
sudo egpu-switcher enable

# Install AppImageLauncher
echo "Installing AppImageLauncher..."
mkdir ~/appimages
wget -qO appimagelauncher.deb https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb
sudo dpkg -i appimagelauncher.deb || sudo apt-get -f install -y
rm appimagelauncher.deb
# # For Ubuntu >= 22.04 use:
sudo apt install libfuse2
# # For Ubuntu < 22.04 use:
# sudo apt-get install fuse libfuse2


# Installing other packages
sudo apt install -y vlc obs-studio

# Cleanup
echo "Cleaning up..."
sudo apt autoremove -y && sudo apt clean

# Create a configuration file to blacklist the Nouveau driver
echo "blacklist nouveau" | sudo tee /etc/modprobe.d/blacklist-nvidia-nouveau.conf
echo "options nouveau modeset=0" | sudo tee -a /etc/modprobe.d/blacklist-nvidia-nouveau.conf
# Update the initial RAM filesystem
sudo update-initramfs -u

# Summary
echo "\nSetup complete! Installed components include:"
echo "- Git"
echo "- terminator"
echo "- htop"
echo "- Barrier"
echo "- VLC"
echo "- OBS Studio"
echo "- NoMachine"
echo "- eGPU Switcher"
echo "- AppImageLauncher"
# Inform the user to reboot the system
echo "Nouveau driver has been blacklisted. Please reboot your system for the changes to take effect."