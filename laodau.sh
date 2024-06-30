#!/bin/bash

# 检查是否以root用户运行脚本
if [ "$(id -u)" != "0" ]; then
    echo "This script needs to be run with root user privileges."
    echo "Please try to switch to the root user using 'sudo -i' command and then run this script again."
    exit 1
fi

# 检查并安装 Node.js 和 npm
function install_nodejs_and_npm() {
    if command -v node > /dev/null 2>&1; then
        echo "Node.js Installed"
    else
        echo "Node.js Not installed, installing..."
        curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
        sudo apt-get install -y nodejs
    fi

    if command -v npm > /dev/null 2>&1; then
        echo "npm installed"
    else
        echo "npm Not installed, installing..."
        sudo apt-get install -y npm
    fi
}

# 检查并安装 PM2
function install_pm2() {
    if command -v pm2 > /dev/null 2>&1; then
        echo "PM2 Installed"
    else
        echo "PM2 Not installed, installing..."
        npm install pm2@latest -g
    fi
}

# 自动设置快捷键的功能
function check_and_set_alias() {
    local alias_name="art"
    local shell_rc="$HOME/.bashrc"

    # 对于Zsh用户，使用.zshrc
    if [ -n "$ZSH_VERSION" ]; then
        shell_rc="$HOME/.zshrc"
    elif [ -n "$BASH_VERSION" ]; then
        shell_rc="$HOME/.bashrc"
    fi

    # 检查快捷键是否已经设置
    if ! grep -q "$alias_name" "$shell_rc"; then
        echo "Set shortcut keys '$alias_name' to $shell_rc"
        echo "alias $alias_name='bash $SCRIPT_PATH'" >> "$shell_rc"
        # 添加提醒用户激活快捷键的信息
        echo "shortcut key '$alias_name' Already set. Please run 'source $shell_rc' to activate the shortcut, or reopen the terminal."
    else
        # 如果快捷键已经设置，提供一个提示信息
        echo "shortcut key '$alias_name' Already set in $shell_rc。"
        echo "If the shortcut doesn't work, try running 'source $shell_rc' Or reopen the terminal."
    fi
}

# 节点安装功能
function install_node() {
    install_nodejs_and_npm
    install_pm2

    # 设置变量


    # 更新和安装必要的软件
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y curl iptables build-essential git wget jq make gcc nano tmux htop nvme-cli pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip libleveldb-dev lz4 snapd

    # 安装 Go
        sudo rm -rf /usr/local/go
        curl -L https://go.dev/dl/go1.22.0.linux-amd64.tar.gz | sudo tar -xzf - -C /usr/local
        echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile
        source $HOME/.bash_profile
        go version

    # 安装所有二进制文件
    cd $HOME
    git clone https://github.com/nezha90/titan.git
    cd titan
    go build ./cmd/titand
    cp titand /usr/local/bin

    # 配置titand
    export MONIKER="TitanNo1"
    titand init $MONIKER --chain-id titan-test-1
    titand config node tcp://localhost:53457

    # 获取初始文件和地址簿
    wget https://raw.githubusercontent.com/nezha90/titan/main/genesis/genesis.json
    mv genesis.json ~/.titan/config/genesis.json

    # 配置节点
    SEEDS="bb075c8cc4b7032d506008b68d4192298a09aeea@47.76.107.159:26656"
    PEERS=""
    sed -i 's|^persistent_peers *=.*|persistent_peers = "'$PEERS'"|' $HOME/.titan/config/config.toml

    wget https://raw.githubusercontent.com/nezha90/titan/main/addrbook/addrbook.json
    mv addrbook.json ~/.titan/config/addrbook.json

    # 配置裁剪
    sed -i -e "s/^pruning *=.*/pruning = \"custom\"/" $HOME/.titan/config/app.toml
    sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"100\"/" $HOME/.titan/config/app.toml
    sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"0\"/" $HOME/.titan/config/app.toml
    sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"10\"/" $HOME/.titan/config/app.toml
    sed -i -e 's/max_num_inbound_peers = 40/max_num_inbound_peers = 100/' -e 's/max_num_outbound_peers = 10/max_num_outbound_peers = 100/' $HOME/.titan/config/config.toml
    sed -i.bak -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.0025uttnt\"/;" ~/.titan/config/app.toml

    # 配置端口
    node_address="tcp://localhost:53457"
    sed -i -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:53458\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:53457\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:53460\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:53456\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":53466\"%" $HOME/.titan/config/config.toml
    sed -i -e "s%^address = \"tcp://localhost:1317\"%address = \"tcp://0.0.0.0:53417\"%; s%^address = \":8080\"%address = \":53480\"%; s%^address = \"localhost:9090\"%address = \"0.0.0.0:53490\"%; s%^address = \"localhost:9091\"%address = \"0.0.0.0:53491\"%; s%:8545%:53445%; s%:8546%:53446%; s%:6065%:53465%" $HOME/.titan/config/app.toml
    echo "export TITAN_RPC_PORT=$node_address" >> $HOME/.bash_profile
    source $HOME/.bash_profile   

    pm2 start titand -- start && pm2 save && pm2 startup

    # 下载快照
    titand tendermint unsafe-reset-all --home $HOME/.artelad --keep-addr-book
    curl https://snapshots.dadunode.com/titan/titan_latest_tar.lz4 | lz4 -dc - | tar -xf - -C $HOME/.titan/data
    mv $HOME/.titan/priv_validator_state.json.backup $HOME/.titan/data/priv_validator_state.json

    # 使用 PM2 启动节点进程

    pm2 restart artelad
    

    echo '====================== After the installation is complete, please exit the script and execute source $HOME/.bash_profile to load the environment variables ==========================='
    
}

# 查看titan 服务状态
function check_service_status() {
    pm2 list
}

# titan 节点日志查询
function view_logs() {
    pm2 logs titand
}

# 卸载节点功能
function uninstall_node() {
    echo "Are you sure you want to uninstall the titan node program? This will delete all related data。[Y/N]"
    read -r -p "please confirm: " response

    case "$response" in
        [yY][eE][sS]|[yY]) 
            echo "Start uninstalling the node program..."
            pm2 stop titand && pm2 delete titand
            rm -rf $HOME/.titand $HOME/titan $(which titand)
            echo "Node program uninstallation completed"
            ;;
        *)
            echo "Cancel the uninstallation operation."
            ;;
    esac
}

# 创建钱包
function add_wallet() {
    titand keys add wallet
}

# 导入钱包
function import_wallet() {
    titand keys add wallet --recover
}

# 查询余额
function check_balances() {
    read -p "Please enter a wallet address: " wallet_address
    titand query bank balances "$wallet_address"
}

# 查看节点同步状态
function check_sync_status() {
    titand status | jq .SyncInfo
}

# 创建验证者
function add_validator() {
    read -p "Please enter a wallet name: " wallet_name
    read -p "Please enter a validator name: " validator_name
    
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


# 给自己地址验证者质押
function delegate_self_validator() {
read -p "Please enter the amount of tokens staked: " math
read -p "Please enter a wallet name: " wallet_name
titand tx staking delegate $(titand keys show $wallet_name --bech val -a)  ${math}art --from $wallet_name --fees 500uttnt

}

# 导出验证者key
function export_priv_validator_key() {
    echo "====================Please back up all the following contents in your own notepad or excel sheet==========================================="
    cat ~/.titan/config/priv_validator_key.json
    
}


function update_script() {
    SCRIPT_URL="https://raw.githubusercontent.com/a3165458/titan/main/titan.sh"
    curl -o $SCRIPT_PATH $SCRIPT_URL
    chmod +x $SCRIPT_PATH
    echo "The script has been updated. Please exit the script and execute bash laodau.sh to rerun the script."
}

# 主菜单
function main_menu() {
    while true; do
        clear
        echo "============================Titan Node Installation===================================="
        echo "To exit the script, press ctrl c on the keyboard"
        echo "Please choose the operation you want to execute:"
        echo "1. Install node"
        echo "2. Create wallet"
        echo "3. Import wallet"
        echo "4. Check wallet address balance"
        echo "5. Check node sync status"
        echo "6. Check current service status"
        echo "7. View logs"
        echo "8. Uninstall node"
        echo "9. Set alias"  
        echo "10. Create validator"  
        echo "11. Delegate to self" 
        echo "12. Backup validator private key" 
        echo "13. Update this script" 
        read -p "Please enter the option (1-13): " OPTION


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

# 显示主菜单
main_menu
