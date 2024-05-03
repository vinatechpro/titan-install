#!/bin/bash
version='v0.1.18'
echo "Titan node update version: $version"
echo "..."

echo "Tạm dừng titand.service"
systemctl stop titand.service && rm -rf /usr/local/titan

echo "Tải về titan-node $version"
wget https://github.com/Titannet-dao/titan-node/releases/download/v0.1.18/titan_v0.1.18_linux_amd64.tar.gz
sudo tar -xf titan_v0.1.18_linux_amd64.tar.gz -C /usr/local
sudo mv /usr/local/titan_v0.1.18_linux_amd64 /usr/local/titan
rm titan_v0.1.18_linux_amd64.tar.gz
source ~/.bash_profile

echo "Khởi động lại titand.service"
sudo systemctl restart titand.service

sleep 8
# Hiển thị thông tin và cấu hình của titan-edge
sudo systemctl status titand.service && titan-edge config show && titan-edge info