<div align="center">
<h1 align="center">每天同步上游分支代码</h1>
<h3 align="center">缺少插件清提交issues，不定期查看收录，目的是做一个全面的仓库</h3>
</div>


#### 使用方式：

```bash
 sed -i '$a src-git mzwrt_package https://github.com/mzwrt/mzwrt_package' feeds.conf.default
```
<br>

对于`不覆盖核心包“XXXX”；使用 -f 强制` 问题建议`./scripts/feeds install -a -f` 即可或者用下面的命令尝试删除冲突的插件
<br>
```bash
rm -rf feeds/smpackage/{base-files,dnsmasq,firewall*,fullconenat,libnftnl,nftables,ppp,opkg,ucl,upx,vsftpd*,miniupnpd-iptables,wireless-regdb}
```
<br>
#### 感谢

*  [openwrt](https://github.com/openwrt/openwrt.git)


*  感谢以上github仓库所有者的无私奉献








