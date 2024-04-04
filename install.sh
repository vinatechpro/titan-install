#!/bin/bash

# Lấy giá trị hash từ terminal
echo "Nhap ma Hash cua ban (Identity code): "
read hash_value

# Kiểm tra nếu hash_value là chuỗi rỗng (người dùng chỉ nhấn Enter) thì dừng chương trình
if [ -z "$hash_value" ]; then
    echo "Không có giá trị hash được nhập. Dừng chương trình."
    exit 1
fi

storage_size="72"
memory_size="4"
cpu_core="2"

service_content="
[Unit]
Description=Titan Node
After=network.target
StartLimitIntervalSec=0

[Service]
User=root
ExecStart=/usr/local/titan/titan-edge daemon start
Restart=always
RestartSec=15

[Install]
WantedBy=multi-user.target
"

# Update package lists and install nano
sudo apt-get update
sudo apt-get install -y nano

# Download Titan Node binary
wget https://github.com/Titannet-dao/titan-node/releases/download/v0.1.16/titan_v0.1.16_linux_amd64.tar.gz

# Extract Titan Node binary to /usr/local
sudo tar -xf titan_v0.1.16_linux_amd64.tar.gz -C /usr/local
# Đổi tên thư mục
sudo mv /usr/local/titan_v0.1.16_linux_amd64 /usr/local/titan

# Clean up downloaded archive
rm titan_v0.1.16_linux_amd64.tar.gz

# Tạo tập tin .bash_profile nếu nó chưa tồn tại và mở nó để chỉnh sửa
touch ~/.bash_profile
# nano ~/.bash_profile

# Sau khi mở tập tin, bạn có thể sao chép nội dung cần thiết vào đó. Ví dụ:
echo 'export PATH=$PATH:/usr/local/titan' >> ~/.bash_profile

# Load lại cấu hình bash để áp dụng thay đổi mà không cần phải đăng nhập lại
source ~/.bash_profile

# Chạy titan edge
titan-edge daemon start --init --url https://test-locator.titannet.io:5000/rpc/v0 &
daemon_pid=$!
echo "PID của titan-edge daemon: $daemon_pid"

titan-edge bind --hash="$hash_value" https://api-test1.container1.titannet.io/api/v2/device/binding&
bind_pid=$!
echo "PID của titan-edge bind: $bind_pid"


# Kiểm tra xem tệp cấu hình có tồn tại không
config_file="/root/.titanedge/config.toml"
if [ -f "$config_file" ]; then
    # Sử dụng lệnh sed để thay đổi nội dung của tệp
    sed -i "s/#StorageGB = 2/StorageGB = $storage_size/" "$config_file"
    echo "Đã thay đổi kích thước lưu trữ cơ sở dữ liệu thành $storage_size GB."
    sed -i "s/#MemoryGB = 1/MemoryGB = $memory_size/" "$config_file"
    echo "Đã thay đổi kích thước memory liệu thành $memory_size GB."
    sed -i "s/#Cores = 1/Cores = $cpu_core/" "$config_file"
    echo "Đã thay đổi core cpu liệu thành $cpu_core GB."
else
    echo "Lỗi: Tệp cấu hình $config_file không tồn tại."
fi

echo "$service_content" | sudo tee /etc/systemd/system/titand.service > /dev/null

# Sau khi thực hiện xong lệnh trong Terminal 2, dừng lệnh của Terminal 1
kill $daemon_pid

# Reload systemd daemon để cập nhật thông tin về các dịch vụ
sudo systemctl daemon-reload

# Bật dịch vụ titand để khởi động cùng với hệ thống
sudo systemctl enable titand.service

# Khởi động dịch vụ titand
sudo systemctl start titand.service


titan-edge info && titan-edge config show