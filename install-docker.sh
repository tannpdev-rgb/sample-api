#!/bin/bash

set -e

echo "👉 Update hệ thống..."
sudo apt update -y
sudo apt upgrade -y

echo "👉 Cài các gói cần thiết..."
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

echo "👉 Thêm Docker GPG key..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "👉 Thêm Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "👉 Update lại apt..."
sudo apt update -y

echo "👉 Cài Docker Engine..."
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "👉 Bật Docker khi khởi động máy..."
sudo systemctl enable docker
sudo systemctl start docker

echo "👉 Thêm user hiện tại vào group docker (không cần sudo)..."
sudo usermod -aG docker $USER

echo "✅ Cài Docker hoàn tất!"
echo "⚠️ Hãy logout/login lại hoặc chạy: newgrp docker"
