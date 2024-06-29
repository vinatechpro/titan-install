#!/bin/bash
VERSION='v0.1.19'
echo "Update Titan node ${VERSION}"
echo "..."

echo "Stop titand.service & remove old version"
systemctl stop titand.service && rm -rf /usr/local/titan
echo "..."

echo "Download Titan node ${VERSION}"
# Tải xuống tệp cài đặt Titan
wget https://github.com/Titannet-dao/titan-node/releases/download/${VERSION}/titan-l2edge_${VERSION}_patch_linux_amd64.tar.gz

sudo tar -xf titan-l2edge_${VERSION}_patch_linux_amd64.tar.gz -C /usr/local

sudo mv /usr/local/titan-l2edge_${VERSION}_patch_linux_amd64 /usr/local/titan
sudo cp /usr/local/titan/libgoworkerd.so /usr/lib/libgoworkerd.so

rm titan-l2edge_${VERSION}_patch_linux_amd64.tar.gz

# Định nghĩa nội dung cần thêm
content="
export PATH=\$PATH:/usr/local/titan
export LD_LIBRARY_PATH=\$LD_LIZBRARY_PATH:./libgoworkerd.so
"

# Kiểm tra nếu file ~/.bash_profile chưa tồn tại thì tạo mới, nếu đã tồn tại thì ghi thêm
if [ ! -f ~/.bash_profile ]; then
  echo "$content" > ~/.bash_profile
  source ~/.bash_profile
else
  echo "$content" >> ~/.bash_profile
  source ~/.bash_profile
fi

echo "Export PATH ~/.bash_profile"


echo "Restart titand.service"
sudo systemctl restart titand.service

sleep 8
# Hiển thị thông tin và cấu hình của titan-edge
sudo systemctl status titand.service && titan-edge config show && titan-edge info
