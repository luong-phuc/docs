#!/bin/bash

# 1. Cập nhật WSL lên bản mới nhất
echo "--- Đang cập nhật WSL ---"
wsl --update

# 2. Setup file .wslconfig
# Lưu ý: Cú pháp này sẽ ghi đè file .wslconfig của user hiện tại trên Windows
WSL_CONFIG_PATH="/c/Users/$USER/.wslconfig"

echo "--- Đang cấu hình .wslconfig ---"
cat <<EOF > "$WSL_CONFIG_PATH"
[wsl2]
memory=2GB
swap=16GB
guiApplications=false
localhostForwarding=true

[experimental]
autoMemoryReclaim=gradual
sparseVhd=true
EOF

echo "Cấu hình xong tại: $WSL_CONFIG_PATH"

# 3. Tải FedoraLinux-43 (Giả sử bản online tên là FedoraLinux-43)
# Lưu ý: Anh cần kiểm tra tên chính xác bằng 'wsl --list --online'
echo "--- Đang cài đặt FedoraLinux-43 ---"
wsl --install -d FedoraLinux-43 --no-launch

# Tắt WSL để áp dụng .wslconfig mới và chuẩn bị export
wsl --shutdown

# 4. Backup (Export) thành file .tar vào ổ D
echo "--- Đang backup FedoraLinux-43 thành file tar ---"
mkdir -p /d/Backup_WSL
wsl --export FedoraLinux-43 "D:/Backup_WSL/FedoraLinux-43-backup.tar"

# 5. Export (Import) nó vào thư mục chỉ định D:/WSL/FedoraLinux-43
echo "--- Đang tiến hành chuyển Fedora sang D:/WSL/FedoraLinux-43 ---"
mkdir -p /d/WSL/FedoraLinux-43
# Gỡ bản cũ đã cài ở ổ C để tránh trùng tên khi import lại vào chỗ mới
wsl --unregister FedoraLinux-43
wsl --import FedoraLinux-43 "D:/WSL/FedoraLinux-43" "D:/Backup_WSL/FedoraLinux-43-backup.tar"

# 6. Update DNF và cài đặt VIM bên trong Fedora
echo "--- Đang cập nhật DNF và cài đặt Vim ---"
wsl -d FedoraLinux-43 -u root -- bash -c "dnf update -y && dnf install -y vim ncurses procps-ng util-linux"

echo "--- TẤT CẢ ĐÃ XONG! Chúc anh Phúc làm dự án Cabus thuận lợi! ---"
