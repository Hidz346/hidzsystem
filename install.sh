#!/bin/bash
echo -e "\033[1;36m[*] Memulai Instalasi HIDZ SYSTEM V1.0...\033[0m"
pkg update -y && pkg upgrade -y
pkg install curl wget python php git ffmpeg nmap cloudflared -y
pip install yt-dlp
echo -e "\033[1;32m[*] Mengunduh script utama...\033[0m"
curl -sL https://raw.githubusercontent.com/Hidz346/hidzsystem/main/tools.sh -o tools.sh
chmod +x tools.sh
echo -e "\033[1;32m[+] Instalasi Selesai! Membuka HIDZ SYSTEM...\033[0m"
sleep 2
./tools.sh
