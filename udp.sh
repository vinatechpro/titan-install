#!/bin/bash

# Giá trị mới cho UDP buffer size
BUFFER_SIZE_MAX=8388608
BUFFER_SIZE_DEFAULT=1048576

# Cập nhật giá trị trong sysctl
echo "Cấu hình UDP buffer size..."
sudo sysctl -w net.core.rmem_max=$BUFFER_SIZE_MAX
sudo sysctl -w net.core.wmem_max=$BUFFER_SIZE_MAX
sudo sysctl -w net.core.rmem_default=$BUFFER_SIZE_DEFAULT
sudo sysctl -w net.core.wmem_default=$BUFFER_SIZE_DEFAULT

# Ghi vào sysctl.conf để duy trì sau reboot
echo "Lưu cấu hình vào /etc/sysctl.conf..."
sudo tee -a /etc/sysctl.conf > /dev/null <<EOF
net.core.rmem_max=$BUFFER_SIZE_MAX
net.core.wmem_max=$BUFFER_SIZE_MAX
net.core.rmem_default=$BUFFER_SIZE_DEFAULT
net.core.wmem_default=$BUFFER_SIZE_DEFAULT
EOF

# Áp dụng thay đổi
sudo sysctl -p

echo "Hoàn tất! Kiểm tra lại bằng: sysctl -a | grep net.core"