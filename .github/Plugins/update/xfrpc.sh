# 设置插件路径
xfrpc_PLUGIN_PATH="feeds/packages/net/xfrpc"

# 获取最新发布版的版本号和下载 URL
xfrpc_LATEST_RELEASE=$(curl -s https://api.github.com/repos/liudf0716/xfrpc/releases/latest)

# 如果获取失败，提示错误并退出
if [ -z "$xfrpc_LATEST_RELEASE" ]; then
  echo "无法获取最新发布版信息!"
  exit 1
fi

# 从发布版信息中提取版本号和下载 URL
xfrpc_NEW_VERSION=$(echo "$xfrpc_LATEST_RELEASE" | jq -r .tag_name)  # 获取版本号
xfrpc_TARBALL_URL=$(echo "$xfrpc_LATEST_RELEASE" | jq -r .tarball_url)  # 获取下载 URL

# 下载源代码包并计算 SHA256 哈希值
echo "正在下载源代码包..."
xfrpc_TARBALL_FILE="xfrpc-${xfrpc_NEW_VERSION}.tar.gz"
curl -L "$xfrpc_TARBALL_URL" -o "$xfrpc_TARBALL_FILE"

if [ ! -f "$xfrpc_TARBALL_FILE" ]; then
  echo "下载源代码包失败!"
  exit 1
fi

# 计算下载源代码包的 SHA256 哈希
xfrpc_NEW_MIRROR_HASH=$(sha256sum "$xfrpc_TARBALL_FILE" | awk '{ print $1 }')

# 检查是否成功计算哈希值
if [ -z "$xfrpc_NEW_MIRROR_HASH" ]; then
  echo "计算文件哈希失败!"
  exit 1
fi

# 删除下载的源代码包
rm -f "$xfrpc_TARBALL_FILE"

# 更新 Makefile 中的版本号、源代码版本和哈希
echo "更新插件版本号和发布版哈希..."

# 使用绝对路径更新 Makefile
sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=${xfrpc_NEW_VERSION}/" "$xfrpc_PLUGIN_PATH/Makefile"
#sed -i "s|PKG_SOURCE_URL:=.*|PKG_SOURCE_URL:=${xfrpc_TARBALL_URL}|" "$xfrpc_PLUGIN_PATH/Makefile"
sed -i "s/PKG_MIRROR_HASH:=.*/PKG_MIRROR_HASH:=${xfrpc_NEW_MIRROR_HASH}/" "$xfrpc_PLUGIN_PATH/Makefile"

echo "更新完成: "
echo "  - 新版本: $xfrpc_NEW_VERSION"
echo "  - 新源代码包 URL: $xfrpc_TARBALL_URL"
echo "  - 新文件哈希: $xfrpc_NEW_MIRROR_HASH"

echo "插件更新完毕！"
