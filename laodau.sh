#!/bin/bash

# Check if the script is run as root user
if [ "$(id -u)" != "0" ]; then
    echo "This script needs to be run with root user privileges."
    echo "Please try switching to root user using the 'sudo -i' command, and then run this script again."
    exit 1
fi

# Check and install Node.js and npm
function install_nodejs_and_npm() {
    if command -v node > /dev/null 2>&1; then
        echo "Node.js is already installed"
    else
        echo "Node.js is not installed, installing..."
        curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
        sudo apt-get install -y nodejs
    fi

    if command -v npm > /dev/null 2>&1; then
        echo "npm is already installed"
    else
        echo "npm is not installed, installing..."
        sudo apt-get install -y npm
    fi
}

# Check and install PM2
function install_pm2() {
    if command -v pm2 > /dev/null 2>&1; then
        echo "PM2 is already installed"
    else
        echo "PM2 is not installed, installing..."
        npm install pm2@latest -g
    fi
}

# Function to automatically set aliases
function check_and_set_alias() {
    local alias_name="art"
    local shell_rc="$HOME/.bashrc"

    # For Zsh users, use .zshrc
    if [ -n "$ZSH_VERSION" ]; then
        shell_rc="$HOME/.zshrc"
    elif [ -n "$BASH_VERSION" ]; then
        shell_rc="$HOME/.bashrc"
    fi

    # Check if the alias is already set
    if ! grep -q "$alias_name" "$shell_rc"; then
        echo "Setting alias '$alias_name' in $shell_rc"
        echo "alias $alias_name='bash $SCRIPT_PATH'" >> "$shell_rc"
        # Add a reminder to the user to activate the alias
        echo "Alias '$alias_name' has been set. Please run 'source $shell_rc' to activate the alias, or reopen the terminal."
    else
        # If the alias is already set, provide a reminder
        echo "Alias '$alias_name' is already set in $shell_rc."
        echo "If the alias does not work, try running 'source $shell_rc' or reopen the terminal."
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
    export MONIKER="My_Node"
    titand init $MONIKER --chain-id titan-test-1
    titand config node tcp://localhost:53457

    # Get initial files and address book
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

    # Start the node process with PM2
    pm2 restart artelad

    echo '====================== Installation complete, please run source $HOME/.bash_profile after exiting the script to load environment variables ==========================='
    
}

# Check the status of the titan service
function check_service_status() {
    pm2 list
}

# Query titan node logs
function view_logs() {
    pm2 logs titand
}

# Node uninstallation function
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
    read -p "Please enter wallet address: " wallet_address
    titand query bank balances "$wallet_address"
}

# Check node sync status
function check_sync_status() {
    titand status | jq .SyncInfo
}

# Create validator
function add_validator() {
    read -p "Please enter your wallet name: " wallet_name
    read -p "Please enter the name you want to set for the validator: " validator_name
    
    titand tx staking create-validator \
    --amount="1000000uttnt" \
    --pubkey=$(titand tendermint show-validator) \
    --moniker="$validator_name" \
    --commission-max-change-rate=0.01 \
    --commission-max-rate=1.0 \
    --commission-rate=0.07 \
    --min-self-delegation=1 \
    --fees 500uttnt \
    --from="$wallet_name" 
}

# Delegate to own validator
function delegate_self_validator() {
    read -p "Please enter the amount of tokens to delegate: " math
    read -p "Please enter wallet name: " wallet_name
    titand tx staking delegate $(titand keys show $wallet_name --bech val -a)  ${math}art --from $wallet_name --fees 500uttnt
}

# Export validator key
function export_priv_validator_key() {
    echo "==================== Please backup all the content below to your own notepad or Excel sheet ==========================================="
    cat ~/.titan/config/priv_validator_key.json
}

function update_script() {
    SCRIPT_URL="https://raw.githubusercontent.com/vinatechpro/titan-install/main/laodau.sh"
    curl -o $SCRIPT_PATH $SCRIPT_URL
    chmod +x $SCRIPT_PATH
    echo "The script has been updated. Please exit the script, and run bash titan.sh to rerun this script."
}

# Main menu
function main_menu() {
    while true; do
        clear
        echo "============================ Titan Validator Installation ===================================="
        echo "To exit the script, press ctrl c on your keyboard to exit"
        echo "Please choose an operation to execute:"
        echo "1. Install Nodejs"
        echo "2. Create wallet"
        echo "3. Import wallet"
        echo "4. Check wallet address balance"
        echo "5. Check node Validator sync status"
        echo "6. Check current service status"
        echo "7. Query run logs"
        echo "8. Uninstall Nodejs"
        echo "9. Set alias"  
        echo "10. Create validator"  
        echo "11. Delegate to own validator" 
        echo "12. Backup validator private key" 
        echo "13. Update this script" 
        read -p "Please enter an option (1-13): " OPTION

        case $OPTION in
        1) install_node ;;
        2) add_wallet ;;
        3) import_wallet ;;
        4) check_balances ;;
        5) check_sync_status ;;
        6) check_service_status ;;
        7) view_logs ;;
        8) uninstall_node ;;
        9) check_and_set_alias ;;
        10) add_validator ;;
        11) delegate_self_validator ;;
        12) export_priv_validator_key ;;
        13) update_script ;;
        *) echo "Invalid option." ;;
        esac
        echo "Press any key to return to the main menu..."
        read -n 1
    done
}

# Show main menu
main_menu
