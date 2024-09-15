# Hướng dẫn cài đặt Titan node trên Windows
> - Tài liệu chính thức: https://titannet.gitbook.io/titan-network-en/huygens-testnet/installation-and-earnings/less-than-greater-than-command-line-installation
> - Link đăng ký Dashboard (ref): https://test1.titannet.io/intiveRegister?code=CtKlIe

### UPDATE: Phiên bản mới nhất hiện tại là v0.1.20 - Tải theo đường link v0.1.20 và làm theo các bước tương tự.
### Bước 1: Cài đặt Terminal & Download Titan node v0.1.16
  - Cài đặt Terminal: https://apps.microsoft.com/detail/9n0dx20hk701?rtc=1&hl=vi-vn&gl=VN
  - Download Titan node (v0.1.16): https://github.com/Titannet-dao/titan-node/releases/download/v0.1.16/titan_v0.1.16_windows_amd64.tar.gz
  - Download Titan node (v0.1.18): https://github.com/Titannet-dao/titan-node/releases/download/v0.1.18/titan_v0.1.18_windows_amd64.tar.gz
 - Download Titan node (v0.1.20):
https://github.com/Titannet-dao/titan-node/releases/download/v0.1.20/titan-edge_v0.1.20_246b9dd_widnows_amd64.tar.gz
### Bước 2: Giải nén file tải về `titan_v0.1.16_windows_amd64.tar.gz`
- Kết quả giải nén:
  
  ![image](https://github.com/vinatechpro/titan-install/assets/149946061/8cd22c7a-13ea-49c9-85ca-9a17d2006498)
- Chúng ta sẽ làm việc tại thư mục `C:\Users\username-cua-ban` tạo 1 thư mục mới đặt tên `titan` và copy toàn bộ file giải nén vào đây (Xem hình dưới)
  
    ![1](https://github.com/vinatechpro/titan-install/assets/149946061/28ead3d1-9784-4549-a30b-7565a5f58304)
### Bước 3: Mở terminal và đi tới thư mục titan `C:\Users\username-cua-ban\titan`
- Lệnh: `cd C:\Users\username-cua-ban\titan`
  
  ![image](https://github.com/vinatechpro/titan-install/assets/149946061/5ba39289-9dc4-4258-9da4-839d51e3843d)

- Khởi tạo titan-node:

  ```
  ./titan-edge daemon start --init --url https://test-locator.titannet.io:5000/rpc/v0
  ```

- Giữ nguyên cửa sổ `terminal (1)` và mở thêm 1 `terminal (2)` tương tự chạy lệnh bên dưới
  > Chú ý: trong lệnh có từ khóa `your-hash-here` bạn cần thay thế thành mã hash lấy trong Dashboard của bạn.

  ```
  ./titan-edge bind --hash=your-hash-here https://api-test1.container1.titannet.io/api/v2/device/binding
  ```
  ![3](https://github.com/vinatechpro/titan-install/assets/149946061/be95ec0d-7411-4c17-8503-3c8e950c9558)


  > Hash Key trong Dashboard
  
  ![2](https://github.com/vinatechpro/titan-install/assets/149946061/45fbfe66-4b17-44cc-a96c-5bfbc86d92c2)

  - Sau khi chạy xong lệnh trên khoảng 5-10s thì có thể tắt `terminal (2)` quay lại làm việc với `terminal 1`
  - Tại cửa sổ `terminal (1)` bạn nhấn đồng thời phím `Ctrl + C` để dừng chương trình và chạy lệnh dưới để khởi động lại.

    ```
    ./titan-edge daemon start
    ```
  
  > Đây là lệnh chính để chạy titan node, nếu chương trình bị dừng hoặc lần sau bạn muốn khởi động thì mở terminal `cd` tới thư mục `titan` và chạy lệnh `start` trên là được.

  ![image](https://github.com/vinatechpro/titan-install/assets/149946061/3bf7bac7-98fe-4ec5-a30d-68d4d55a05e2)


> Về cơ bản thì như vậy là đã chạy được `titan-node` bạn cần giữ nguyên cửa sổ `Terminal` trong quá trình chạy. Nhưng cấu hình là mặc định, nếu bạn muốn thay đổi cấu hình làm theo hướng dẫn bên dưới

### Hướng dẫn thay đổi cấu hình titan-edge
  - Truy cập thư mục: `C:\Users\username-cua-ban\.titanedge` tìm và sửa file `config.toml`
    
    ![image](https://github.com/vinatechpro/titan-install/assets/149946061/a7015dcd-1acf-4645-b694-3e3ba83b8688)
  - Mở file `config.toml` bằng `notepad` hoặc `visual studio code` hay bất kỳ phần mềm chỉnh sửa text nào... Tìm các đầu mục `#StorageGB` `#MemoryGB` `#Cores` bỏ dấu `#` đi và sửa lại thông số bạn mong muốn. Lưu lại và khởi động lại `titan-edge`.

    ![image](https://github.com/vinatechpro/titan-install/assets/149946061/6fda401d-d8ef-4615-8932-65faeea4b334)

