#!/bin/bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Function to display system information
show_system_info() {
    echo " "
    echo -e "${YELLOW}===== Titan L2 Edge Installation =====${NC}"
    echo -e "${YELLOW}Website:${NC} https://titannet.io/"
    echo -e "${YELLOW}Tg:${NC} https://t.me/titannet_dao"
    echo -e "${YELLOW}Discord:${NC} https://discord.com/invite/titannet"
    echo -e "${YELLOW}Support:${NC} https://t.me/LaoDauFx"
    echo -e "${YELLOW}======================================${NC}"
    echo " "
    echo -e "${YELLOW}========= System Information =========${NC}"
    echo -e "${YELLOW}CPU (Cores):${NC} $(nproc --all) cores - $(lscpu | grep '^CPU(s):' | awk '{print $2}') vCPU"
    echo -e "${YELLOW}RAM:${NC} $(free -m | awk '/^Mem:/{print int($2/1024+0.5)}') GB"
    echo -e "${YELLOW}Disk:${NC} $(df -h --total | grep 'total' | awk '{print $2}')"
    echo -e "${YELLOW}======================================${NC}"
}

# Function to display the menu
show_menu() {
    echo -e "${YELLOW}================ Menu ================${NC}"
    echo -e "${YELLOW}1) Install${NC}"
    echo -e "${YELLOW}2) Uninstall${NC}"
    echo -e "${YELLOW}3) Update${NC}"
    echo -e "${YELLOW}4) Status${NC}"
    echo -e "${YELLOW}5) Exit${NC}"
    echo -e "${YELLOW}======================================${NC}"
    read -p "Enter your choice [1-5]: " choice
}

# Function to print success message
print_success() {
    echo -e "${GREEN}✔ $1${NC}"
}

# Function to print error/warning message
print_warning() {
    echo -e "${RED}! $1${NC}"
}

# Function to check the OS version
check_os_version() {
    if [ "$(lsb_release -rs)" != "22.04" ]; then
        print_warning "Your operating system is not Ubuntu 22.04. Please check again."
        read -n 1 -s -r -p "Press any key to return to the menu..."
        return 1
    fi
    return 0
}

# Function to check if running as root
check_root() {
    if [ "$EUID" -ne 0 ]; then
        print_warning "You need to run this script as root."
        read -n 1 -s -r -p "Press any key to return to the menu..."
        return 1
    fi
    return 0
}

# Function to uninstall Titan node L2
uninstall_titan() {
    systemctl stop titand.service && systemctl disable titand.service && rm /etc/systemd/system/titand.service
    sudo systemctl daemon-reload
    rm -rf /root/.titanedge /usr/local/titan
    print_success "Titan L2 Edge uninstalled successfully."
    read -n 1 -s -r -p "Press any key to return to the menu..."
    return 0
}

# Function to install Titan node L2
install_titan() {
    local VERSION='v0.1.19'
    local PATCH="89e53b6"
    local identity_code
    local cpu_core
    local memory_size
    local storage_size

    for i in {1..5}; do
        read -p "Enter Identity code (format: F8764574-B27B-4567-A0B4-9D0FCEC1A55F): " identity_code
        if [[ $identity_code =~ ^[A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}$ ]]; then
            break
        else
            print_warning "Invalid Identity code format."
        fi
        if [ $i -eq 5 ]; then
            print_warning "Exceeded maximum attempts. Returning to menu."
            read -n 1 -s -r -p "Press any key to return to the menu..."
            return 1
        fi
    done

    while true; do
        read -p "Enter number of CPU cores: " cpu_core
        if [[ $cpu_core =~ ^[0-9]+$ && $cpu_core -gt 0 ]]; then
            break
        else
            print_warning "Invalid number of CPU cores. Please enter a positive integer."
        fi
    done

    while true; do
        read -p "Enter amount of RAM (GB): " memory_size
        if [[ $memory_size =~ ^[0-9]+$ && $memory_size -gt 0 ]]; then
            break
        else
            print_warning "Invalid amount of RAM. Please enter a positive integer."
        fi
    done

    while true; do
        read -p "Enter amount of Storage (GB): " storage_size
        if [[ $storage_size =~ ^[0-9]+$ && $storage_size -gt 0 ]]; then
            break
        else
            print_warning "Invalid amount of Storage. Please enter a positive integer."
        fi
    done

    wget "https://github.com/Titannet-dao/titan-node/releases/download/${VERSION}/titan-l2edge_${VERSION}_patch_linux_amd64.tar.gz"
    if [ $? -eq 0 ]; then
        print_success "Downloaded Titan Edge installation file."
    else
        print_warning "Failed to download Titan Edge installation file."
        return 1
    fi

    sudo tar -xf titan-l2edge_${VERSION}_patch_linux_amd64.tar.gz -C /usr/local
    sudo mv /usr/local/titan-edge_${VERSION}_${PATCH}_linux_amd64 /usr/local/titan
    sudo cp /usr/local/titan/libgoworkerd.so /usr/lib/libgoworkerd.so
    rm titan-l2edge_${VERSION}_patch_linux_amd64.tar.gz
    print_success "Extracted and moved Titan Edge files."

    content="
export PATH=\$PATH:/usr/local/titan
export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:./libgoworkerd.so
"
    if [ ! -f ~/.bash_profile ]; then
        echo "$content" > ~/.bash_profile
        source ~/.bash_profile
    else
        echo "$content" >> ~/.bash_profile
        source ~/.bash_profile
    fi
    print_success "Updated PATH in ~/.bash_profile"

    (titan-edge daemon start --init --url https://cassini-locator.titannet.io:5000/rpc/v0 &) &
    sleep 15

    (titan-edge bind --hash="$identity_code" https://api-test1.container1.titannet.io/api/v2/device/binding &) &
    wait $!
    sleep 15
    print_success "Configured Titan Edge daemon and bind."

    config_file="/root/.titanedge/config.toml"
    if [ -f "$config_file" ]; then
        sed -i "s/#StorageGB = 2/StorageGB = $storage_size/" "$config_file"
        print_success "Configured StorageGB to: $storage_size GB."
        sed -i "s/#MemoryGB = 1/MemoryGB = $memory_size/" "$config_file"
        print_success "Configured MemoryGB to: $memory_size GB."
        sed -i "s/#Cores = 1/Cores = $cpu_core/" "$config_file"
        print_success "Configured Cores CPU to: $cpu_core Core."
    else
        print_warning "Error: Configuration file $config_file does not exist."
        return 1
    fi

    service_content="[Unit]
Description=Titan Daemon
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/titan/titan-edge daemon start --init --url https://cassini-locator.titannet.io:5000/rpc/v0
Restart=always
RestartSec=10
User=root

[Install]
WantedBy=multi-user.target"
    echo "$service_content" | sudo tee /etc/systemd/system/titand.service > /dev/null
    print_success "Created titand.service file."

    pkill titan-edge
    sudo systemctl daemon-reload
    sudo systemctl enable titand.service
    sudo systemctl start titand.service
    sleep 8

    sudo systemctl status titand.service && titan-edge config show && titan-edge info
    print_success "Titan Edge installation and configuration completed."
    read -n 1 -s -r -p "Press any key to return to the menu..."
    return 0
}

# Function to update Titan node L2
update_titan() {
    local VERSION='v0.1.19'
    local PATCH="89e53b6"

    wget "https://github.com/Titannet-dao/titan-node/releases/download/${VERSION}/titan-l2edge_${VERSION}_patch_linux_amd64.tar.gz"
    if [ $? -eq 0 ]; then
        print_success "Downloaded Titan Edge update file."
    else
        print_warning "Failed to download Titan Edge update file."
        return 1
    fi

    sudo tar -xf titan-l2edge_${VERSION}_patch_linux_amd64.tar.gz -C /usr/local
    sudo mv /usr/local/titan-edge_${VERSION}_${PATCH}_linux_amd64 /usr/local/titan
    sudo cp /usr/local/titan/libgoworkerd.so /usr/lib/libgoworkerd.so
    rm titan-l2edge_${VERSION}_patch_linux_amd64.tar.gz
    print_success "Extracted and moved Titan Edge update files."

    service_content="[Unit]
Description=Titan Daemon
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/titan/titan-edge daemon start --init --url https://cassini-locator.titannet.io:5000/rpc/v0
Restart=always
RestartSec=10
User=root

[Install]
WantedBy=multi-user.target"
    echo "$service_content" | sudo tee /etc/systemd/system/titand.service > /dev/null
    print_success "Updated titand.service file."

    pkill titan-edge
    sudo systemctl daemon-reload
    sudo systemctl enable titand.service
    sudo systemctl start titand.service
    sleep 8

    sudo systemctl status titand.service && titan-edge config show && titan-edge info
    print_success "Titan Edge update and configuration completed."
    read -n 1 -s -r -p "Press any key to return to the menu..."
    return 0
}

# Function to display status of Titan node L2
status_titan() {
    if systemctl list-units --full -all | grep -q 'titand.service'; then
        sudo systemctl status titand.service && titan-edge config show && titan-edge info
    else
        print_warning "Titan L2 Edge does not exist."
    fi
    read -n 1 -s -r -p "Press any key to return to the menu..."
}

while true; do
    show_system_info
    show_menu
    case $choice in
        1)
            if check_os_version && check_root; then
                install_titan
            fi
            ;;
        2)
            if check_os_version && check_root; then
                uninstall_titan
            fi
            ;;
        3)
            if check_os_version && check_root; then
                update_titan
            fi
            ;;
        4)
            if check_os_version && check_root; then
                status_titan
            fi
            ;;
        5)
            echo -e "${YELLOW}Exiting the program.${NC}"
            exit 0
            ;;
        *)
            print_warning "Invalid choice, please select again."
            read -n 1 -s -r -p "Press any key to return to the menu..."
            ;;
    esac
done
