### 高频常用命令行

|命令行名称|说明||
|---|---|---|
|dpkg -i <you.deb>|安装deb包| 需要先给dep包添加执行权限|  
|apt purge [package name]|删除软件及其配置及依赖包|   |
| apt remove [package name] | 删除软件（保留配置及依赖包）| 
| apt autoremove [package name] | 删除当前不需要的依赖包|  
| apt list --installed| 列出已安装软件包|  
| grep [string] | 搜索文本| 
| scp [remote_usr_name@ip_address]:[dir] [本地文件夹] | 将远程电脑中的制定文文件拷贝到本地，反过来则是推送（若是文件夹，则加参数-r）| 
| rsync - avztP [remote_usr_name@ip_address]:[dir] [本地文件夹] | 将远程电脑中的制定文文件同步到本地，反过来则是推送| 适用于大文件夹内点局域网传输 -a 以归档模式传输， -v显示传输过程中的详细信息， -z压缩传输数据， -P显示传输进度, -t 比较文件时间戳|
|ln [参数] [源文件或目录] [目标文件或目录] |当我们需要在不同的目录，用到相同的文件时，我们不需要在每一个需要的目录下都放一个必须相同的文件，我们只要在某个固定的目录，放上该文件，然后在 其它的目录下用ln命令链接（link）它就可以，不必重复的占用磁盘空间。可用在git submodule中，或ros 工作空间中|-s 软链接| 
|ls -l (ll)|列出文件夹内所有的链接| 
|ls -h |列出文件夹内文件的大小，以KB,MB,GB为单位进行显示| 
|unlink link| 进入有软链接的/link文件夹下，删除对应的链接文件|          
|cd - | 返回上次历史目录，利用该命令可以在两个相距较远的目录之间i进行跳转|
|adduser [user name] | 创建用户 |
| passwd [user name] | 修改用户密码|
|su [user name] | 切换用户 |
| chown [user name] [filename] | 更改文件所属用户 ,如果是文件夹则添加-R参数|
| chgrp [user group] [filename] | 更改文件所属用户组 ,如果是文件夹则添加-R参数|
| whereis [package] | 查找package的环境路径| 
| whichis [file name] | 查找file的文件位置| 
| sudo ldconfig | 更新链接库|
|*网络相关*|
|telnet ip:port|            |
|service network-manager restart|重启网络服务            |
|clear | 清楚命令行窗口历史文本|
|man ascii | 显示ascii码对照表 | |
|nslookup  [域名]| 刷新dns域名列表 | |
|du -sh  [文件夹]| 查看文件夹大小 | |
|tar -czvf [压缩包名称] 文件夹名称| 创建压缩包 |c代表创建压缩包文件， v代表显示详细过程， f表示创建的是文件, z代表二次压缩.gz |
|tar -zxf|解压缩上面压缩的文件包|
|ps -ef| 查看进程信息 |-e 显示所有活动进程 -f显示所有信息 |
|top -p [进程ID]| 查看该进程的资源消耗 | |
|htop| 查看整体电脑资源占用情况 | |
|ldd| 打印动态链接库的目录或程序所依赖的动态链接库 | |
|df -h| 查看每个根目录下的分区大小 | |
|shutdown -h [time]|关机 |单位为分钟， 0 或now为马上关机 |
|crontab -e|编辑定时执行任务并开启服务|这个命令只对当前用户生效|
| *系统相关*|
|uname -r|查看内核版本||
|lsb_release -r|查看ubuntu的版本||
|free -h|查看系统内存||




### 高效小工具
1. terminator多页面命令行终端
terminator安装完成后会设置为默认terminal，如果我们要切换回系统自带终端：
```bash
 sudo update-alternatives --config x-terminal-emulator
```
然后选择`/usr/bin/gnome-terminal.wrapper`
2. `zsh` + `oh-my-zsh`
3. 考虑使用aptitude作为日常软件的管理工具，而apt作为系统升级的工具
4. apt-file工具可以查找某个动态链接库的安装包：
```bash
sudo apt install apt-file # 安装
sudo apt-file update # 读取软件库index
apt-file search [lib-xxx.so] # 返回包含该动态库的安装包
```
5. ffmpeg视频压缩
- 安装
```bash
sudo apt install ffmpeg
```
- 压缩视频
```bash
ffmpeg -y -i test.avi -s 800x640 -vcodec libx264 -preset fast -qscale 4 -r 25 out.mp4
# 命令参数：
# -y: 当已存在out.mp4是，不提示是否覆盖。
# -i : “test.avi” 输入文件名
# -s: 400x240 输出的分辨率，注意片源一定要是16:9的不然会变形
# -vcodec -libx264: 输出文件使用的编解码器。
# -preset fast: 使用libx264做为编解码器时，需要带上这个参数。
# -b: 80000 视频数据流量，用-b xxx表示使用固定码率，数字可更改；还可以用动态码率如：-qscale 4和-qscale 6，4的质量比6高（一般用80000就可以了，否则文件会很大）
# -acodec: aac 音频编码用AAC
# -ac 2 声道数1或2
# -ar: 48000 声音的采样频率
# -ab: 128 音频数据流量，一般选择32、64、96、128#-vol 200 200%的音量，可更改（如果源文件声音很小，可以提升10到20倍1000%~2000%）
# -an 移除音频
# -r: 25 帧数 (一般用25就可以了)
# out.mp4: 输出文件名。
```
6. sshpass免密码登录ssh
```bash
sshpass -p nvidia ssh nvidia@192.168.1.188
```
> 可能先要登录一下ssh添加信任设备
7. 引导修复
- 本机修复
```bash
sudo os-prober # 探测本机安装的其他系统
sudo update-gurb # 更新探测到的系统到grub引导
```
- 启动盘root-repair修复
```bash
sudo add-apt-repository ppa:yannubuntu/boot-repair 
sudo apt-get update # 添加软件库
sudo apt-get install -y boot-repair # 安装
boot-repair #运行, 点击recommended repair即可
```

### 注意事项
- 在terminal界面如果按下Ctrl+s则会冻结该命令行的输出输入（如果是在编辑器则无法编辑及移动光标），可以按下Ctrl+q则可解除这种锁定
- 如果你不理解正在做什么，坚决不做

## Linux维护
### 自动化
1. ansible playbook
2. cron
示例：
```cron
#crontab -e
# m h  dom mon dow   command
 0 * * * * /bin/bash -c 'DISPLAY=:0 zenity --width 500 --info --title "一休！休息一下!" --text "喝水>    ！上厕所!"' >> /home/test/Documents/logs/cron/logfile 2>&1
```

3. expect
#### 开机自启动
1. 在/etc/profile.d/文件夹下面写脚本