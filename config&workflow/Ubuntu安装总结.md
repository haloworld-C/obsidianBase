最近因为装机的需要，又重新安装了一次Ubuntu，还是有不少坑的，故做一次系统的总结学习。
### Core concept
几种引导模式是安装失败的第一个坑, 有必要进行一下区分:
### BIOS模式
- UEFI
UEFI为目前的主流版本，为BIOS的升级版本(虽然现在说到BIOS， 指的可能是UEFI，BIOS或CMS中的一种， 用来代指板载驱动，或者叫做固件)，并提供了鼠标支持的， 并且可以为2TB以上的硬盘提供分区表，加载速度更快
- Legacy
即传统的BIOS模式，通过硬盘的引导进入系统，只能为2TB以内的硬盘提供分区表
- CMS
兼容了UEFI和Legacy Bios的板载系统，是UEFI的升级版本， 可以同时引导新旧系统。
总而言之，要区分的是Legacy BIOS 和UEFI BIOS这两种， 而CMS则是两者的兼容模式
#### 引导格式
- MBR
适用与Legacy Bios的分区表格式
> 在Legacy下安装Ubuntu，可以不用提供/boot分区，只需要选择可引导的硬盘即可
- GPT
适用于UEFI的引导分区表格式
> 如果是在UEFI下面安装Ubuntu， 则需要Fat32格式的/efi分区(也即boot分区)
#### boot loader
- BCD
windows下的系统引导程序
- grub
Linux下的系统引导程序, 如果是双系统或者多系统，最好是让Linux引导Windows, 因为grub远比BCD灵活与稳定。
### 下载镜像
对于Ubuntu而言推荐，xx.04的版本，应为是以十年为周期进行维护的，所以其内核版本会比较新。
### 制作启动U盘
- 在windows下推荐uios进行烧录
- 在ubuntu下可以使用系统自带的usb-creator
```bash
sudo usb-creator-gtk
```
### 安装系统
第二个坑是系统分区，主要容易错的地方是硬盘分区， 推荐如下
- /boot分区
如果是Legacy启动，不需要单独的/boot分区
如果UEFI启动，则需要一个500M左右的/efi分区，格式为fat32
- 遇到一个问题，如果是UEFI启动则无法引导Legacy windows，解决方法是(推荐第二种方法， 第一种不能发挥出硬件的全部性能, 且不能很方便地切换到大硬盘上)
	1. Ubuntu也采用Legacy的模式
	2. 将Legacy Windows 转换为UEFI模式则可正常引导
- /swap分区
其容量为内存打下的两倍即可, 太小可能导致内存满的情况性能衰退
- / 根目录分区
一般60G就够用了
- /home分区
越大越好， 一般80个G肯定是够用了
### 系统设置
1. 换源
- 可以手动更换/etc/apt/sources.list内部的内容，一般用中科大源
- 另一种更方便高效的做法是打开/etc/apt的文件夹(文件夹地址栏按Ctrl+L可手动输入地址)，双击sources.list文件, 弹出的窗口点开Download from的下拉菜单, 点击other，然后点击Select best server，系统会按照网速设置一个最快的， 如下图所示：
![update_sources](../../Resourse/update_sources.png)
更新源后记得更新一下:
```bash
sudo apt update
```
2. 安装sogou中文输入法
[参考sougou官网](https://shurufa.sogou.com/linux/guide)
3. 个人配置
- oh-my-zsh
- terminator
- git
等
### 补充
#### 引导修复工具
- windows系统: easybcd
- ubuntu系统: boot-repair(最好用引导盘进行操作， 不要在本机操作)
> TODO：
> 1. 写一个init_install脚本
> 2. 考虑做一个配置的系统固件