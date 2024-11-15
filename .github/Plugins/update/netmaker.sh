#!/bin/bash
#=================================================
# MZwrt script
# https://github.com/mzwrt
#=================================================

# 获取最新的提交 hash
netmaker_LATEST_COMMIT_HASH=$(curl -s "https://api.github.com/repos/gravitl/netmaker/commits" | jq -r '.[0].sha')

# 获取最新的版本标签（如果存在）
netmaker_LATEST_TAG=$(curl -s "https://api.github.com/repos/gravitl/netmaker/releases/latest" | jq -r '.tag_name')

# 检查是否获取到了最新的 commit 和标签
if [ -z "$netmaker_LATEST_COMMIT_HASH" ]; then
  echo "无法获取最新的提交信息。"
  exit 1
fi

if [ -z "$netmaker_LATEST_TAG" ]; then
  echo "无法获取最新的版本标签。"
  exit 1
fi

echo "最新的提交哈希：$netmaker_LATEST_COMMIT_HASH"
echo "最新的版本标签：$netmaker_LATEST_TAG"

# 直接在 Makefile 中更新版本和提交信息
sed -i "s/^PKG_VERSION:=.*/PKG_VERSION:=${netmaker_LATEST_TAG}/" feeds/mzwrt_package/netmaker/Makefile
sed -i "s/^PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=${netmaker_LATEST_COMMIT_HASH}/" feeds/mzwrt_package/netmaker/Makefile

echo "Makefile 已成功更新为最新版本：$netmaker_LATEST_TAG"

exit 0
