#!/bin/bash

# 1. Update package lists
sudo apt update

# 2. Remove existing NVIDIA installations to prevent conflicts
sudo apt autoremove --purge 'nvidia-*' -y

# 3. Install the specific proprietary 535 driver
sudo apt install nvidia-driver-535 -y

# 4. Install the recommended utils
sudo apt install nvidia-utils-535 -y

# 5. Verify installation status
dpkg -l | grep nvidia-driver-535

echo "Installation complete. Reboot is required to load the driver."
