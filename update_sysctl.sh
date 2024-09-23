#!/bin/bash

# Function to update sysctl configuration
update_sysctl_config() {
    # Define the configuration values
    local CONFIG_VALUES="
net.core.rmem_max=26214400
net.core.rmem_default=26214400
net.core.wmem_max=26214400
net.core.wmem_default=26214400
"

    # Path to the sysctl configuration file
    local SYSCTL_CONF="/etc/sysctl.conf"

    # Backup the original sysctl.conf file
    echo "Backing up the original sysctl.conf to sysctl.conf.bak..."
    sudo cp "$SYSCTL_CONF" "$SYSCTL_CONF.bak"

    # Append the configuration values to sysctl.conf
    echo "Updating sysctl.conf with new configuration values..."
    echo "$CONFIG_VALUES" | sudo tee -a "$SYSCTL_CONF" > /dev/null

    # Apply the changes
    echo "Applying the new sysctl configuration..."
    sudo sysctl -p

    echo "Configuration updated and applied successfully."

    # Check if SELinux is present and handle accordingly
    if command -v setenforce &> /dev/null; then
        echo "Disabling SELinux enforcement..."
        sudo setenforce 0
    else
        echo "SELinux is not installed or not applicable."
    fi
}

# Detect the Linux distribution
detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
    elif [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        OS=$DISTRIB_ID
    elif [ -f /etc/debian_version ]; then
        OS="debian"
    elif [ -f /etc/redhat-release ]; then
        OS="rhel"
    else
        OS=$(uname -s)
    fi
    echo "Detected OS: $OS"
}

# Function to run update based on the detected OS
run_update() {
    case "$OS" in
        ubuntu|debian|pop|linuxmint)
            echo "Running update on Ubuntu/Debian-based system..."
            update_sysctl_config
            ;;
        centos|rhel|fedora|rocky|almalinux)
            echo "Running update on CentOS/RHEL/Fedora-based system..."
            update_sysctl_config
            ;;
        arch|manjaro)
            echo "Running update on Arch-based system..."
            update_sysctl_config
            ;;
        suse|opensuse)
            echo "Running update on SUSE-based system..."
            update_sysctl_config
            ;;
        *)
            echo "Unsupported Linux distribution: $OS"
            exit 1
            ;;
    esac
}

# Detect OS and run the update
detect_os
run_update