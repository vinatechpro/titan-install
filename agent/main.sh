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
      "en")
        case "$text" in
            "Script này cần được chạy với quyền root.") echo "This script must be run with root privileges.";;
            "Lệnh '$1' thất bại.") echo "Command '$1' failed.";;
            "Kiểm tra Snap...") echo "Checking Snap...";;
            "Snap đã được cài đặt.") echo "Snap is already installed.";;
            "Snap chưa được cài đặt, tiến hành cài đặt...") echo "Snap is not installed, proceeding with installation...";;
            "Hệ thống là Debian/Ubuntu.") echo "System is Debian/Ubuntu.";;
            "Hệ thống là Fedora.") echo "System is Fedora.";;
            "Hệ thống là CentOS/RHEL.") echo "System is CentOS/RHEL.";;
            "Hệ thống không được hỗ trợ. Không thể cài Snap tự động.") echo "System is not supported. Cannot install Snap automatically.";;
            "Snap đã được cài đặt thành công.") echo "Snap has been successfully installed.";;
            "Cài đặt Multipass...") echo "Installing Multipass...";;
            "Multipass đã được cài đặt.") echo "Multipass has been installed.";;
            "Kiểm tra Multipass...") echo "Checking Multipass...";;
            "Multipass đã sẵn sàng.") echo "Multipass is ready.";;
            "Vui lòng nhập Titan Agent key: ") echo "Please enter Titan Agent key: ";;
            "Bạn chưa nhập key. Script dừng.") echo "You have not entered the key. Script stopped.";;
            "Key không hợp lệ. Script dừng.") echo "Invalid key. Script stopped.";;
             "Tải và giải nén Titan Agent...") echo "Downloading and extracting Titan Agent...";;
            "Titan Agent đã được tải và giải nén.") echo "Titan Agent has been downloaded and extracted.";;
            "Tạo file service systemd...") echo "Creating systemd service file...";;
            "Kích hoạt service systemd...") echo "Enabling systemd service...";;
            "Khởi động service systemd...") echo "Starting systemd service...";;
            "Kiểm tra trạng thái service systemd...") echo "Checking systemd service status...";;
            "Titan Agent đã được cài đặt và khởi động dưới dạng service systemd.") echo "Titan Agent has been installed and started as a systemd service.";;
            "Quá trình cài đặt và chạy Titan Agent hoàn tất.") echo "Installation and running of Titan Agent is completed.";;
             *) echo "$text";;
        esac
        ;;
    "zh")
      case "$text" in
        "Script này cần được chạy với quyền root.") echo "此脚本必须以 root 权限运行。";;
        "Lệnh '$1' thất bại.") echo "命令 '$1' 失败。";;
        "Kiểm tra Snap...") echo "正在检查 Snap...";;
        "Snap đã được cài đặt.") echo "Snap 已安装。";;
        "Snap chưa được cài đặt, tiến hành cài đặt...") echo "Snap 未安装，正在进行安装...";;
        "Hệ thống là Debian/Ubuntu.") echo "系统为 Debian/Ubuntu。";;
        "Hệ thống là Fedora.") echo "系统为 Fedora。";;
        "Hệ thống là CentOS/RHEL.") echo "系统为 CentOS/RHEL。";;
        "Hệ thống không được hỗ trợ. Không thể cài Snap tự động.") echo "系统不受支持。无法自动安装 Snap。";;
        "Snap đã được cài đặt thành công.") echo "Snap 已成功安装。";;
        "Cài đặt Multipass...") echo "正在安装 Multipass...";;
        "Multipass đã được cài đặt.") echo "Multipass 已安装。";;
        "Kiểm tra Multipass...") echo "正在检查 Multipass...";;
        "Multipass đã sẵn sàng.") echo "Multipass 已准备就绪。";;
         "Vui lòng nhập Titan Agent key: ") echo "请输 Titan Agent 密钥：";;
        "Bạn chưa nhập key. Script dừng.") echo "您尚未输入密钥。脚本已停止。";;
        "Key không hợp lệ. Script dừng.") echo "密钥无效。脚本已停止。";;
        "Tải và giải nén Titan Agent...") echo "正在下载并解压 Titan Agent...";;
        "Titan Agent đã được tải và giải nén.") echo "Titan Agent 已下载并解压。";;
        "Tạo file service systemd...") echo "正在创建 systemd 服务文件...";;
        "Kích hoạt service systemd...") echo "正在启用 systemd 服务...";;
        "Khởi động service systemd...") echo "正在启动 systemd 服务...";;
        "Kiểm tra trạng thái service systemd...") echo "正在检查 systemd 服务状态...";;
        "Titan Agent đã được cài đặt và khởi động dưới dạng service systemd.") echo "Titan Agent 已安装并以 systemd 服务形式启动。";;
        "Quá trình cài đặt và chạy Titan Agent hoàn tất.") echo "Titan Agent 的安装和运行过程已完成。";;
         *) echo "$text";;
      esac
      ;;
    "tr")
      case "$text" in
        "Script này cần được chạy với quyền root.") echo "Bu komut dosyası root ayrıcalıklarıyla çalıştırılmalıdır.";;
        "Lệnh '$1' thất bại.") echo "'$1' komutu başarısız oldu.";;
        "Kiểm tra Snap...") echo "Snap kontrol ediliyor...";;
        "Snap đã được cài đặt.") echo "Snap zaten yüklü.";;
        "Snap chưa được cài đặt, tiến hành cài đặt...") echo "Snap yüklü değil, kuruluma devam ediliyor...";;
        "Hệ thống là Debian/Ubuntu.") echo "Sistem Debian/Ubuntu.";;
         "Hệ thống là Fedora.") echo "Sistem Fedora.";;
        "Hệ thống là CentOS/RHEL.") echo "Sistem CentOS/RHEL.";;
        "Hệ thống không được hỗ trợ. Không thể cài Snap tự động.") echo "Sistem desteklenmiyor. Snap otomatik olarak kurulamıyor.";;
        "Snap đã được cài đặt thành công.") echo "Snap başarıyla kuruldu.";;
        "Cài đặt Multipass...") echo "Multipass kuruluyor...";;
        "Multipass đã được cài đặt.") echo "Multipass kuruldu.";;
        "Kiểm tra Multipass...") echo "Multipass kontrol ediliyor...";;
        "Multipass đã sẵn sàng.") echo "Multipass hazır.";;
        "Vui lòng nhập Titan Agent key: ") echo "Lütfen Titan Agent anahtarını girin: ";;
        "Bạn chưa nhập key. Script dừng.") echo "Anahtarı girmediniz. Komut dosyası durduruldu.";;
        "Key không hợp lệ. Script dừng.") echo "Geçersiz anahtar. Komut dosyası durduruldu.";;
        "Tải và giải nén Titan Agent...") echo "Titan Agent indiriliyor ve çıkarılıyor...";;
        "Titan Agent đã được tải và giải nén.") echo "Titan Agent indirildi ve çıkarıldı.";;
        "Tạo file service systemd...") echo "systemd hizmet dosyası oluşturuluyor...";;
        "Kích hoạt service systemd...") echo "systemd hizmeti etkinleştiriliyor...";;
        "Khởi động service systemd...") echo "systemd hizmeti başlatılıyor...";;
        "Kiểm tra trạng thái service systemd...") echo "systemd hizmet durumu kontrol ediliyor...";;
        "Titan Agent đã được cài đặt và khởi động dưới dạng service systemd.") echo "Titan Agent kuruldu ve systemd hizmeti olarak başlatıldı.";;
        "Quá trình cài đặt và chạy Titan Agent hoàn tất.") echo "Titan Agent kurulumu ve çalıştırma işlemi tamamlandı.";;
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

# Danh sách các ngôn ngữ được hỗ trợ
declare -a SUPPORTED_LANGUAGES=("en" "vi" "id" "ru" "zh" "tr")

# Hàm để phân tích các đối số dòng lệnh
parse_arguments() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --ver=*)
        LANGUAGE="${1#--ver=}"
        # Kiểm tra xem ngôn ngữ có được hỗ trợ không
        is_supported=false
        for lang in "${SUPPORTED_LANGUAGES[@]}"; do
          if [[ "$lang" == "$LANGUAGE" ]]; then
            is_supported=true
            break
          fi
        done
        if ! $is_supported; then
          echo "Ngôn ngữ '$LANGUAGE' không được hỗ trợ. Sử dụng ngôn ngữ mặc định (tiếng Anh)."
          LANGUAGE="en" # Đặt lại ngôn ngữ về mặc định nếu không hợp lệ
        fi
        shift
        ;;
      --key=*)
        KEY_ARG="$1"
        KEY=$(echo "$KEY_ARG" | sed 's/--key=//g')
        shift
        ;;
      *)
        echo "Tham số không hợp lệ: $1"
        echo "Sử dụng: ./main.sh [--ver=<language>] [--key=<key>]"
        exit 1
        ;;
    esac
  done
}


# Gọi hàm phân tích tham số
parse_arguments "$@"


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
if [ -z "$KEY" ]; then
    read -p "$(translate "Vui lòng nhập Titan Agent key: ")" KEY
    if [ -z "$KEY" ]; then
       translate "Bạn chưa nhập key. Script dừng."
        exit 1
    fi
else

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

# Kiểm tra và cài đặt unzip
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
ExecStart=/usr/local/bin/agent --working-dir=/root/titanagent --server-url=https://test4-api.titannet.io --channel=vps --key="$KEY"
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
