#!/bin/bash
#=================================================
# MZwrt script
# https://github.com/mzwrt
#=================================================

# 获取最新的版本号并存入 cloudflared 字典中
cloudflared=(
  [version]=$(curl -s "https://api.github.com/repos/cloudflare/cloudflared/releases/latest" | jq -r '.tag_name')
)

if [[ -z "${cloudflared[version]}" ]]; then
  echo "无法获取最新版本号"
  exit 1
fi
echo "最新版本是: ${cloudflared[version]}"

# 获取源代码包 URL 和 SHA256 哈希
curl -L -o "/tmp/cloudflared-${cloudflared[version]}.tar.gz" "https://github.com/cloudflare/cloudflared/archive/refs/tags/${cloudflared[version]}.tar.gz"

cloudflared[hash]=$(sha256sum "/tmp/cloudflared-${cloudflared[version]}.tar.gz" | awk '{print $1}')
if [[ -z "${cloudflared[hash]}" ]]; then
  echo "无法获取哈希值"
  exit 1
fi
echo "最新哈希值是: ${cloudflared[hash]}"

# 获取源代码包 URL
cloudflared[source_url]="https://codeload.github.com/cloudflare/cloudflared/tar.gz/${cloudflared[version]}?"

# 更新 Makefile 文件中的版本、哈希值和源代码 URL
sed -i "s/^PKG_VERSION:=[^ ]*/PKG_VERSION:=${cloudflared[version]}/" feeds/packages/net/cloudflared/Makefile
sed -i "s/^PKG_HASH:=[^ ]*/PKG_HASH:=${cloudflared[hash]}/" feeds/packages/net/cloudflared/Makefile
#sed -i "s|^PKG_SOURCE_URL:=[^ ]*|PKG_SOURCE_URL:=${cloudflared[source_url]}|g" feeds/packages/net/cloudflared/Makefile

# 显示更新后的内容以确认
echo "更新后的 Makefile 配置："
grep -E "PKG_VERSION|PKG_HASH|PKG_SOURCE_URL" feeds/packages/net/cloudflared/Makefile

# 清理临时文件
rm -f "/tmp/cloudflared-${cloudflared[version]}.tar.gz"

echo "更新完毕！"

exit 0
