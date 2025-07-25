include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-bypass
PKG_VERSION:=1.2
PKG_RELEASE:=21

PKG_CONFIG_DEPENDS:= \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Libev_Server \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Libev_Client \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_ShadowsocksR_Libev_Client \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_ShadowsocksR_Libev_Server \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Simple_obfs \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Simple_obfs_server \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_V2ray_plugin \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Xray \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Trojan \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_NaiveProxy \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Kcptun \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Hysteria \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Socks5_Proxy \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Socks_Server

LUCI_TITLE:=SS/SSR/Xray/Trojan/NaiveProxy/Socks5/Tun LuCI interface
LUCI_PKGARCH:=all
LUCI_DEPENDS:=+ipset +kmod-ipt-nat +ip-full +iptables-mod-tproxy +lua-neturl +dnsmasq-full +smartdns +coreutils +coreutils-base64 +curl +tcping +chinadns-ng +lua +luci-compat +luci-lib-ipkg +unzip \
	+PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Libev_Server:shadowsocks-libev-ss-server \
	+PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Libev_Client:shadowsocks-libev-ss-local \
	+PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Libev_Client:shadowsocks-libev-ss-redir \
	+PACKAGE_$(PKG_NAME)_INCLUDE_ShadowsocksR_Libev_Client:shadowsocksr-libev-ssr-local \
	+PACKAGE_$(PKG_NAME)_INCLUDE_ShadowsocksR_Libev_Client:shadowsocksr-libev-ssr-redir \
	+PACKAGE_$(PKG_NAME)_INCLUDE_ShadowsocksR_Libev_Server:shadowsocksr-libev-ssr-server \
	+PACKAGE_$(PKG_NAME)_INCLUDE_Simple_obfs:simple-obfs \
	+PACKAGE_$(PKG_NAME)_INCLUDE_V2ray_plugin:v2ray-plugin \
	+PACKAGE_$(PKG_NAME)_INCLUDE_Xray:xray-core \
	+PACKAGE_$(PKG_NAME)_INCLUDE_Trojan:trojan-plus \
	+PACKAGE_$(PKG_NAME)_INCLUDE_NaiveProxy:naiveproxy \
	+PACKAGE_$(PKG_NAME)_INCLUDE_Kcptun:kcptun-client \
	+PACKAGE_$(PKG_NAME)_INCLUDE_Hysteria:hysteria \
	+PACKAGE_$(PKG_NAME)_INCLUDE_Socks5_Proxy:redsocks2 \
	+PACKAGE_$(PKG_NAME)_INCLUDE_Socks_Server:microsocks

define Package/$(PKG_NAME)/config

config PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Libev_Client
	bool "Include Shadowsocks Libev Client"
	default y if i386||x86_64||arm||aarch64

config PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Libev_Server
	bool "Include Shadowsocks Libev Server"
	default y if i386||x86_64||arm||aarch64

config PACKAGE_$(PKG_NAME)_INCLUDE_ShadowsocksR_Libev_Client
	bool "Include ShadowsocksR Libev Client"
	default y

config PACKAGE_$(PKG_NAME)_INCLUDE_ShadowsocksR_Libev_Server
	bool "Include ShadowsocksR Libev Server"
	default y if i386||x86_64||aarch64

config PACKAGE_$(PKG_NAME)_INCLUDE_Simple_Obfs
	bool "Include Shadowsocks Simple Obfs Plugin"
	default y

config PACKAGE_$(PKG_NAME)_INCLUDE_V2ray_plugin
	bool "Include Shadowsocks V2ray Plugin"
	default n

config PACKAGE_$(PKG_NAME)_INCLUDE_Xray
	bool "Include Xray"
	default y

config PACKAGE_$(PKG_NAME)_INCLUDE_Trojan
	bool "Include Trojan"
	default y if i386||x86_64||arm||aarch64

config PACKAGE_$(PKG_NAME)_INCLUDE_NaiveProxy
	bool "Include NaiveProxy"
	depends on !(arc||armeb||mips||mips64||powerpc)
	default n

config PACKAGE_$(PKG_NAME)_INCLUDE_Kcptun
	bool "Include Kcptun"
	default n

config PACKAGE_$(PKG_NAME)_INCLUDE_Hysteria
	bool "Include Hysteria"
	default n

config PACKAGE_$(PKG_NAME)_INCLUDE_Socks5_Proxy
	bool "Include Socks5 Transparent Proxy"
	default n

config PACKAGE_$(PKG_NAME)_INCLUDE_Socks_Server
	bool "Include Socks Sever"
	default y
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/bypass
/etc/bypass/
endef

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
