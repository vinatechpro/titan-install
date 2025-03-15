#!/bin/bash

# Check if the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "❌ Please run this script as root (sudo)."
   exit 1
fi

# Verify if the OS is Ubuntu/Debian
if ! grep -Ei 'ubuntu|debian' /etc/os-release > /dev/null; then
    echo "❌ This script only supports Ubuntu/Debian."
    exit 1
fi

# Check if GRUB exists
if [[ ! -f /etc/default/grub ]]; then
    echo "❌ GRUB configuration file not found."
    exit 1
fi

# Backup the GRUB configuration file
echo "🛠️ Backing up the GRUB configuration file..."
cp /etc/default/grub /etc/default/grub.bak

# Check if the cgroups v1 parameter is already set
if grep -q "systemd.unified_cgroup_hierarchy=0" /etc/default/grub; then
    echo "✅ cgroups v1 is already enabled. No changes needed."
else
    echo "📝 Modifying the GRUB file to enable cgroups v1..."
    sed -i '/^GRUB_CMDLINE_LINUX=/ s/"$/ systemd.unified_cgroup_hierarchy=0"/' /etc/default/grub
fi

# Update GRUB
echo "🔄 Updating GRUB..."
update-grub

# Prompt for system reboot
echo "✅ Configuration complete! Please restart your system to apply changes."
read -p "🔁 Do you want to restart now? (y/n): " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
    reboot
else
    echo "🔹 You can restart later using: sudo reboot"
fi