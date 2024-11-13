<div align="center">
<h1 align="center">每天同步上游分支代码</h1>
<h3 align="center">缺少插件清提交[issues](https://github.com/mzwrt/mzwrt_package/issues)，每天查看收录，目的是做一个全面的仓库</h3>
</div>


#### 使用方式：

```bash
 sed -i '$a src-git mzwrt_package https://github.com/mzwrt/mzwrt_package' feeds.conf.default
```
对于强迫症的同学（有报错信息、或Lean源码编译出错的情况），请尝试删除冲突的插件

```bash
rm -rf feeds/smpackage/{base-files,dnsmasq,firewall*,fullconenat,libnftnl,nftables,ppp,opkg,ucl,upx,vsftpd*,miniupnpd-iptables,wireless-regdb}
```

#### 感谢

*  [openwrt](https://github.com/openwrt/openwrt.git)


*  感谢以上github仓库所有者的无私奉献








