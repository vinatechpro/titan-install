#!/bin/bash
VERSION='v0.1.19'
echo "Update Titan node $VERSION"
echo "..."

echo "Stop titand.service & remove old version"
systemctl stop titand.service && rm -rf /usr/local/titan
echo "..."

echo "Download Titan node $VERSION"
# Tải xuống tệp cài đặt Titan
wget https://github.com/Titannet-dao/titan-node/releases/download/$VERSION/titan_${VERSION}_linux_amd64.tar.gz

# Giải nén tệp cài đặt
sudo tar -xf titan_${VERSION}_linux_amd64.tar.gz -C /usr/local

# Di chuyển thư mục giải nén đến vị trí cài đặt
sudo mv /usr/local/titan_${VERSION}_linux_amd64 /usr/local/titan

# Xóa tệp cài đặt đã giải nén
rm titan_${VERSION}_linux_amd64.tar.gz

echo "Restart titand.service"
sudo systemctl restart titand.service

sleep 8
# Hiển thị thông tin và cấu hình của titan-edge
sudo systemctl status titand.service && titan-edge config show && titan-edge info
