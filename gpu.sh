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
sudo ubuntu-drivers --gpgpu install nvidia:535 # manual install: we have RTX3070 '--gpgpu' because we will use compute capability
sudo apt-get install nvidia-cuda-toolkit -y
