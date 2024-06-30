#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root."
    echo "Please try switching to the root user using the 'sudo -i' command and then run this script again."
    exit 1
fi

# Check and install Node.js and npm
function install_nodejs_and_npm() {
    if command -v node > /dev/null 2>&1; then
        echo "Node.js is already installed"
    else
        echo "Node.js is not installed, installing now..."
        curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
        sudo apt-get install -y nodejs
    fi

    if command -v npm > /dev/null 2>&1; then
        echo "npm is already installed"
    else
        echo "npm is not installed, installing now..."
        sudo apt-get install -y npm
    fi
}

# Check and install PM2
function install_pm2() {
    if command -v pm2 > /dev/null 2>&1; then
        echo "PM2 is already installed"
    else
        echo "PM2 is not installed, installing now..."
        npm install pm2@latest -g
    fi
}

# Auto set alias function
function check_and_set_alias() {
    local alias_name="art"
    local shell_rc="$HOME/.bashrc"

    # For Zsh users, use .zshrc
    if [ -n "$ZSH_VERSION" ]; then
        shell_rc="$HOME/.zshrc"
    elif [ -n "$BASH_VERSION" ]; then
        shell_rc="$HOME/.bashrc"
    fi

    # Check if alias is already set
    if ! grep -q "$alias_name" "$shell_rc"; then
        echo "Setting alias '$alias_name' to $shell_rc"
        echo "alias $alias_name='bash $SCRIPT_PATH'" >> "$shell_rc"
        # Add reminder for the user to activate the alias
        echo "Alias '$alias_name' is set. Please run 'source $shell_rc' to activate the alias, or reopen the terminal."
    else
        # If alias is already set, provide a reminder
        echo "Alias '$alias_name' is already set in $shell_rc."
        echo "If the alias does not work, please try running 'source $shell_rc' or reopen the terminal."
    fi
}

# Node installation function
function install_node() {
    install_nodejs_and_npm
    install_pm2

    # Set variables


    # Update and install necessary software
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y curl iptables build-essential git wget jq make gcc nano tmux htop nvme-cli pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip libleveldb-dev lz4 snapd

    # Install Go
    sudo rm -rf /usr/local/go
    curl -L https://go.dev/dl/go1.22.0.linux-amd64.tar.gz | sudo tar -xzf - -C /usr/local
    echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile
    source $HOME/.bash_profile
    go version

    # Install all binaries
    cd $HOME
    git clone https://github.com/nezha90/titan.git
    cd titan
    go build ./cmd/titand
    cp titand /usr/local/bin

    # Configure titand
    export MONIKER="titan-hunter"
    titand init $MONIKER --chain-id titan-test-1
    titand config node tcp://localhost:53457

    # Get genesis file and address book
    wget https://raw.githubusercontent.com/nezha90/titan/main/genesis/genesis.json
    mv genesis.json ~/.titan/config/genesis.json

    # Configure the node
    SEEDS="bb075c8cc4b7032d506008b68d4192298a09aeea@47.76.107.159:26656"
    PEERS=""
    sed -i 's|^persistent_peers *=.*|persistent_peers = "'$PEERS'"|' $HOME/.titan/config/config.toml

    wget https://raw.githubusercontent.com/nezha90/titan/main/addrbook/addrbook.json
    mv addrbook.json ~/.titan/config/addrbook.json

    # Configure pruning
    sed -i -e "s/^pruning *=.*/pruning = \"custom\"/" $HOME/.titan/config/app.toml
    sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"100\"/" $HOME/.titan/config/app.toml
    sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"0\"/" $HOME/.titan/config/app.toml
    sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"10\"/" $HOME/.titan/config/app.toml
    sed -i 's/max_num_inbound_peers = 40/max_num_inbound_peers = 100/' -e 's/max_num_outbound_peers = 10/max_num_outbound_peers = 100/' $HOME/.titan/config/config.toml
    sed -i.bak -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.0025uttnt\"/;" ~/.titan/config/app.toml

    # Configure ports
    node_address="tcp://localhost:53457"
    sed -i -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:53458\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:53457\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:53460\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:53456\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":53466\"%" $HOME/.titan/config/config.toml
    sed -i -e "s%^address = \"tcp://localhost:1317\"%address = \"tcp://0.0.0.0:53417\"%; s%^address = \":8080\"%address = \":53480\"%; s%^address = \"localhost:9090\"%address = \"0.0.0.0:53490\"%; s%^address = \"localhost:9091\"%address = \"0.0.0.0:53491\"%; s%:8545%:53445%; s%:8546%:53446%; s%:6065%:53465%" $HOME/.titan/config/app.toml
    echo "export TITAN_RPC_PORT=$node_address" >> $HOME/.bash_profile
    source $HOME/.bash_profile   

    pm2 start titand -- start && pm2 save && pm2 startup

    # Download snapshot
    titand tendermint unsafe-reset-all --home $HOME/.artelad --keep-addr-book
    curl https://snapshots.dadunode.com/titan/titan_latest_tar.lz4 | lz4 -dc - | tar -xf - -C $HOME/.titan/data
    mv $HOME/.titan/priv_validator_state.json.backup $HOME/.titan/data/priv_validator_state.json

    # Start node process using PM2
    pm2 restart artelad

    echo '====================== Installation completed. Please run source $HOME/.bash_profile to load environment variables ==========================='
}

# Check titan service status
function check_service_status() {
    pm2 list
}

# Titan node log query
function view_logs() {
    pm2 logs titand
}

# Uninstall node function
function uninstall_node() {
    echo "Are you sure you want to uninstall the titan node program? This will delete all related data. [Y/N]"
    read -r -p "Please confirm: " response

    case "$response" in
        [yY][eE][sS]|[yY]) 
            echo "Starting to uninstall the node program..."
            pm2 stop titand && pm2 delete titand
            rm -rf $HOME/.titand $HOME/titan $(which titand)
            echo "Node program uninstalled."
            ;;
        *)
            echo "Uninstall operation canceled."
            ;;
    esac
}

# Create wallet
function add_wallet() {
    titand keys add wallet
}

# Import wallet
function import_wallet() {
    titand keys add wallet --recover
}

# Check balance
function check_balances() {
    read -p "Please enter the wallet address: " wallet_address
    titand query bank balances "$wallet_address"
}

# Check node sync status
function check_sync_status() {
    titand status | jq .SyncInfo
}

# Create validator
function create_validator() {
    read -p "Please enter your wallet address: " wallet_address
    read -p "Please enter your validator name: " moniker
    read -p "Please enter the amount of staking (unit: TTNT): " amount
    read -p "Please enter the commission rate (unit: %, e.g., 10): " rate

    titand tx staking create-validator \
        --amount "${amount}uttnt" \
        --from "$wallet_address" \
        --commission-max-change-rate "0.01" \
        --commission-max-rate "0.2" \
        --commission-rate "0.${rate}" \
        --min-self-delegation "1" \
        --pubkey  "$(titand tendermint show-validator)" \
        --moniker "$moniker" \
        --chain-id titan-1
}

# Start program
function main() {
    echo "========================== Node Installation Menu =========================="
    echo "1. Install Nodejs"
    echo "2. View node logs"
    echo "3. Uninstall Nodejs"
    echo "4. Check node sync status"
    echo "5. Check service status"
    echo "6. Add wallet"
    echo "7. Import wallet"
    echo "8. Check wallet balance"
    echo "9. Create validator"
    echo "0. Exit script"
    echo "=========================================================================="
    read -p "Please select an option [0-9]: " choice

    case "$choice" in
        1) install_node ;;
        2) view_logs ;;
        3) uninstall_node ;;
        4) check_sync_status ;;
        5) check_service_status ;;
        6) add_wallet ;;
        7) import_wallet ;;
        8) check_balances ;;
        9) create_validator ;;
        0) exit 0 ;;
        *) echo "Invalid option, please try again." ;;
    esac
}

main
