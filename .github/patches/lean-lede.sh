#!/bin/bash
#=================================================
# MZwrt script
# https://github.com/mzwrt
#=================================================

MZWRT_DOWNLD_FILE="https://raw.githubusercontent.com/mzwrt/mzwrt_package/main/.github"
MZWRT_PATCH_PATH="feeds/mzwrt_package"
AUTO_CONFIRM=0  # 默认情况下，不自动确认

# 检查命令行参数，如果有 -y，则设置自动确认
while getopts "y" opt; do
    case $opt in
        y) AUTO_CONFIRM=1;;  # 如果传递了 -y，则自动确认
        *) echo "Usage: $0 [-y]"; exit 1;;
    esac
done

# 确认函数
confirm() {
    if [ $AUTO_CONFIRM -eq 1 ]; then
        return 0  # 自动确认
    fi
    while true; do
        read -p "$1 (Y/N): " yn
        case $yn in
            [Yy]* ) return 0;;  # 用户输入 Y 或 y，返回 0，继续执行
            [Nn]* ) return 1;;  # 用户输入 N 或 n，返回 1，跳过
            * ) echo "请输入 Y 或 N";;
        esac
    done
}

# 下载并应用补丁
#download_patch() {
#    PATCH_URL=$1
#    PATCH_FILE=$2
#    wget "$PATCH_URL" -O "$PATCH_FILE" && patch --no-backup-if-mismatch -p1 < "$PATCH_FILE" && rm -f "$PATCH_FILE" || { echo "Failed to apply patch $PATCH_FILE"; exit 1; }
#}

# 应用补丁
#if confirm "是否应用 webd 补丁"; then
#    download_patch "${MZWRT_DOWNLD_FILE}/patches/webd.patch" "$MZWRT_PATCH_PATH/webd.patch"
#fi


# 更新插件并执行脚本
download_and_run_plugin() {
    PLUGIN_URL=$1
    SCRIPT_NAME=$2
    wget "$PLUGIN_URL" -O "$SCRIPT_NAME" && bash "$SCRIPT_NAME" && rm -f "$SCRIPT_NAME" || { echo "Failed to execute $SCRIPT_NAME"; exit 1; }
}

# 更新插件
if confirm "是否更新 cloudflared 插件"; then
    download_and_run_plugin "${MZWRT_DOWNLD_FILE}/Plugins/update/cloudflared.sh" "cloudflared.sh"
fi

if confirm "是否更新 nextdns 插件"; then
    download_and_run_plugin "${MZWRT_DOWNLD_FILE}/Plugins/update/nextdns.sh" "nextdns.sh"
fi

if confirm "是否更新 xfrpc 插件"; then
    download_and_run_plugin "${MZWRT_DOWNLD_FILE}/Plugins/update/xfrpc.sh" "xfrpc.sh"
fi

# 修改 PKG_SOURCE
if confirm "是否修复uugamebooster下载连接?"; then
    echo "修复uugamebooster下载连接"
    sed -i 's|PKG_SOURCE:=.*|PKG_SOURCE:=uu.tar.gz|' package/feeds/packages/uugamebooster/Makefile
    sed -i 's|PKG_SOURCE_URL:=.*|PKG_SOURCE_URL:=https://uu.gdl.netease.com/uuplugin/openwrt-$(ARCH)/v$(PKG_SOURCE)|' package/feeds/packages/uugamebooster/Makefile
    echo "uugamebooster 已更新。"
fi

# 应用bpftools补丁
if confirm "是否应用bpftools补丁?"; then
    echo "应用bpftools补丁"
    wget -O package/network/utils/bpftools/patches/001-fix-init_disassemble_info.patch https://raw.githubusercontent.com/mzwrt/mzwrt_package/main/.github/patches/bpftools.patch
    echo "bpftools 补丁已应用。"
fi

# 应用tgt补丁
if confirm "是否应用tgt补丁?"; then
    echo "应用tgt补丁"
    wget -O feeds/packages/net/tgt/patches/01_pread64.patch https://raw.githubusercontent.com/mzwrt/mzwrt_package/refs/heads/main/.github/patches/tgt.patch
    echo "tgt补丁 补丁已应用。"
fi

exit 0
