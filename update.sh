#!/bin/bash
VERSION='v0.1.18'
echo "Cập nhật Titan node $VERSION"
echo "..."

echo "Tạm dừng titand.service & xóa phiên bản cũ"
systemctl stop titand.service && rm -rf /usr/local/titan
echo "..."

echo "Tải về Titan node $VERSION"
# Tải xuống tệp cài đặt Titan
wget https://github.com/Titannet-dao/titan-node/releases/download/$VERSION/titan_${VERSION}_linux_amd64.tar.gz

# Giải nén tệp cài đặt
sudo tar -xf titan_${VERSION}_linux_amd64.tar.gz -C /usr/local

# Di chuyển thư mục giải nén đến vị trí cài đặt
sudo mv /usr/local/titan_${VERSION}_linux_amd64 /usr/local/titan

# Xóa tệp cài đặt đã giải nén
rm titan_${VERSION}_linux_amd64.tar.gz

echo "Khởi động lại titand.service"
sudo systemctl restart titand.service

sleep 8
# Hiển thị thông tin và cấu hình của titan-edge
sudo systemctl status titand.service && titan-edge config show && titan-edge info
