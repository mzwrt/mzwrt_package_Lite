<div align="center">
<h1 align="center">每天同步上游分支代码</h1>
<h3 align="center">缺少插件请提交issues，不定期查看收录，目的是做一个全面的仓库，如果遇到错误信息无法解决，可以查阅错误披露可能会获得一些解决思路，默认会修复一些小问题</h3>
</div>


- #### 使用方式：

```
 sed -i '$a src-git mzwrt_package https://github.com/mzwrt/mzwrt_package' feeds.conf.default
```
上面的命令是在文件：`feeds.conf.default`里面添加`src-git mzwrt_package https://github.com/mzwrt/mzwrt_package` 可以手动添加，但是建议命令添加防止出错

- #### lena的lede编译前纠错脚本
```
wget https://raw.githubusercontent.com/mzwrt/mzwrt_package/refs/heads/main/.github/patches/lean-lede.sh && bash lean-lede.sh -y && rm -rf lean-lede.sh
```
直接在openwrt根目录执行就可以（lede目录）只要没有报错信息就是可以正常编译，有报错信息请提交issues带上报错信息提交

<br>

- #### [补丁应用](https://github.com/mzwrt/mzwrt_package/wiki/patch)
补丁默认已经应用，无需自己操作，披露的原因是可以让需要的人有迹可循，点击此链接[patch](https://github.com/mzwrt/mzwrt_package/wiki/patch)有详细解释，补丁是使用lean的lede进行编写的，默认支持所有openwrt主分支和其他分支

- #### [错误信息披露](https://github.com/mzwrt/mzwrt_package/wiki/error)
点击此链接[error](https://github.com/mzwrt/mzwrt_package/wiki/error)查看错误信息，里面有详细的错误信息和大概解决办法,错误并不全面，其他问题请自行解决，谢谢


- #### 感谢

*  [openwrt](https://github.com/openwrt/openwrt.git)


*  感谢以上github仓库所有者的无私奉献








