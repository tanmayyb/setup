#!/usr/bin/env bash
set -eou pipefail

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

if ! command_exists conda; then
  # Determine the appropriate Miniforge installer
  case "$OSTYPE" in
    darwin*)
      case $(uname -m) in
        arm64)   DOWNLOAD=https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-arm64.sh ;;
        *)       DOWNLOAD=https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-x86_64.sh ;;
      esac ;;
    linux*)
      case $(uname -m) in
        aarch64) DOWNLOAD=https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh ;;
        *)       DOWNLOAD=https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh ;;
      esac ;;
    *) echo "Unknown OS type: $OSTYPE" && exit 1 ;;
  esac

  # Determine the shell
  case "$SHELL" in
    *bin/zsh*)   SHELL_NAME=zsh ;;
    *bin/bash*)  SHELL_NAME=bash ;;
    *bin/fish*)  SHELL_NAME=fish ;;
    *) echo "Unknown shell: $SHELL" && exit 1 ;;
  esac

  echo "Conda not found. Downloading and installing Miniforge..."
  echo "Downloading $DOWNLOAD"
  wget $DOWNLOAD
  bash Miniforge3-*.sh -b

  # Initialize conda for the current shell
  ~/miniforge3/bin/conda init $SHELL_NAME

  echo "Miniforge installation complete. Please restart your terminal and re-run this script to proceed."
  exit 0
else
  echo "Conda is already installed."
fi

# Source the updated shell configuration
# source ~/.${SHELL_NAME}rc

# Disable auto activation of the base environment
conda config --set auto_activate_base false
conda deactivate

# CUDA installation
echo "Installing required packages..."
conda install -y cuda -c nvidia/label/cuda-12.6.3
conda install -y pytorch torchvision torchaudio pytorch-cuda=12.6 -c pytorch -c nvidia

echo "CUDA Setup complete."
