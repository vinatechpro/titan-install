#!/bin/bash

Các giá trị UDP buffer mong muốn

RMEM_MAX=2500000 WMEM_MAX=2500000 RMEM_DEFAULT=2500000 WMEM_DEFAULT=2500000

Thêm hoặc cập nhật các giá trị trong /etc/sysctl.conf

grep -q "net.core.rmem_max" /etc/sysctl.conf && sudo sed -i "s/net.core.rmem_max./net.core.rmem_max=$RMEM_MAX/" /etc/sysctl.conf || echo "net.core.rmem_max=$RMEM_MAX" | sudo tee -a /etc/sysctl.conf grep -q "net.core.wmem_max" /etc/sysctl.conf && sudo sed -i "s/net.core.wmem_max./net.core.wmem_max=$WMEM_MAX/" /etc/sysctl.conf || echo "net.core.wmem_max=$WMEM_MAX" | sudo tee -a /etc/sysctl.conf grep -q "net.core.rmem_default" /etc/sysctl.conf && sudo sed -i "s/net.core.rmem_default./net.core.rmem_default=$RMEM_DEFAULT/" /etc/sysctl.conf || echo "net.core.rmem_default=$RMEM_DEFAULT" | sudo tee -a /etc/sysctl.conf grep -q "net.core.wmem_default" /etc/sysctl.conf && sudo sed -i "s/net.core.wmem_default./net.core.wmem_default=$WMEM_DEFAULT/" /etc/sysctl.conf || echo "net.core.wmem_default=$WMEM_DEFAULT" | sudo tee -a /etc/sysctl.conf

Áp dụng thay đổi ngay lập tức

sudo sysctl -p

Kiểm tra lại giá trị

sysctl net.core.rmem_max sysctl net.core.wmem_max sysctl net.core.rmem_default sysctl net.core.wmem_default

echo "Cấu hình UDP buffer đã được cập nhật thành công."