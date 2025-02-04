#!/bin/bash

# Màu sắc ANSI
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Icon (cần đảm bảo terminal hỗ trợ hiển thị Unicode)
CHECKMARK="✅"
CROSSMARK="❌"
INFO="ℹ️"

echo "${INFO} Checking for virtualization support..."

# Kiểm tra hỗ trợ CPU (Intel hoặc AMD)
if grep -E '(vmx|svm)' /proc/cpuinfo > /dev/null; then
  CPU_SUPPORT="true"
  echo "${GREEN} ${CHECKMARK} CPU supports virtualization (VT-x or AMD-V).${NC}"
else
  CPU_SUPPORT="false"
  echo "${RED} ${CROSSMARK} CPU does NOT support virtualization.${NC}"
  echo "${RED} ${CROSSMARK} Nested virtualization is not possible.${NC}"
  exit 1
fi

# Kiểm tra KVM modules
if lsmod | grep kvm > /dev/null; then
  KVM_INSTALLED="true"
  echo "${GREEN} ${CHECKMARK} KVM modules are loaded.${NC}"
else
  KVM_INSTALLED="false"
  echo "${YELLOW} ${INFO} KVM modules are NOT loaded.${NC}"
fi

# Kiểm tra nested virtualization
if [[ "$CPU_SUPPORT" == "true" ]]; then
  if [[ -f /sys/module/kvm_intel/parameters/nested ]]; then
    NESTED_FILE="/sys/module/kvm_intel/parameters/nested"
    KVM_MODULE="kvm_intel"
  elif [[ -f /sys/module/kvm_amd/parameters/nested ]]; then
    NESTED_FILE="/sys/module/kvm_amd/parameters/nested"
    KVM_MODULE="kvm_amd"
  else
    echo "${RED} ${CROSSMARK} Could not find nested virtualization parameter file. KVM may not be installed properly.${NC}"
    exit 1
  fi

  NESTED_ENABLED=$(cat "$NESTED_FILE")
  if [[ "$NESTED_ENABLED" == "Y" ]]; then
    NESTED_STATUS="enabled"
    echo "${GREEN} ${CHECKMARK} Nested virtualization is enabled.${NC}"
  else
    NESTED_STATUS="disabled"
    echo "${YELLOW} ${INFO} Nested virtualization is disabled.${NC}"
  fi
fi

# Cài đặt và bật KVM nếu chưa có
if [[ "$KVM_INSTALLED" == "false" ]] || [[ "$NESTED_STATUS" == "disabled" ]]; then
  echo "${INFO} Attempting to install and configure KVM..."
  if [[ "$EUID" -ne 0 ]]; then
    echo "${RED} ${CROSSMARK} This script requires root privileges to install KVM.${NC}"
    exit 1
  fi

  # Cài đặt KVM
  apt update && apt install -y qemu-kvm libvirt-daemon-system bridge-utils virt-manager > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo "${GREEN} ${CHECKMARK} KVM and required packages installed successfully.${NC}"
  else
    echo "${RED} ${CROSSMARK} Failed to install KVM packages.  Check for errors above.${NC}"
    exit 1
  fi

  # Bật nested virtualization
  modprobe -r "$KVM_MODULE" > /dev/null 2>&1
  modprobe "$KVM_MODULE" nested=1 > /dev/null 2>&1

  if [ $? -eq 0 ]; then
     echo "options $KVM_MODULE nested=1" | tee /etc/modprobe.d/kvm.conf > /dev/null

     if [[ $(cat "$NESTED_FILE") == "Y" ]]; then
        echo "${GREEN} ${CHECKMARK} Successfully enabled nested virtualization. Please reboot for changes to take effect.${NC}"
     else
        echo "${RED} ${CROSSMARK} Failed to enable nested virtualization. Please check manually.${NC}"
        exit 1
     fi
  else
    echo "${RED} ${CROSSMARK} Failed to load KVM module with nested virtualization enabled. Check for errors above.${NC}"
    exit 1
  fi
fi

echo "${GREEN} ${CHECKMARK} Checks completed.${NC}"
