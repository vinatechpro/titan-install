# Bash Shell Auto Install Titan Edge on Linux

## Requirements
- Linux OS (Recommended Ubuntu 22.04)
- Root access (`sudo`)

## Get Identity Code
- Log in to [Titan Network](https://titannet.gitbook.io/titan-network-en/resource-network-test/bind-the-identity-code), copy your **Identity Code** (e.g., `36284E4F-5CBE-4D95-994B-90E53D90CA2C`).

## Install Nodes
```bash
curl -s https://raw.githubusercontent.com/vinatechpro/titan-install/refs/heads/main/edge.sh | sudo bash -s -- <hash_value> [node_count]
```
- Example (5 nodes): `curl -s https://raw.githubusercontent.com/vinatechpro/titan-install/refs/heads/main/edge.sh | sudo bash -s -- 36284E4F-5CBE-4D95-994B-90E53D90CA2C`

## Remove Nodes
```bash
curl -s https://raw.githubusercontent.com/vinatechpro/titan-install/refs/heads/main/edge.sh | sudo bash -s -- rm
```

## Check Nodes
- List: `docker ps -a`
- Logs: `docker logs titan-edge-0<number>`

## Notes
- `<hash_value>` required
- `[node_count]`: 1-5 (default 5)
- Needs 50GB/node

## How to Deploy Titan PCDN - Galileo Testnet
https://github.com/laodauhgc/bash-scripts/blob/main/titan-network/how-to-install-titan-pcdn-en.md
---

# Автоматическая установка Titan Edge на Linux с помощью Bash Shell (Russian)

## Требования
- ОС Linux (Рекомендуется Ubuntu 22.04)
- Доступ root (`sudo`)

## Получить Identity Code
- Войдите в [Titan Network](https://titannet.gitbook.io/titan-network-en/resource-network-test/bind-the-identity-code), скопируйте ваш **Identity Code** (например, `36284E4F-5CBE-4D95-994B-90E53D90CA2C`).

## Установить узлы
```bash
curl -s https://raw.githubusercontent.com/vinatechpro/titan-install/refs/heads/main/edge.sh | sudo bash -s -- <hash_value> [node_count]
```
- Пример (5 узлов): `curl -s https://raw.githubusercontent.com/vinatechpro/titan-install/refs/heads/main/edge.sh | sudo bash -s -- 36284E4F-5CBE-4D95-994B-90E53D90CA2C`

## Удалить узлы
```bash
curl -s https://raw.githubusercontent.com/vinatechpro/titan-install/refs/heads/main/edge.sh | sudo bash -s -- rm
```

## Проверить узлы
- Список: `docker ps -a`
- Логи: `docker logs titan-edge-0<number>`

## Примечания
- `<hash_value>` обязателен
- `[node_count]`: 1-5 (по умолчанию 5)
- Требуется 50 ГБ/узел

---

# Bash Shell Cài Đặt Tự Động Titan Edge trên Linux (Vietnamese)

## Yêu cầu
- Hệ điều hành Linux (Khuyến nghị Ubuntu 22.04)
- Quyền root (`sudo`)

## Lấy Identity Code
- Đăng nhập [Titan Network](https://titannet.gitbook.io/titan-network-en/resource-network-test/bind-the-identity-code), sao chép **Identity Code** (ví dụ: `36284E4F-5CBE-4D95-994B-90E53D90CA2C`).

## Cài đặt node
```bash
curl -s https://raw.githubusercontent.com/vinatechpro/titan-install/refs/heads/main/edge.sh | sudo bash -s -- <hash_value> [node_count]
```
- Ví dụ (5 node): `curl -s https://raw.githubusercontent.com/vinatechpro/titan-install/refs/heads/main/edge.sh | sudo bash -s -- 36284E4F-5CBE-4D95-994B-90E53D90CA2C`

## Xóa node
```bash
curl -s https://raw.githubusercontent.com/vinatechpro/titan-install/refs/heads/main/edge.sh | sudo bash -s -- rm
```

## Kiểm tra node
- Danh sách: `docker ps -a`
- Log: `docker logs titan-edge-0<number>`

## Ghi chú
- `<hash_value>` bắt buộc
- `[node_count]`: 1-5 (mặc định 5)
- Cần 50GB/node
