#!/bin/bash

# Function to translate text based on the selected language
translate() {
  local text="$1"
  case "$LANGUAGE" in
    "vi")
      case "$text" in
        "Script này cần được chạy với quyền root.") echo "Script này cần được chạy với quyền root.";;
        "Lệnh '$1' thất bại.") echo "Lệnh '$1' thất bại.";;
        "Dừng Titan Agent service...") echo "Dừng Titan Agent service...";;
        "Titan Agent service đã được dừng.") echo "Titan Agent service đã được dừng.";;
        "Gỡ cài đặt Titan Agent service...") echo "Gỡ cài đặt Titan Agent service...";;
        "Titan Agent service đã được gỡ cài đặt.") echo "Titan Agent service đã được gỡ cài đặt.";;
         "Xóa file thực thi Titan Agent...") echo "Xóa file thực thi Titan Agent...";;
        "File thực thi Titan Agent đã được xóa.") echo "File thực thi Titan Agent đã được xóa.";;
         "Xóa file nén Titan Agent...") echo "Xóa file nén Titan Agent...";;
        "File nén Titan Agent đã được xóa.") echo "File nén Titan Agent đã được xóa.";;
        "Xóa thư mục làm việc Titan Agent...") echo "Xóa thư mục làm việc Titan Agent...";;
        "Thư mục làm việc Titan Agent đã được xóa.") echo "Thư mục làm việc Titan Agent đã được xóa.";;
        "Gỡ cài đặt Multipass...") echo "Gỡ cài đặt Multipass...";;
        "Multipass đã được gỡ cài đặt.") echo "Multipass đã được gỡ cài đặt.";;
         "Gỡ cài đặt Snap...") echo "Gỡ cài đặt Snap...";;
        "Snap đã được gỡ cài đặt.") echo "Snap đã được gỡ cài đặt.";;
        "Quá trình gỡ cài đặt Titan Agent hoàn tất.") echo "Quá trình gỡ cài đặt Titan Agent hoàn tất.";;
         "Không tìm thấy Titan Agent service.") echo "Không tìm thấy Titan Agent service.";;
         *) echo "$text";;
      esac
      ;;
    "en")
      case "$text" in
        "Script này cần được chạy với quyền root.") echo "This script needs to be run with root privileges.";;
        "Lệnh '$1' thất bại.") echo "Command '$1' failed.";;
        "Dừng Titan Agent service...") echo "Stopping Titan Agent service...";;
        "Titan Agent service đã được dừng.") echo "Titan Agent service has been stopped.";;
        "Gỡ cài đặt Titan Agent service...") echo "Uninstalling Titan Agent service...";;
        "Titan Agent service đã được gỡ cài đặt.") echo "Titan Agent service has been uninstalled.";;
         "Xóa file thực thi Titan Agent...") echo "Removing Titan Agent executable file...";;
        "File thực thi Titan Agent đã được xóa.") echo "Titan Agent executable file has been removed.";;
         "Xóa file nén Titan Agent...") echo "Removing Titan Agent archive file...";;
        "File nén Titan Agent đã được xóa.") echo "Titan Agent archive file has been removed.";;
        "Xóa thư mục làm việc Titan Agent...") echo "Removing Titan Agent working directory...";;
        "Thư mục làm việc Titan Agent đã được xóa.") echo "Titan Agent working directory has been removed.";;
         "Gỡ cài đặt Multipass...") echo "Uninstalling Multipass...";;
        "Multipass đã được gỡ cài đặt.") echo "Multipass has been uninstalled.";;
         "Gỡ cài đặt Snap...") echo "Uninstalling Snap...";;
        "Snap đã được gỡ cài đặt.") echo "Snap has been uninstalled.";;
        "Quá trình gỡ cài đặt Titan Agent hoàn tất.") echo "Titan Agent uninstallation process completed.";;
         "Không tìm thấy Titan Agent service.") echo "Titan Agent service not found.";;
         *) echo "$text";;
      esac
      ;;
    "id")
       case "$text" in
        "Script này cần được chạy với quyền root.") echo "Skrip ini harus dijalankan dengan hak akses root.";;
        "Lệnh '$1' thất bại.") echo "Perintah '$1' gagal.";;
        "Dừng Titan Agent service...") echo "Menghentikan layanan Titan Agent...";;
        "Titan Agent service đã được dừng.") echo "Layanan Titan Agent telah dihentikan.";;
        "Gỡ cài đặt Titan Agent service...") echo "Menghapus layanan Titan Agent...";;
        "Titan Agent service đã được gỡ cài đặt.") echo "Layanan Titan Agent telah dihapus.";;
         "Xóa file thực thi Titan Agent...") echo "Menghapus file executable Titan Agent...";;
        "File thực thi Titan Agent đã được xóa.") echo "File executable Titan Agent telah dihapus.";;
        "Xóa file nén Titan Agent...") echo "Menghapus file arsip Titan Agent...";;
        "File nén Titan Agent đã được xóa.") echo "File arsip Titan Agent telah dihapus.";;
        "Xóa thư mục làm việc Titan Agent...") echo "Menghapus direktori kerja Titan Agent...";;
        "Thư mục làm việc Titan Agent đã được xóa.") echo "Direktori kerja Titan Agent telah dihapus.";;
        "Gỡ cài đặt Multipass...") echo "Menghapus Multipass...";;
        "Multipass đã được gỡ cài đặt.") echo "Multipass telah dihapus.";;
         "Gỡ cài đặt Snap...") echo "Menghapus Snap...";;
        "Snap đã được gỡ cài đặt.") echo "Snap telah dihapus.";;
         "Quá trình gỡ cài đặt Titan Agent hoàn tất.") echo "Proses penghapusan Titan Agent selesai.";;
        "Không tìm thấy Titan Agent service.") echo "Layanan Titan Agent tidak ditemukan.";;
        *) echo "$text";;
      esac
      ;;
    "ru")
       case "$text" in
        "Script này cần được chạy với quyền root.") echo "Этот скрипт должен быть запущен с правами root.";;
        "Lệnh '$1' thất bại.") echo "Команда '$1' не удалась.";;
        "Dừng Titan Agent service...") echo "Остановка службы Titan Agent...";;
        "Titan Agent service đã được dừng.") echo "Служба Titan Agent остановлена.";;
         "Gỡ cài đặt Titan Agent service...") echo "Удаление службы Titan Agent...";;
        "Titan Agent service đã được gỡ cài đặt.") echo "Служба Titan Agent удалена.";;
        "Xóa file thực thi Titan Agent...") echo "Удаление исполняемого файла Titan Agent...";;
        "File thực thi Titan Agent đã được xóa.") echo "Исполняемый файл Titan Agent удален.";;
         "Xóa file nén Titan Agent...") echo "Удаление архива Titan Agent...";;
        "File nén Titan Agent đã được xóa.") echo "Архив Titan Agent удален.";;
        "Xóa thư mục làm việc Titan Agent...") echo "Удаление рабочей директории Titan Agent...";;
        "Thư mục làm việc Titan Agent đã được xóa.") echo "Рабочая директория Titan Agent удалена.";;
         "Gỡ cài đặt Multipass...") echo "Удаление Multipass...";;
        "Multipass đã được gỡ cài đặt.") echo "Multipass удален.";;
        "Gỡ cài đặt Snap...") echo "Удаление Snap...";;
        "Snap đã được gỡ cài đặt.") echo "Snap удален.";;
        "Quá trình gỡ cài đặt Titan Agent hoàn tất.") echo "Процесс удаления Titan Agent завершен.";;
        "Không tìm thấy Titan Agent service.") echo "Служба Titan Agent не найдена.";;
         *) echo "$text";;
      esac
      ;;
    "zh")
      case "$text" in
        "Script này cần được chạy với quyền root.") echo "此脚本必须以 root 权限运行。";;
        "Lệnh '$1' thất bại.") echo "命令 '$1' 失败。";;
        "Dừng Titan Agent service...") echo "正在停止 Titan Agent 服务...";;
        "Titan Agent service đã được dừng.") echo "Titan Agent 服务已停止。";;
        "Gỡ cài đặt Titan Agent service...") echo "正在卸载 Titan Agent 服务...";;
        "Titan Agent service đã được gỡ cài đặt.") echo "Titan Agent 服务已卸载。";;
         "Xóa file thực thi Titan Agent...") echo "正在删除 Titan Agent 可执行文件...";;
        "File thực thi Titan Agent đã được xóa.") echo "Titan Agent 可执行文件已删除。";;
         "Xóa file nén Titan Agent...") echo "正在删除 Titan Agent 压缩文件...";;
        "File nén Titan Agent đã được xóa.") echo "Titan Agent 压缩文件已删除。";;
        "Xóa thư mục làm việc Titan Agent...") echo "正在删除 Titan Agent 工作目录...";;
        "Thư mục làm việc Titan Agent đã được xóa.") echo "Titan Agent 工作目录已删除。";;
        "Gỡ cài đặt Multipass...") echo "正在卸载 Multipass...";;
        "Multipass đã được gỡ cài đặt.") echo "Multipass 已卸载。";;
        "Gỡ cài đặt Snap...") echo "正在卸载 Snap...";;
        "Snap đã được gỡ cài đặt.") echo "Snap 已卸载。";;
        "Quá trình gỡ cài đặt Titan Agent hoàn tất.") echo "Titan Agent 卸载过程完成。";;
        "Không tìm thấy Titan Agent service.") echo "未找到 Titan Agent 服务。";;
         *) echo "$text";;
      esac
      ;;
    "tr")
      case "$text" in
        "Script này cần được chạy với quyền root.") echo "Bu komut dosyası root ayrıcalıklarıyla çalıştırılmalıdır.";;
        "Lệnh '$1' thất bại.") echo "'$1' komutu başarısız oldu.";;
        "Dừng Titan Agent service...") echo "Titan Agent hizmeti durduruluyor...";;
        "Titan Agent service đã được dừng.") echo "Titan Agent hizmeti durduruldu.";;
        "Gỡ cài đặt Titan Agent service...") echo "Titan Agent hizmeti kaldırılıyor...";;
        "Titan Agent service đã được gỡ cài đặt.") echo "Titan Agent hizmeti kaldırıldı.";;
         "Xóa file thực thi Titan Agent...") echo "Titan Agent çalıştırılabilir dosyası kaldırılıyor...";;
        "File thực thi Titan Agent đã được xóa.") echo "Titan Agent çalıştırılabilir dosyası kaldırıldı.";;
         "Xóa file nén Titan Agent...") echo "Titan Agent arşiv dosyası kaldırılıyor...";;
        "File nén Titan Agent đã được xóa.") echo "Titan Agent arşiv dosyası kaldırıldı.";;
        "Xóa thư mục làm việc Titan Agent...") echo "Titan Agent çalışma dizini kaldırılıyor...";;
        "Thư mục làm việc Titan Agent đã được xóa.") echo "Titan Agent çalışma dizini kaldırıldı.";;
         "Gỡ cài đặt Multipass...") echo "Multipass kaldırılıyor...";;
        "Multipass đã được gỡ cài đặt.") echo "Multipass kaldırıldı.";;
         "Gỡ cài đặt Snap...") echo "Snap kaldırılıyor...";;
        "Snap đã được gỡ cài đặt.") echo "Snap kaldırıldı.";;
        "Quá trình gỡ cài đặt Titan Agent hoàn tất.") echo "Titan Agent kaldırma işlemi tamamlandı.";;
        "Không tìm thấy Titan Agent service.") echo "Titan Agent hizmeti bulunamadı.";;
         *) echo "$text";;
      esac
      ;;
    *)
      echo "$text"
      ;;
  esac
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
  translate "Script này cần được chạy với quyền root."
  exit 1
fi

# Function to check if a command was successful
check_command() {
  if [[ $? -ne 0 ]]; then
    translate "Lệnh '$1' thất bại."
    exit 1
  fi
}

# Stop the Titan Agent service
translate "Dừng Titan Agent service..."
if systemctl status titanagent &> /dev/null; then
  sudo systemctl stop titanagent
  check_command "sudo systemctl stop titanagent"
  translate "Titan Agent service đã được dừng."
else
    translate "Không tìm thấy Titan Agent service."
fi

# Disable the Titan Agent service
translate "Gỡ cài đặt Titan Agent service..."
sudo systemctl disable titanagent
check_command "sudo systemctl disable titanagent"
translate "Titan Agent service đã được gỡ cài đặt."

# Remove the Titan Agent executable
translate "Xóa file thực thi Titan Agent..."
if [[ -f "/usr/local/bin/agent" ]]; then
    sudo rm /usr/local/bin/agent
    check_command "sudo rm /usr/local/bin/agent"
    translate "File thực thi Titan Agent đã được xóa."
fi
if [[ -f "/usr/local/agent" ]]; then
    sudo rm /usr/local/agent
    check_command "sudo rm /usr/local/agent"
    translate "File thực thi Titan Agent đã được xóa."
fi

# Remove the downloaded zip file
translate "Xóa file nén Titan Agent..."
if [[ -f "agent-linux.zip" ]]; then
    sudo rm agent-linux.zip
    check_command "sudo rm agent-linux.zip"
    translate "File nén Titan Agent đã được xóa."
fi

# Remove the Titan Agent working directory
translate "Xóa thư mục làm việc Titan Agent..."
if [[ -d "/root/titanagent" ]]; then
  sudo rm -rf /root/titanagent
  check_command "sudo rm -rf /root/titanagent"
  translate "Thư mục làm việc Titan Agent đã được xóa."
fi

# Uninstall Multipass
translate "Gỡ cài đặt Multipass..."
if snap list multipass &> /dev/null; then
  sudo snap remove multipass
  check_command "sudo snap remove multipass"
  translate "Multipass đã được gỡ cài đặt."
fi

# Uninstall Snap
translate "Gỡ cài đặt Snap..."
if command -v snap &> /dev/null; then
    if command -v apt &> /dev/null; then
        sudo apt remove -y snapd
        check_command "sudo apt remove -y snapd"
    elif command -v dnf &> /dev/null; then
        sudo dnf remove -y snapd
         check_command "sudo dnf remove -y snapd"
    elif command -v yum &> /dev/null; then
        sudo yum remove -y snapd
        check_command "sudo yum remove -y snapd"
    fi
    translate "Snap đã được gỡ cài đặt."
fi

translate "Quá trình gỡ cài đặt Titan Agent hoàn tất."
