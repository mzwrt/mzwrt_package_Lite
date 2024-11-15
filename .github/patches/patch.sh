#!/bin/bash
 # 翻译脚本
patch -p1 < $GITHUB_WORKSPACE/.github/patches/homeproxy.patch
# 修复下载连接和添加 MTK ARM 支持 
patch --no-backup-if-mismatch -p1 < $GITHUB_WORKSPACE/.github/patches/webd.patch
# 修复unknown type name 'uint8_t' 的问题，uint8_t 是在 <stdint.h> 头文件中定义的类型，因此需要在源代码中包含该头在文件中加上 #include <stdint.h>
patch --no-backup-if-mismatch -p1 < $GITHUB_WORKSPACE/.github/patches/netkeeper-interception.patch
# 修复代理错误 speedtest-web.patch
patch --no-backup-if-mismatch -p1 < $GITHUB_WORKSPACE/.github/patches/speedtest-web.patch
exit 0
