#!/bin/bash
#=================================================
# MZwrt script
# https://github.com/mzwrt
#=================================================

# 目标Makefile文件路径
NEXTDNS_MAKEFILE_PATH="feeds/packages/net/nextdns/Makefile"

# 获取最新版本号，去掉版本号前的 "v" 前缀
NEXTDNS_LATEST_VERSION=$(curl -s https://api.github.com/repos/nextdns/nextdns/releases/latest | jq -r .tag_name | sed 's/^v//')

# 构造源URL和版本Hash
NEXTDNS_PKG_SOURCE_URL="https://codeload.github.com/nextdns/nextdns/tar.gz/v${NEXTDNS_LATEST_VERSION}"
NEXTDNS_PKG_HASH=$(curl -sL ${NEXTDNS_PKG_SOURCE_URL} | sha256sum | awk '{print $1}')

# 更新版本号和相关信息
sed -i "s#^PKG_VERSION:=.*#PKG_VERSION:=${NEXTDNS_LATEST_VERSION}#" ${NEXTDNS_MAKEFILE_PATH}
sed -i "s#^PKG_SOURCE_URL:=.*#PKG_SOURCE_URL:=${NEXTDNS_PKG_SOURCE_URL}#" ${NEXTDNS_MAKEFILE_PATH}
sed -i "s#^PKG_HASH:=.*#PKG_HASH:=${NEXTDNS_PKG_HASH}#" ${NEXTDNS_MAKEFILE_PATH}

echo "NextDNS Makefile 已更新到最新版：${NEXTDNS_LATEST_VERSION}"
