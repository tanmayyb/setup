#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Update and upgrade the system
echo "Updating and upgrading system packages..."
sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y

# Install essential packages
echo "Installing essential packages..."
sudo apt install -y curl git cmake build-essential python3 python3-pip
sudo apt install -y  terminator htop net-tools openssh-server timeshift libfuse2
sudo apt-get install -y libfastrtps-dev libfastcdr-dev # for dds

# Install stores
echo "Installing package stores..."
sudo apt install -y flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install AppImageLauncher
echo "Installing AppImageLauncher..."
mkdir ~/Applications
wget -qO appimagelauncher.deb https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb
sudo dpkg -i appimagelauncher.deb || sudo apt-get -f install -y
rm appimagelauncher.deb

# Install NoMachine
echo "Installing NoMachine..."
wget https://web9001.nomachine.com/download/9.2/Linux/nomachine_9.2.18_3_amd64.deb -O nomachine.deb
sudo apt install ./nomachine.deb
rm nomachine.deb

# Installing multimedia and productivity packages
sudo apt install -y vlc kazam
flatpak install -y flathub org.deskflow.deskflow
# Install kdenlive
wget https://download.kde.org/stable/kdenlive/25.08/linux/kdenlive-25.08.3-x86_64.AppImage -O tmp.AppImage
chmod +x tmp.AppImage
mv tmp.AppImage ~/Applications/kdenlive.AppImage
# Install inkscape
wget https://inkscape.org/release/inkscape-1.4.2/gnulinux/appimage/dl/ -O tmp.AppImage
chmod +x tmp.AppImage
mv tmp.AppImage ~/Applications/inkscape.AppImage
# Setp Terminator Configs
mkdir -p ~/.config/terminator
curl -sL https://gist.githubusercontent.com/tanmayyb/e608f8f721aa655c305e247e72a02f55/raw -o ~/.config/terminator/config


# Install VS Code
echo "Installing VSCode..."
wget https://go.microsoft.com/fwlink/?LinkID=760868 -O vscode.deb
sudo apt install ./vscode.deb
rm vscode.deb
# Install Brave
echo "Installing VSCode..."
sudo curl -fsS https://dl.brave.com/install.sh | sh
# Install sublime text
sudo apt install apt-transport-https
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/keyrings/sublimehq-pub.gpg
sudo echo -e 'Types: deb\nURIs: https://download.sublimetext.com/\nSuites: apt/stable/\nSigned-By: /etc/apt/keyrings/sublimehq-pub.asc' | sudo tee /etc/apt/sources.list.d/sublime-text.sources
sudo apt-get update
sudo apt-get install -y sublime-text


# Install Tailscale
echo "Installing tailscale..."
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/noble.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/noble.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list
sudo apt-get update
sudo apt-get install -y tailscale

# Install 1Password
echo "Installing 1password..."
wget https://downloads.1password.com/linux/debian/amd64/stable/1password-latest.deb -O tmp.deb
sudo apt install ./tmp.deb
rm tmp.deb


# # gazebo install
# sudo apt install 	ros-rolling-ros-gz \
# 					ros-$ROS_DISTRO-ros2-control \
# 					ros-$ROS_DISTRO-ros2-controllers 

# sudo apt install ros-$ROS_DISTRO-ros-gz-sim \
#                  ros-$ROS_DISTRO-ros-gz-bridge \
#                  ros-$ROS_DISTRO-ros-gz-interfaces

# sudo apt install libogre-1.12-dev libogre-next-dev
