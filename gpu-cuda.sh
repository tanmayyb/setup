#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# remove all nvidia stuff
sudo apt-get remove --purge '^nvidia-.*'  -y
sudo apt autoremove -y

echo "Installing latest drivers"
# - NVIDIA frequently drops support for older GPUs in newer driver versions. Check the NVIDIA support matrix for compatibility.
# check https://www.nvidia.com/en-us/drivers/results/ for latest driver compatibility
# cat /proc/driver/nvidia/version # checks current driver version
sudo ubuntu-drivers list # list drivers
# sudo ubuntu-drivers install # auto-install

# for 550+ drivers:
sudo apt install gcc-12 g++-12
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 100
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-12 100
sudo update-alternatives --config gcc # fix the default compiler to be gcc-12

# install drivers
sudo ubuntu-drivers --gpgpu install nvidia:570 # manual install: we have RTX3070 '--gpgpu' because we will use compute capability

# from: https://developer.nvidia.com/cuda-12-8-0-download-archive?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=22.04&target_type=deb_network
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get update
sudo apt-get -y install cuda-toolkit-12-8
