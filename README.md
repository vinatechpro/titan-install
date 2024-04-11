Bash shell cài tự động titan-edge L2 Huygens testnet
- Lệnh cài đặt:
```
curl -O https://raw.githubusercontent.com/vinatechpro/titan-install/main/install.sh && chmod u+x install.sh && ./install.sh
```
- Lệnh kiểm tra thông tin node
```
source ~/.bash_profile && titan-edge config show && titan-edge info
```
- Trong trường hợp bạn cần chỉnh sửa Config: `default: 1CPU - 2Gb RAM - 72Gb Storage` 
> Chạy lệnh dưới mở file `config.toml` tìm StorageGB, MemoryGB, Cores để sửa lại thông số cấu hình nếu cần thay đổi.

```
nano /root/.titanedge/config.toml
```
> Sửa xong nhấn `Ctrl` + `X` gõ `y` và nhấn `enter` để lưu.
> Chạy lại lệnh bên dưới để khởi động và xem lại cấu hình.
```
systemctl restart titand.service && titan-edge config show && titan-edge info
```
- Cài đặt cho Azure `2vCPU|6Gb RAM|240Gb Storage`
```
sudo -i && curl -O https://raw.githubusercontent.com/vinatechpro/titan-install/main/az-install.sh && chmod u+x az-install.sh && ./az-install.sh
```
------------
- Link đăng ký Dashboard: https://test1.titannet.io/intiveRegister?code=CtKlIe
- Nhóm Telegram: https://t.me/RetroHubVN
