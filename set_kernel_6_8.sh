#!/ theater/bin/bash

sudo apt update
sudo apt install -y linux-image-6.8.0-90-generic linux-headers-6.8.0-90-generic linux-modules-extra-6.8.0-90-generic

# 2. Identify the GRUB menu entry string
# Extracts the 'menuentry' identifier for the 6.8 kernel
ENTRY="gnulinux-advanced-$(target_uuid)--gnulinux-6.8.0-90-generic-advanced-$(target_uuid)"
# Alternative: Set by menu index (not recommended if order changes)
# Standard approach: set GRUB_DEFAULT by name in /etc/default/grub

sudo sed -i 's/^GRUB_DEFAULT=.*/GRUB_DEFAULT="Advanced options for Ubuntu>Ubuntu, with Linux 6.8.0-90-generic"/' /etc/default/grub

#!/bin/bash
# 1. Verify current running kernel
CURRENT_KERNEL=$(uname -r)
if [[ "$CURRENT_KERNEL" != *"6.8"* ]]; then
    echo "Error: Not running 6.8. Current: $CURRENT_KERNEL. Aborting."
    exit 1
fi

# 2. Identify and remove specific newer kernels (6.11, 6.14, HWE)
# This targets packages containing '6.11' or '6.14'
dpkg --list | grep -E 'linux-image-6.1[14]|linux-headers-6.1[14]' | awk '{ print $2 }' | xargs sudo apt-get purge -y

# 3. Remove HWE meta-packages to prevent future auto-upgrades to newer stacks
sudo apt-get purge -y linux-generic-hwe-24.04 linux-image-generic-hwe-24.04

# 4. Install/Restore the standard 6.8 meta-package to ensure security updates within 6.8
sudo apt-get install -y linux-generic linux-image-generic linux-headers-generic

# 5. Final Cleanup
sudo apt-get autoremove --purge -y
sudo update-grub


#!/bin/bash
# prevent updates to kernel
KVER=$(uname -r)

sudo apt-mark hold linux-image-$KVER linux-headers-$KVER linux-modules-$KVER linux-modules-extra-$KVER

sudo apt-mark hold linux-generic linux-image-generic linux-headers-generic

CONF_FILE="/etc/apt/apt.conf.d/50unattended-upgrades"
if [ -f "$CONF_FILE" ]; then
    sudo sed -i '/Unattended-Upgrade::Package-Blacklist {/a \  "linux-generic";\n  "linux-image-generic";\n  "linux-headers-generic";\n  "linux-image-6.8.*";' "$CONF_FILE"
fi
