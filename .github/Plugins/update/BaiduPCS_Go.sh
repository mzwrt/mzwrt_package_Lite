#!/bin/bash
#=================================================
# MZwrt script
# https://github.com/mzwrt
#=================================================

# GitHub API URL 获取最新版本信息
BaiduPCS_Go_API_URL="https://api.github.com/repos/qjfoidnh/BaiduPCS-Go/releases/latest"

# 获取最新版本号
BaiduPCS_Go_LATEST_VERSION=$(curl -s $BaiduPCS_Go_API_URL | jq -r .tag_name)

# 如果获取不到最新版本信息，打印警告
if [ -z "$BaiduPCS_Go_LATEST_VERSION" ]; then
    echo "Warning: Unable to fetch the latest version information from GitHub API."
    exit 1
else
    echo "已获取最新版本: $BaiduPCS_Go_LATEST_VERSION"
fi

# 去掉版本号前面的 "v"（如果有的话）
BaiduPCS_Go_VERSION_NO_V=${BaiduPCS_Go_LATEST_VERSION#v}

# 设置下载的文件路径（使用相对路径）
BaiduPCS_Go_TAR_FILE="dl/BaiduPCS-Go-$BaiduPCS_Go_VERSION_NO_V.tar.gz"
BaiduPCS_Go_PKG_SOURCE="https://codeload.github.com/qjfoidnh/BaiduPCS-Go/tar.gz/$BaiduPCS_Go_LATEST_VERSION"  # 确保没有多余的 "v"

# 下载最新版插件源代码
echo "Downloading BaiduPCS-Go $BaiduPCS_Go_LATEST_VERSION..."
wget -O "$BaiduPCS_Go_TAR_FILE" "$BaiduPCS_Go_PKG_SOURCE"

# 获取文件的哈希值并验证
echo "检查哈希值 $BaiduPCS_Go_TAR_FILE..."
BaiduPCS_Go_FILE_HASH=$(sha256sum "$BaiduPCS_Go_TAR_FILE" | awk '{ print $1 }')

# 更新 Makefile 中的版本号和哈希值
echo "Updating Makefile with version $BaiduPCS_Go_VERSION_NO_V and hash $BaiduPCS_Go_FILE_HASH..."
sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=$BaiduPCS_Go_VERSION_NO_V/" feeds/packages/net/baidupcs-go/Makefile
sed -i "s/PKG_HASH:=.*/PKG_HASH:=$BaiduPCS_Go_FILE_HASH/" feeds/packages/net/baidupcs-go/Makefile

# 输出更新结果
echo "BaiduPCS_Go最新版本和哈希值更新 Makefile."

exit 0
