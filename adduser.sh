#!/bin/bash
h='\033[1;32m'; m='\033[1;31m'; c='\033[1;36m'; p='\033[1;37m'; r='\033[0m'

GIST_ID="3913a2a08f7a45cc2c4c431616ac2cc9"
GITHUB_TOKEN="TOKEN_GITHUB_LU"

echo -e "${c}====================================${r}"
echo -e "${c}      HIDZ USER CREATOR SYSTEM      ${r}"
echo -e "${c}====================================${r}"

read -p "Username Baru : " uname
read -p "WhatsApp (wa.me/..): " wa
read -p "Role (VIP/USER): " role
read -p "Password (6)  : " pass
read -p "Expired (∞/YYYY-MM-DD): " exp

NEW_DATA="$uname|$wa|$role|$pass|$exp"

OLD_DATA=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/gists/$GIST_ID" | grep -o '"content": *"[^"]*"' | cut -d'"' -f4 | sed 's/\\n/\n/g')

FULL_DATA="${OLD_DATA}\n${NEW_DATA}"

RESPONSE=$(curl -s -X PATCH \
  -H "Authorization: token $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  -d "{\"files\":{\"db_users.txt\":{\"content\":\"$FULL_DATA\"}}}" \
  "https://api.github.com/gists/$GIST_ID")

if echo "$RESPONSE" | grep -q '"id"'; then
    echo -e "${h}[+] Berhasil menambahkan akun: $uname${r}"
else
    echo -e "${m}[-] Gagal! Cek Token GitHub lu.${r}"
fi
