#!/bin/bash

# Function to translate text based on the selected language
translate() {
  local text="$1"
  local translated_text

  case "$LANGUAGE" in
    "vi")
      case "$text" in
        "Script này cần được chạy với quyền root.") translated_text="Script này cần được chạy với quyền root.";;
        "Lệnh '$1' thất bại.") translated_text="Lệnh '$1' thất bại.";;
        "Kiểm tra Snap...") translated_text="Kiểm tra Snap...";;
        "Snap đã được cài đặt.") translated_text="Snap đã được cài đặt.";;
        "Snap chưa được cài đặt, tiến hành cài đặt...") translated_text="Snap chưa được cài đặt, tiến hành cài đặt...";;
        "Hệ thống là Debian/Ubuntu.") translated_text="Hệ thống là Debian/Ubuntu.";;
        "Hệ thống là Fedora.") translated_text="Hệ thống là Fedora.";;
        "Hệ thống là CentOS/RHEL.") translated_text="Hệ thống là CentOS/RHEL.";;
        "Hệ thống không được hỗ trợ. Không thể cài Snap tự động.") translated_text="Hệ thống không được hỗ trợ. Không thể cài Snap tự động.";;
        "Snap đã được cài đặt thành công.") translated_text="Snap đã được cài đặt thành công.";;
        "Cài đặt Multipass...") translated_text="Cài đặt Multipass...";;
        "Multipass đã được cài đặt.") translated_text="Multipass đã được cài đặt.";;
        "Kiểm tra Multipass...") translated_text="Kiểm tra Multipass...";;
        "Multipass đã sẵn sàng.") translated_text="Multipass đã sẵn sàng.";;
        "Vui lòng nhập Titan Agent key: ") translated_text="Vui lòng nhập Titan Agent key: ";;
        "Bạn chưa nhập key. Script dừng.") translated_text="Bạn chưa nhập key. Script dừng.";;
        "Key không hợp lệ. Script dừng.") translated_text="Key không hợp lệ. Script dừng.";;
         "Tải và giải nén Titan Agent...") translated_text="Tải và giải nén Titan Agent...";;
        "Titan Agent đã được tải và giải nén.") translated_text="Titan Agent đã được tải và giải nén.";;
        "Tạo file service systemd...") translated_text="Tạo file service systemd...";;
        "Kích hoạt service systemd...") translated_text="Kích hoạt service systemd...";;
        "Khởi động service systemd...") translated_text="Khởi động service systemd...";;
        "Kiểm tra trạng thái service systemd...") translated_text="Kiểm tra trạng thái service systemd...";;
        "Titan Agent đã được cài đặt và khởi động dưới dạng service systemd.") translated_text="Titan Agent đã được cài đặt và khởi động dưới dạng service systemd.";;
        "Quá trình cài đặt và chạy Titan Agent hoàn tất.") translated_text="Quá trình cài đặt và chạy Titan Agent hoàn tất.";;
         "Hệ thống không hỗ trợ cài đặt unzip tự động, vui lòng cài đặt thủ công.") translated_text="Hệ thống không hỗ trợ cài đặt unzip tự động, vui lòng cài đặt thủ công.";;
         *) translated_text="$text";;
      esac
      ;;
    "en")
      case "$text" in
        "Script này cần được chạy với quyền root.") translated_text="This script needs to be run with root privileges.";;
        "Lệnh '$1' thất bại.") translated_text="Command '$1' failed.";;
        "Kiểm tra Snap...") translated_text="Checking Snap...";;
        "Snap đã được cài đặt.") translated_text="Snap is already installed.";;
        "Snap chưa được cài đặt, tiến hành cài đặt...") translated_text="Snap is not installed, proceeding with installation...";;
        "Hệ thống là Debian/Ubuntu.") translated_text="System is Debian/Ubuntu.";;
        "Hệ thống là Fedora.") translated_text="System is Fedora.";;
        "Hệ thống là CentOS/RHEL.") translated_text="System is CentOS/RHEL.";;
       "Hệ thống không được hỗ trợ. Không thể cài Snap tự động.") translated_text="System is not supported. Cannot install Snap automatically.";;
        "Snap đã được cài đặt thành công.") translated_text="Snap has been installed successfully.";;
        "Cài đặt Multipass...") translated_text="Installing Multipass...";;
        "Multipass đã được cài đặt.") translated_text="Multipass has been installed.";;
        "Kiểm tra Multipass...") translated_text="Checking Multipass...";;
        "Multipass đã sẵn sàng.") translated_text="Multipass is ready.";;
         "Vui lòng nhập Titan Agent key: ") translated_text="Please enter Titan Agent key: ";;
        "Bạn chưa nhập key. Script dừng.") translated_text="You have not entered a key. Script stopped.";;
        "Key không hợp lệ. Script dừng.") translated_text="Invalid key. Script stopped.";;
         "Tải và giải nén Titan Agent...") translated_text="Downloading and extracting Titan Agent...";;
        "Titan Agent đã được tải và giải nén.") translated_text="Titan Agent has been downloaded and extracted.";;
        "Tạo file service systemd...") translated_text="Creating systemd service file...";;
        "Kích hoạt service systemd...") translated_text="Enabling systemd service...";;
        "Khởi động service systemd...") translated_text="Starting systemd service...";;
        "Kiểm tra trạng thái service systemd...") translated_text="Checking systemd service status...";;
        "Titan Agent đã được cài đặt và khởi động dưới dạng service systemd.") translated_text="Titan Agent has been installed and started as a systemd service.";;
        "Quá trình cài đặt và chạy Titan Agent hoàn tất.") translated_text="Installation and running of Titan Agent completed.";;
         "Hệ thống không hỗ trợ cài đặt unzip tự động, vui lòng cài đặt thủ công.") translated_text="System doesn't support unzip installation, please install it manually.";;
         *) translated_text="$text";;
      esac
      ;;
    "id")
      case "$text" in
        "Script này cần được chạy với quyền root.") translated_text="Skrip ini harus dijalankan dengan hak akses root.";;
        "Lệnh '$1' thất bại.") translated_text="Perintah '$1' gagal.";;
        "Kiểm tra Snap...") translated_text="Memeriksa Snap...";;
        "Snap đã được cài đặt.") translated_text="Snap sudah terpasang.";;
        "Snap belum terpasang, mulai pemasangan...") translated_text="Snap belum terpasang, mulai pemasangan...";;
        "Hệ thống là Debian/Ubuntu.") translated_text="Sistem adalah Debian/Ubuntu.";;
        "Hệ thống là Fedora.") translated_text="Sistem adalah Fedora.";;
        "Hệ thống là CentOS/RHEL.") translated_text="Sistem adalah CentOS/RHEL.";;
        "Hệ thống không được hỗ trợ. Không thể cài Snap tự động.") translated_text="Sistem tidak didukung. Tidak dapat memasang Snap secara otomatis.";;
        "Snap đã được cài đặt thành công.") translated_text="Snap berhasil terpasang.";;
        "Cài đặt Multipass...") translated_text="Memasang Multipass...";;
        "Multipass đã được cài đặt.") translated_text="Multipass berhasil terpasang.";;
        "Kiểm tra Multipass...") translated_text="Memeriksa Multipass...";;
        "Multipass siap digunakan.") translated_text="Multipass siap digunakan.";;
        "Vui lòng nhập Titan Agent key: ") translated_text="Silakan masukkan key Titan Agent: ";;
        "Bạn chưa nhập key. Script dừng.") translated_text="Anda belum memasukkan key. Skrip berhenti.";;
        "Key không hợp lệ. Script dừng.") translated_text="Key tidak valid. Skrip berhenti.";;
        "Tải và giải nén Titan Agent...") translated_text="Mengunduh dan mengekstrak Titan Agent...";;
        "Titan Agent đã được tải và giải nén.") translated_text="Titan Agent berhasil diunduh dan diekstrak.";;
        "Tạo file service systemd...") translated_text="Membuat file service systemd...";;
        "Kích hoạt service systemd...") translated_text="Mengaktifkan service systemd...";;
        "Khởi động service systemd...") translated_text="Memulai service systemd...";;
        "Memeriksa status service systemd...") translated_text="Memeriksa status service systemd...";;
       "Titan Agent telah terpasang dan berjalan sebagai service systemd.") translated_text="Titan Agent telah terpasang dan berjalan sebagai service systemd.";;
        "Quá trình cài đặt và chạy Titan Agent hoàn tất.") translated_text="Proses instalasi dan menjalankan Titan Agent selesai.";;
        "Hệ thống không hỗ trợ cài đặt unzip tự động, vui lòng cài đặt thủ công.") translated_text="Sistem tidak mendukung pemasangan unzip secara otomatis, silakan pasang secara manual.";;
         *) translated_text="$text";;
      esac
      ;;
    "ru")
      case "$text" in
        "Script này cần được chạy với quyền root.") translated_text="Этот скрипт должен быть запущен с правами root.";;
        "Lệnh '$1' thất bại.") translated_text="Команда '$1' не удалась.";;
       "Kiểm tra Snap...") translated_text="Проверка Snap...";;
        "Snap đã được cài đặt.") translated_text="Snap уже установлен.";;
        "Snap не установлен, начинаю установку...") translated_text="Snap не установлен, начинаю установку...";;
        "Система Debian/Ubuntu.") translated_text="Система Debian/Ubuntu.";;
         "Система Fedora.") translated_text="Система Fedora.";;
        "Система CentOS/RHEL.") translated_text="Система CentOS/RHEL.";;
        "Система не поддерживается. Невозможно установить Snap автоматически.") translated_text="Система не поддерживается. Невозможно установить Snap автоматически.";;
        "Snap успешно установлен.") translated_text="Snap успешно установлен.";;
        "Установка Multipass...") translated_text="Установка Multipass...";;
        "Multipass установлен.") translated_text="Multipass установлен.";;
        "Проверка Multipass...") translated_text="Проверка Multipass...";;
        "Multipass готов к использованию.") translated_text="Multipass готов к использованию.";;
         "Пожалуйста, введите ключ Titan Agent: ") translated_text="Пожалуйста, введите ключ Titan Agent: ";;
        "Вы не ввели ключ. Скрипт остановлен.") translated_text="Вы не ввели ключ. Скрипт остановлен.";;
       "Неверный ключ. Скрипт остановлен.") translated_text="Неверный ключ. Скрипт остановлен.";;
        "Загрузка и распаковка Titan Agent...") translated_text="Загрузка и распаковка Titan Agent...";;
        "Titan Agent был загружен и распакован.") translated_text="Titan Agent был загружен и распакован.";;
        "Создание файла службы systemd...") translated_text="Создание файла службы systemd...";;
        "Активация службы systemd...") translated_text="Активация службы systemd...";;
        "Запуск службы systemd...") translated_text="Запуск службы systemd...";;
        "Проверка статуса службы systemd...") translated_text="Проверка статуса службы systemd...";;
        "Titan Agent установлен и запущен как служба systemd.") translated_text="Titan Agent установлен и запущен как служба systemd.";;
        "Установка и запуск Titan Agent завершены.") translated_text="Установка и запуск Titan Agent завершены.";;
       "Hệ thống không hỗ trợ cài đặt unzip tự động, vui lòng cài đặt thủ công.") translated_text="Система не поддерживает автоматическую установку unzip, пожалуйста, установите его вручную.";;
        *) translated_text="$text";;
      esac
      ;;
    *)
      translated_text="$text"
      ;;
  esac
  echo "$translated_text"
}

# Set default language to English
LANGUAGE="en"
KEY=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    --ver=*)
      LANGUAGE="${1#--ver=}"
      shift
      ;;
    --key=*)
      KEY="${1#--key=}"
      shift
      ;;
    *)
      echo "Unknown parameter: $1"
      echo "Usage: $0 [--key=<your_key>] [--ver=<language>]"
      exit 1
      ;;
  esac
done


# Check if the user is root
if [[ $EUID -ne 0 ]]; then
   translate "Script này cần được chạy với quyền root."
   exit 1
fi

# Check if the key is provided
if [ -z "$KEY" ]; then
    translate "Bạn chưa nhập key. Script dừng."
    exit 1
fi

# Validate the key (you can add more complex validation if needed)
if [[ ! "$KEY" =~ ^[a-zA-Z0-9-]+$ ]]; then
    translate "Key không hợp lệ. Script dừng."
    exit 1
fi

# Function to check if a command was successful
check_command() {
  if [[ $? -ne 0 ]]; then
    translate "Lệnh '$1' thất bại."
    exit 1
  fi
}

# Check if Snap is installed
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

# Install Multipass
translate "Cài đặt Multipass..."
snap install multipass
check_command "snap install multipass"
translate "Multipass đã được cài đặt."

# Check Multipass
translate "Kiểm tra Multipass..."
multipass --version
check_command "multipass --version"
translate "Multipass đã sẵn sàng."

# Download and extract Titan Agent
translate "Tải và giải nén Titan Agent..."
wget https://pcdn.titannet.io/test4/bin/agent-linux.zip
check_command "wget https://pcdn.titannet.io/test4/bin/agent-linux.zip"
mkdir -p /root/titanagent
check_command "mkdir -p /root/titanagent"

# Check and install unzip
if ! command -v unzip &> /dev/null; then
    if command -v apt &> /dev/null; then
        apt update
        check_command "apt update"
        apt install -y unzip
        check_command "apt install -y unzip"
    elif command -v dnf &> /dev/null; then
        dnf install -y unzip
        check_command "dnf install -y unzip"
    elif command -v yum &> /dev/null; then
        yum install -y unzip
        check_command "yum install -y unzip"
    else
        translate "Hệ thống không hỗ trợ cài đặt unzip tự động, vui lòng cài đặt thủ công."
        exit 1
    fi
fi

unzip agent-linux.zip -d /usr/local
check_command "unzip agent-linux.zip -d /usr/local"

# Make the agent executable and move to /usr/local/bin
sudo chmod +x /usr/local/agent
check_command "chmod +x /usr/local/agent"
sudo cp /usr/local/agent /usr/local/bin/
check_command "cp /usr/local/agent /usr/local/bin/"

translate "Titan Agent đã được tải và giải nén."

# Get current user
USER=$(whoami)

# Create systemd service file
translate "Tạo file service systemd..."
cat <<EOF | sudo tee /etc/systemd/system/titanagent.service
[Unit]
Description=Titan Agent
After=network.target

[Service]
WorkingDirectory=/root/titanagent
ExecStart=/usr/local/bin/agent --working-dir=/root/titanagent --server-url=https://test4-api.titannet.io --key="$KEY"
Restart=on-failure
User=$USER
Group=$USER

[Install]
WantedBy=multi-user.target
EOF
check_command "Tạo file service systemd"

# Enable service
translate "Kích hoạt service systemd..."
sudo systemctl enable titanagent
check_command "sudo systemctl enable titanagent"

# Start service
translate "Khởi động service systemd..."
sudo systemctl start titanagent
check_command "sudo systemctl start titanagent"

# Check service status
translate "Kiểm tra trạng thái service systemd..."
sudo systemctl status titanagent
check_command "sudo systemctl status titanagent"
translate "Titan Agent đã được cài đặt và khởi động dưới dạng service systemd."

translate "Quá trình cài đặt và chạy Titan Agent hoàn tất."
