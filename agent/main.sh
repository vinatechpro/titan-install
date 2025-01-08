#!/bin/bash

# Hàm để dịch văn bản dựa trên ngôn ngữ được chọn
translate() {
  local text="$1"
  case "$LANGUAGE" in
    "vi")
      case "$text" in
        "Script này cần được chạy với quyền root.") echo "Script này cần được chạy với quyền root.";;
        "Lệnh '$1' thất bại.") echo "Lệnh '$1' thất bại.";;
        "Kiểm tra Snap...") echo "Kiểm tra Snap...";;
        "Snap đã được cài đặt.") echo "Snap đã được cài đặt.";;
        "Snap chưa được cài đặt, tiến hành cài đặt...") echo "Snap chưa được cài đặt, tiến hành cài đặt...";;
        "Hệ thống là Debian/Ubuntu.") echo "Hệ thống là Debian/Ubuntu.";;
        "Hệ thống là Fedora.") echo "Hệ thống là Fedora.";;
        "Hệ thống là CentOS/RHEL.") echo "Hệ thống là CentOS/RHEL.";;
        "Hệ thống không được hỗ trợ. Không thể cài Snap tự động.") echo "Hệ thống không được hỗ trợ. Không thể cài Snap tự động.";;
        "Snap đã được cài đặt thành công.") echo "Snap đã được cài đặt thành công.";;
        "Cài đặt Multipass...") echo "Cài đặt Multipass...";;
        "Multipass đã được cài đặt.") echo "Multipass đã được cài đặt.";;
        "Kiểm tra Multipass...") echo "Kiểm tra Multipass...";;
        "Multipass đã sẵn sàng.") echo "Multipass đã sẵn sàng.";;
        "Vui lòng nhập Titan Agent key: ") echo "Vui lòng nhập Titan Agent key: ";;
        "Bạn chưa nhập key. Script dừng.") echo "Bạn chưa nhập key. Script dừng.";;
        "Key không hợp lệ. Script dừng.") echo "Key không hợp lệ. Script dừng.";;
         "Tải và giải nén Titan Agent...") echo "Tải và giải nén Titan Agent...";;
        "Titan Agent đã được tải và giải nén.") echo "Titan Agent đã được tải và giải nén.";;
        "Tạo file service systemd...") echo "Tạo file service systemd...";;
        "Kích hoạt service systemd...") echo "Kích hoạt service systemd...";;
        "Khởi động service systemd...") echo "Khởi động service systemd...";;
        "Kiểm tra trạng thái service systemd...") echo "Kiểm tra trạng thái service systemd...";;
        "Titan Agent đã được cài đặt và khởi động dưới dạng service systemd.") echo "Titan Agent đã được cài đặt và khởi động dưới dạng service systemd.";;
        "Quá trình cài đặt và chạy Titan Agent hoàn tất.") echo "Quá trình cài đặt và chạy Titan Agent hoàn tất.";;
         *) echo "$text";;
      esac
      ;;
    "id")
      case "$text" in
        "Script này cần được chạy với quyền root.") echo "Skrip ini harus dijalankan dengan hak akses root.";;
        "Lệnh '$1' thất bại.") echo "Perintah '$1' gagal.";;
        "Kiểm tra Snap...") echo "Memeriksa Snap...";;
        "Snap đã được cài đặt.") echo "Snap sudah terpasang.";;
        "Snap chưa được cài đặt, tiến hành cài đặt...") echo "Snap belum terpasang, mulai pemasangan...";;
        "Hệ thống là Debian/Ubuntu.") echo "Sistem adalah Debian/Ubuntu.";;
        "Hệ thống là Fedora.") echo "Sistem adalah Fedora.";;
        "Hệ thống là CentOS/RHEL.") echo "Sistem adalah CentOS/RHEL.";;
        "Hệ thống không được hỗ trợ. Không thể cài Snap tự động.") echo "Sistem tidak didukung. Tidak dapat memasang Snap secara otomatis.";;
        "Snap đã được cài đặt thành công.") echo "Snap berhasil terpasang.";;
        "Cài đặt Multipass...") echo "Memasang Multipass...";;
        "Multipass đã được cài đặt.") echo "Multipass berhasil terpasang.";;
        "Kiểm tra Multipass...") echo "Memeriksa Multipass...";;
        "Multipass đã sẵn sàng.") echo "Multipass siap digunakan.";;
        "Vui lòng nhập Titan Agent key: ") echo "Silakan masukkan key Titan Agent: ";;
        "Bạn chưa nhập key. Script dừng.") echo "Anda belum memasukkan key. Skrip berhenti.";;
         "Key không hợp lệ. Script dừng.") echo "Key tidak valid. Skrip berhenti.";;
        "Tải và giải nén Titan Agent...") echo "Mengunduh dan mengekstrak Titan Agent...";;
        "Titan Agent đã được tải và giải nén.") echo "Titan Agent berhasil diunduh dan diekstrak.";;
        "Tạo file service systemd...") echo "Membuat file service systemd...";;
        "Kích hoạt service systemd...") echo "Mengaktifkan service systemd...";;
        "Khởi động service systemd...") echo "Memulai service systemd...";;
        "Kiểm tra trạng thái service systemd...") echo "Memeriksa status service systemd...";;
       "Titan Agent đã được cài đặt và khởi động dưới dạng service systemd.") echo "Titan Agent telah terpasang dan berjalan sebagai service systemd.";;
        "Quá trình cài đặt và chạy Titan Agent hoàn tất.") echo "Proses instalasi dan menjalankan Titan Agent selesai.";;
         *) echo "$text";;
      esac
      ;;
    "ru")
      case "$text" in
        "Script này cần được chạy với quyền root.") echo "Этот скрипт должен быть запущен с правами root.";;
        "Lệnh '$1' thất bại.") echo "Команда '$1' не удалась.";;
       "Kiểm tra Snap...") echo "Проверка Snap...";;
        "Snap đã được cài đặt.") echo "Snap уже установлен.";;
        "Snap chưa được cài đặt, tiến hành cài đặt...") echo "Snap не установлен, начинаю установку...";;
        "Hệ thống là Debian/Ubuntu.") echo "Система Debian/Ubuntu.";;
         "Hệ thống là Fedora.") echo "Система Fedora.";;
        "Hệ thống là CentOS/RHEL.") echo "Система CentOS/RHEL.";;
        "Hệ thống không được hỗ trợ. Không thể cài Snap tự động.") echo "Система не поддерживается. Невозможно установить Snap автоматически.";;
        "Snap đã được cài đặt thành công.") echo "Snap успешно установлен.";;
        "Cài đặt Multipass...") echo "Установка Multipass...";;
        "Multipass đã được cài đặt.") echo "Multipass установлен.";;
        "Kiểm tra Multipass...") echo "Проверка Multipass...";;
        "Multipass đã sẵn sàng.") echo "Multipass готов к использованию.";;
         "Vui lòng nhập Titan Agent key: ") echo "Пожалуйста, введите ключ Titan Agent: ";;
        "Bạn chưa nhập key. Script dừng.") echo "Вы не ввели ключ. Скрипт остановлен.";;
       "Key không hợp lệ. Script dừng.") echo "Неверный ключ. Скрипт остановлен.";;
        "Tải và giải nén Titan Agent...") echo "Загрузка и распаковка Titan Agent...";;
        "Titan Agent đã được tải và giải nén.") echo "Titan Agent был загружен и распакован.";;
        "Tạo file service systemd...") echo "Создание файла службы systemd...";;
        "Kích hoạt service systemd...") echo "Активация службы systemd...";;
        "Khởi động service systemd...") echo "Запуск службы systemd...";;
        "Kiểm tra trạng thái service systemd...") echo "Проверка статуса службы systemd...";;
        "Titan Agent đã được cài đặt và khởi động dưới dạng service systemd.") echo "Titan Agent установлен и запущен как служба systemd.";;
        "Quá trình cài đặt và chạy Titan Agent hoàn tất.") echo "Установка и запуск Titan Agent завершены.";;
        *) echo "$text";;
      esac
      ;;
    *)
      echo "$text"
      ;;
  esac
}

# Đặt ngôn ngữ mặc định là tiếng Anh
LANGUAGE="en"

# Lấy tham số ngôn ngữ từ dòng lệnh
while [[ $# -gt 0 ]]; do
  case "$1" in
    --ver=*)
      LANGUAGE="${1#--ver=}"
      shift
      ;;
    *)
      break
      ;;
  esac
done

# Kiểm tra xem user có phải là root hay không
if [[ $EUID -ne 0 ]]; then
   translate "Script này cần được chạy với quyền root."
   exit 1
fi

# Hàm kiểm tra xem lệnh có thành công không
check_command() {
  if [[ $? -ne 0 ]]; then
    translate "Lệnh '$1' thất bại."
    exit 1
  fi
}

# Kiểm tra xem Snap đã được cài đặt chưa
translate "Kiểm tra Snap..."
if snap --version &> /dev/null; then
  translate "Snap đã được cài đặt."
else
  translate "Snap chưa được cài đặt, tiến hành cài đặt..."
  if command -v apt &> /dev/null; then
    translate "Hệ thống là Debian/Ubuntu."
    apt update
    check_command "apt update"
    apt install -y snapd
    check_command "apt install -y snapd"
  elif command -v dnf &> /dev/null; then
    translate "Hệ thống là Fedora."
    dnf install -y snapd
    check_command "dnf install -y snapd"
  elif command -v yum &> /dev/null; then
     translate "Hệ thống là CentOS/RHEL."
    yum install -y snapd
    check_command "yum install -y snapd"
  else
      translate "Hệ thống không được hỗ trợ. Không thể cài Snap tự động."
      exit 1
  fi
  systemctl enable --now snapd.socket
  check_command "systemctl enable --now snapd.socket"
  translate "Snap đã được cài đặt thành công."
fi

# Cài đặt Multipass
translate "Cài đặt Multipass..."
snap install multipass
check_command "snap install multipass"
translate "Multipass đã được cài đặt."

# Kiểm tra Multipass
translate "Kiểm tra Multipass..."
multipass --version
check_command "multipass --version"
translate "Multipass đã sẵn sàng."

# Lấy key từ tham số hoặc yêu cầu nhập
if [ -z "$1" ]; then
    read -p "$(translate "Vui lòng nhập Titan Agent key: ")" KEY
    if [ -z "$KEY" ]; then
       translate "Bạn chưa nhập key. Script dừng."
        exit 1
    fi
else
    KEY_ARG=$1
    KEY=$(echo "$KEY_ARG" | sed 's/--key=//g')
    if [ -z "$KEY" ]; then
        translate "Key không hợp lệ. Script dừng."
        exit 1
    fi
fi

# Tải và giải nén Titan Agent
translate "Tải và giải nén Titan Agent..."
wget https://pcdn.titannet.io/test4/bin/agent-linux.zip
check_command "wget https://pcdn.titannet.io/test4/bin/agent-linux.zip"
mkdir -p /root/titanagent
check_command "mkdir -p /root/titanagent"
unzip agent-linux.zip -d /usr/local
check_command "unzip agent-linux.zip -d /usr/local"
translate "Titan Agent đã được tải và giải nén."

# Lấy tên người dùng hiện tại
USER=$(whoami)

# Tạo file service systemd
translate "Tạo file service systemd..."
cat <<EOF | sudo tee /etc/systemd/system/titanagent.service
[Unit]
Description=Titan Agent
After=network.target

[Service]
WorkingDirectory=/root/titanagent
ExecStart=agent --working-dir=/root/titanagent --server-url=https://test4-api.titannet.io --key="$KEY"
Restart=on-failure
User=$USER
Group=$USER

[Install]
WantedBy=multi-user.target
EOF
check_command "Tạo file service systemd"

# Kích hoạt service
translate "Kích hoạt service systemd..."
sudo systemctl enable titanagent
check_command "sudo systemctl enable titanagent"

# Khởi động service
translate "Khởi động service systemd..."
sudo systemctl start titanagent
check_command "sudo systemctl start titanagent"

# Kiểm tra trạng thái service
translate "Kiểm tra trạng thái service systemd..."
sudo systemctl status titanagent
check_command "sudo systemctl status titanagent"
translate "Titan Agent đã được cài đặt và khởi động dưới dạng service systemd."

translate "Quá trình cài đặt và chạy Titan Agent hoàn tất."
