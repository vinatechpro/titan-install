#!/bin/bash

# Function to translate text based on the selected language
translate() {
  local text="$1"
  local translated_text

  case "$LANGUAGE" in
    "vi")
      case "$text" in
        "This script needs to be run with root privileges.") translated_text="Script này cần được chạy với quyền root.";;
        "Command '$1' failed.") translated_text="Lệnh '$1' thất bại.";;
        "Checking Snap...") translated_text="Kiểm tra Snap...";;
        "Snap is already installed.") translated_text="Snap đã được cài đặt.";;
        "Snap is not installed, proceeding with installation...") translated_text="Snap chưa được cài đặt, tiến hành cài đặt...";;
        "System is Debian/Ubuntu.") translated_text="Hệ thống là Debian/Ubuntu.";;
        "System is Fedora.") translated_text="Hệ thống là Fedora.";;
        "System is CentOS/RHEL.") translated_text="Hệ thống là CentOS/RHEL.";;
       "System is not supported. Cannot install Snap automatically.") translated_text="Hệ thống không được hỗ trợ. Không thể cài Snap tự động.";;
        "Snap has been installed successfully.") translated_text="Snap đã được cài đặt thành công.";;
        "Installing Multipass...") translated_text="Cài đặt Multipass...";;
        "Multipass has been installed.") translated_text="Multipass đã được cài đặt.";;
        "Checking Multipass...") translated_text="Kiểm tra Multipass...";;
        "Multipass is ready.") translated_text="Multipass đã sẵn sàng.";;
         "Please enter Titan Agent key: ") translated_text="Vui lòng nhập Titan Agent key: ";;
        "You have not entered a key. Script stopped.") translated_text="Bạn chưa nhập key. Script dừng.";;
        "Invalid key. Script stopped.") translated_text="Key không hợp lệ. Script dừng.";;
         "Downloading and extracting Titan Agent...") translated_text="Tải và giải nén Titan Agent...";;
        "Titan Agent has been downloaded and extracted.") translated_text="Titan Agent đã được tải và giải nén.";;
        "Creating systemd service file...") translated_text="Tạo file service systemd...";;
        "Enabling systemd service...") translated_text="Kích hoạt service systemd...";;
        "Starting systemd service...") translated_text="Khởi động service systemd...";;
        "Checking systemd service status...") translated_text="Kiểm tra trạng thái service systemd...";;
        "Titan Agent has been installed and started as a systemd service.") translated_text="Titan Agent đã được cài đặt và khởi động dưới dạng service systemd.";;
        "Installation and running of Titan Agent completed.") translated_text="Quá trình cài đặt và chạy Titan Agent hoàn tất.";;
        *) translated_text="$text";;
      esac
      ;;
    "en")
     case "$text" in
        "This script needs to be run with root privileges.") translated_text="This script needs to be run with root privileges.";;
        "Command '$1' failed.") translated_text="Command '$1' failed.";;
        "Checking Snap...") translated_text="Checking Snap...";;
        "Snap is already installed.") translated_text="Snap is already installed.";;
        "Snap is not installed, proceeding with installation...") translated_text="Snap is not installed, proceeding with installation...";;
        "System is Debian/Ubuntu.") translated_text="System is Debian/Ubuntu.";;
        "System is Fedora.") translated_text="System is Fedora.";;
        "System is CentOS/RHEL.") translated_text="System is CentOS/RHEL.";;
       "System is not supported. Cannot install Snap automatically.") translated_text="System is not supported. Cannot install Snap automatically.";;
        "Snap has been installed successfully.") translated_text="Snap has been installed successfully.";;
        "Installing Multipass...") translated_text="Installing Multipass...";;
        "Multipass has been installed.") translated_text="Multipass has been installed.";;
        "Checking Multipass...") translated_text="Checking Multipass...";;
        "Multipass is ready.") translated_text="Multipass is ready.";;
         "Please enter Titan Agent key: ") translated_text="Please enter Titan Agent key: ";;
        "You have not entered a key. Script stopped.") translated_text="You have not entered a key. Script stopped.";;
        "Invalid key. Script stopped.") translated_text="Invalid key. Script stopped.";;
         "Downloading and extracting Titan Agent...") translated_text="Downloading and extracting Titan Agent...";;
        "Titan Agent has been downloaded and extracted.") translated_text="Titan Agent has been downloaded and extracted.";;
        "Creating systemd service file...") translated_text="Creating systemd service file...";;
        "Enabling systemd service...") translated_text="Enabling systemd service...";;
        "Starting systemd service...") translated_text="Starting systemd service...";;
         "Checking systemd service status...") translated_text="Checking systemd service status...";;
        "Titan Agent has been installed and started as a systemd service.") translated_text="Titan Agent has been installed and started as a systemd service.";;
        "Installation and running of Titan Agent completed.") translated_text="Installation and running of Titan Agent completed.";;
         *) translated_text="$text";;
      esac
      ;;
    "id")
      case "$text" in
        "This script needs to be run with root privileges.") translated_text="Skrip ini harus dijalankan dengan hak akses root.";;
        "Command '$1' failed.") translated_text="Perintah '$1' gagal.";;
        "Checking Snap...") translated_text="Memeriksa Snap...";;
        "Snap is already installed.") translated_text="Snap sudah terpasang.";;
        "Snap is not installed, proceeding with installation...") translated_text="Snap belum terpasang, mulai pemasangan...";;
        "System is Debian/Ubuntu.") translated_text="Sistem adalah Debian/Ubuntu.";;
        "System is Fedora.") translated_text="Sistem adalah Fedora.";;
        "System is CentOS/RHEL.") translated_text="Sistem adalah CentOS/RHEL.";;
       "System is not supported. Cannot install Snap automatically.") translated_text="Sistem tidak didukung. Tidak dapat memasang Snap secara otomatis.";;
        "Snap has been installed successfully.") translated_text="Snap berhasil terpasang.";;
        "Installing Multipass...") translated_text="Memasang Multipass...";;
        "Multipass has been installed.") translated_text="Multipass berhasil terpasang.";;
        "Checking Multipass...") translated_text="Memeriksa Multipass...";;
        "Multipass is ready.") translated_text="Multipass siap digunakan.";;
         "Please enter Titan Agent key: ") translated_text="Silakan masukkan key Titan Agent: ";;
        "You have not entered a key. Script stopped.") translated_text="Anda belum memasukkan key. Skrip berhenti.";;
        "Invalid key. Script stopped.") translated_text="Key tidak valid. Skrip berhenti.";;
        "Downloading and extracting Titan Agent...") translated_text="Mengunduh dan mengekstrak Titan Agent...";;
        "Titan Agent has been downloaded and extracted.") translated_text="Titan Agent berhasil diunduh dan diekstrak.";;
         "Creating systemd service file...") translated_text="Membuat file service systemd...";;
        "Enabling systemd service...") translated_text="Mengaktifkan service systemd...";;
        "Starting systemd service...") translated_text="Memulai service systemd...";;
         "Checking systemd service status...") translated_text="Memeriksa status service systemd...";;
        "Titan Agent has been installed and started as a systemd service.") translated_text="Titan Agent telah terpasang dan berjalan sebagai service systemd.";;
        "Installation and running of Titan Agent completed.") translated_text="Proses instalasi dan menjalankan Titan Agent selesai.";;
         *) translated_text="$text";;
      esac
      ;;
    "ru")
      case "$text" in
        "This script needs to be run with root privileges.") translated_text="Этот скрипт должен быть запущен с правами root.";;
        "Command '$1' failed.") translated_text="Команда '$1' не удалась.";;
        "Checking Snap...") translated_text="Проверка Snap...";;
        "Snap is already installed.") translated_text="Snap уже установлен.";;
        "Snap is not installed, proceeding with installation...") translated_text="Snap не установлен, начинаю установку...";;
        "System is Debian/Ubuntu.") translated_text="Система Debian/Ubuntu.";;
         "System is Fedora.") translated_text="Система Fedora.";;
        "System is CentOS/RHEL.") translated_text="Система CentOS/RHEL.";;
        "System is not supported. Cannot install Snap automatically.") translated_text="Система не поддерживается. Невозможно установить Snap автоматически.";;
        "Snap has been installed successfully.") translated_text="Snap успешно установлен.";;
        "Installing Multipass...") translated_text="Установка Multipass...";;
         "Multipass has been installed.") translated_text="Multipass установлен.";;
        "Checking Multipass...") translated_text="Проверка Multipass...";;
        "Multipass is ready.") translated_text="Multipass готов к использованию.";;
         "Please enter Titan Agent key: ") translated_text="Пожалуйста, введите ключ Titan Agent: ";;
        "You have not entered a key. Script stopped.") translated_text="Вы не ввели ключ. Скрипт остановлен.";;
       "Invalid key. Script stopped.") translated_text="Неверный ключ. Скрипт остановлен.";;
         "Downloading and extracting Titan Agent...") translated_text="Загрузка и распаковка Titan Agent...";;
        "Titan Agent has been downloaded and extracted.") translated_text="Titan Agent был загружен и распакован.";;
         "Creating systemd service file...") translated_text="Создание файла службы systemd...";;
        "Enabling systemd service...") translated_text="Активация службы systemd...";;
         "Starting systemd service...") translated_text="Запуск службы systemd...";;
        "Checking systemd service status...") translated_text="Проверка статуса службы systemd...";;
        "Titan Agent has been installed and started as a systemd service.") translated_text="Titan Agent установлен и запущен как служба systemd.";;
        "Installation and running of Titan Agent completed.") translated_text="Установка и запуск Titan Agent завершены.";;
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

# Get language parameter from command line
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

# Check if the user is root
if [[ $EUID -ne 0 ]]; then
   translate "This script needs to be run with root privileges."
   exit 1
fi

# Function to check if a command was successful
check_command() {
  if [[ $? -ne 0 ]]; then
    translate "Command '$1' failed."
    exit 1
  fi
}

# Check if Snap is installed
translate "Checking Snap..."
if snap --version &> /dev/null; then
  translate "Snap is already installed."
else
  translate "Snap is not installed, proceeding with installation..."
  if command -v apt &> /dev/null; then
    translate "System is Debian/Ubuntu."
    apt update
    check_command "apt update"
    apt install -y snapd
    check_command "apt install -y snapd"
  elif command -v dnf &> /dev/null; then
    translate "System is Fedora."
    dnf install -y snapd
    check_command "dnf install -y snapd"
  elif command -v yum &> /dev/null; then
     translate "System is CentOS/RHEL."
    yum install -y snapd
    check_command "yum install -y snapd"
  else
      translate "System is not supported. Cannot install Snap automatically."
      exit 1
  fi
  systemctl enable --now snapd.socket
  check_command "systemctl enable --now snapd.socket"
  translate "Snap has been installed successfully."
fi

# Install Multipass
translate "Installing Multipass..."
snap install multipass
check_command "snap install multipass"
translate "Multipass has been installed."

# Check Multipass
translate "Checking Multipass..."
multipass --version
check_command "multipass --version"
translate "Multipass is ready."

# Get key from parameter or ask for input
if [ -z "$1" ]; then
    read -p "$(translate "Please enter Titan Agent key: ")" KEY
    if [ -z "$KEY" ]; then
       translate "You have not entered a key. Script stopped."
        exit 1
    fi
else
    KEY_ARG=$1
    KEY=$(echo "$KEY_ARG" | sed 's/--key=//g')
    if [ -z "$KEY" ]; then
        translate "Invalid key. Script stopped."
        exit 1
    fi
fi

# Download and extract Titan Agent
translate "Downloading and extracting Titan Agent..."
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
        translate "System is not supported. Cannot install Snap automatically."
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

translate "Titan Agent has been downloaded and extracted."

# Get current user
USER=$(whoami)

# Create systemd service file
translate "Creating systemd service file..."
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
translate "Enabling systemd service..."
sudo systemctl enable titanagent
check_command "sudo systemctl enable titanagent"

# Start service
translate "Starting systemd service..."
sudo systemctl start titanagent
check_command "sudo systemctl start titanagent"

# Check service status
translate "Checking systemd service status..."
sudo systemctl status titanagent
check_command "sudo systemctl status titanagent"
translate "Titan Agent has been installed and started as a systemd service."

translate "Installation and running of Titan Agent completed."
