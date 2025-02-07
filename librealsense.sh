#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

sudo mkdir -p /etc/apt/keyrings
curl -sSf https://librealsense.intel.com/Debian/librealsense.pgp | sudo tee /etc/apt/keyrings/librealsense.pgp > /dev/null

sudo apt-get install apt-transport-https  -y # Make sure apt HTTPS support is installed

echo "deb [signed-by=/etc/apt/keyrings/librealsense.pgp] https://librealsense.intel.com/Debian/apt-repo `lsb_release -cs` main" | \
sudo tee /etc/apt/sources.list.d/librealsense.list
sudo apt-get update  -y

sudo apt-get install librealsense2-dkms -y
sudo apt-get install librealsense2-utils -y
sudo apt-get install librealsense2-dev -y
sudo apt-get install librealsense2-dbg -y

#Install all realsense ROS packages by 
# sudo apt install ros-<ROS_DISTRO>-realsense2-*
#For example, for Humble distro: 
sudo apt install ros-humble-realsense2-* -y

sudo apt-get update  -y
sudo apt-get upgrade  -y

# # if building
##############################################################
######### NOTE:
######### If uvc patch application failing then disable secure boot
######### or sign the patch/driver yourself  
##############################################################
# #!/bin/bash
# sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade
# sudo apt-get install libssl-dev libusb-1.0-0-dev libudev-dev pkg-config libgtk-3-dev
# sudo apt-get install cmake build-essential checkinstall 
# sudo apt-get install libglfw3-dev libgl1-mesa-dev libglu1-mesa-dev at

# ./scripts/setup_udev_rules.sh # You can always remove permissions by running: ./scripts/setup_udev_rules.sh --uninstall
# ./scripts/patch-realsense-ubuntu-lts-hwe.sh

# mkdir build && cd build
# cmake ../ -DBUILD_EXAMPLES=true
# make -j$(nproc)
# sudo checkinstall --install=no --pkgname=librealsense2 --pkgversion=$(git describe --tags | sed 's/^v//') --default
# sudo dpkg -i librealsense2_*.deb
# dpkg -l | grep librealsense2 # Verify the Installation

# # for easy removal
# # sudo apt remove librealsense2