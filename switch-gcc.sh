#!/bin/bash

set -e

echo "🔍 Installing GCC 12 and G++ 12..."
sudo apt update
sudo apt install -y gcc-12 g++-12

echo "🔧 Configuring update-alternatives for gcc and g++..."

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 90
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 100

sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 90
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-12 100

echo "✅ Current GCC version:"
gcc --version

echo "👉 To switch GCC version manually, run:"
echo "    sudo update-alternatives --config gcc"
