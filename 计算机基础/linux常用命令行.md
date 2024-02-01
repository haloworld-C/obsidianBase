### basic concept
- `linux` 是一种类`unix`(接口兼容Posix)操作系统。
### 高频常用命令行

|命令行名称|说明||
|---|---|---|
|基本操作|
|dpkg -i <you.deb>|安装deb包| 需要先给dep包添加执行权限|  
|apt purge [package name]|删除软件及其配置及依赖包|   |
| apt remove [package name] | 删除软件（保留配置及依赖包）| 
| apt autoremove [package name] | 删除当前不需要的依赖包|  
| apt list --installed| 列出已安装软件包|  
|文件系统||
| pwd | 显示当前绝对路径| |
| grep [string]  [文件名] | 搜索文本内的内容| 第二个参数为待匹配内容|
| find [目录路径] -选项参数 -搜索条件 | 搜索文件及文件夹|find ./ -name "*.txt*"| 
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
|iperf -s  | 服务器执行 | 先在被测机器上开启服务，然后再测试机器上执行下一个命令|
|iperf -c  [ip address] -i 1 -t 10| 检查带宽 | |
|文件系统|
|du -sh  [文件夹]| 查看文件夹大小 | |
|tar -czvf [压缩包名称] 文件夹名称| 创建压缩包 |c代表创建压缩包文件， v代表显示详细过程， f表示创建的是文件, z代表二次压缩.gz |
|tar -zxf|解压缩上面压缩的文件包|
|ps -ef| 查看进程信息 |-e 显示所有活动进程 -f显示所有信息 -a 显示所有执行程序 -u 以用户作区分 -x 显示所有程序, 不区分终端|
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
||查看系统内存||
|[command] | tee `fil1.txt`  `file2.txt`|命令基于标准输入读取数据，标准输出或文件写入数据,可以同时输出文件和命令行|tee -a 为文件追加模式|
|stdbuf [OPTION] [COMMAND]|将其他命令输出写入buffer, 以便适应不同命令的响应速度||
|date|显示或设置时间||
|sync|强制buffer写入文件|写入操作先写入buffer，再由操作系统写入文件，如果很多地方在写入可能会出现乱序或丢失的现象|
|wc -l|统计标准输出行数、字数、字节数等|`-l`统计行数|
|du -sh|查看当前目录大小|du -h [dir]|
|tail [filename]|查看文件的末尾行|-f 持续更新文件，以便实时显示|
|:w !  sudo  tee  %|在vim内获取sudo 权限保存文件||
|时间同步|
|ntpdate [cn.pool.ntp.org]|从时间服务器同步时间||
|hwclock --systohc|将系统时间同步到板载时间||
|硬件相关|
|dmesg|产看硬件相关驱动log||
| 网络相关|
|arp -a| 扫描所有ip及主机||
|nmap -sRn 10.42.0.* -oN out.txt|扫描网段主机ip, mac地址||
### 常用命令组合
```bash
# 查找相关字符
[command] | grep "context" 
# 文件重定位
echo "context" >> a.txt # >> 追加模式， > 为覆盖模式
# 查看是否有网
ping www.baidu.com -c 1 | tail -n 1 | grep min
# 查看当前文件夹的文件个数
ls -l | grep "^-" | wc -l # 不包含子目录
ls -lR | grep "^-" | wc -l # 包含子目录
# 查看当前文件夹的文件夹个数
ls -lR | grep "^d" | wc -l
# 搜索文件名称
find ./ -name '*.bag'
```



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
8. 远程服务器terminal: `Tmux`
- basic concept
	可以实现断连后terminal不挂掉， 可以根据`session`再次进入
 - 安装
```bash
sudo apt-get install tmux
```
- 使用

|命令行名称|说明||
|---|---|---|
|tmux new -s window | 新建名为windows的session|`tmux new -s windos -d ` 后台启动session |  
|tmux attach -t window | 与后台的windows session进行绑定||
|tmux send -t "command" Enter| 向session后台发送命令而不进入||
|tmux has-session -t "${session_name}" 2>/dev/null|判断是否存在指定session| 使用？环境变量判断|

```bash
tmux has-session -t "${session_name}" 2>/dev/null
if [ "$?" -eq 1 ] ; then
    echo "has not nav_window tmux session, create.."
else
```
9. `.rar`压缩文件解压缩
```bash
sudo apt install unrar
unrar x [file]
# or
sudo apt install urar
urar [file]
```
10. 运行`.jar`
```bash
java -jar [jar name]
```
11. 追踪程序的调用堆栈
```bash
sudo strace [programe]
```
12. 监控文件修改记录
```bash
sudo apt install auditd # 后台守护进程
aditctl -w /root/.ssh/authorized_keys -p war -k auth_key
# -w 要监控的文件
# -p 要监控的类型 append, write, read, execute
# -k 给这条监控起个名字，方便查找
```

13. tmux
替代工具screen
- 快捷键

|快捷键|说明|
|---|---|
|Ctrl+b+d | 分离当前session|  
|Ctrl + b +\[|上下移动|
|Ctrl+b %|划分左右两个窗格|
|Ctrl+b "|划分上下两个窗格|
|Ctrl+b [arrow key]|光标切换到其他窗|
|Ctrl+b ;|光标切换到上一个窗格|
|Ctrl+b o |光标切换到下一个窗格|
|Ctrl+b {|当前窗格与上一个窗格交换位置|
|Ctrl+b }|当前窗格与下一个窗格交换位置|
|Ctrl+b Ctrl+o|所有窗格向前移动一个位置，第一个窗格变成最后一个窗格|
|Ctrl+b Alt+o|所有窗格向后移动一个位置，最后一个窗格变成第一个窗格|
|Ctrl+b x|关闭当前窗格|
|Ctrl+b !|将当前窗格拆分为一个独立窗口|
|Ctrl+b z|当前窗格全屏显示，再使用一次会变回原来大小|
|Ctrl+b Ctrl+[arrow key]|按箭头方向调整窗格大小|
|Ctrl+b q|显示窗格编号|

- 设置自启动
```rc.local
export HOME=/home/firefly
/usr/bin/tmux new -s window -d
## run nav
/usr/bin/tmux send -t "window" "${cur_work_space}/install/share/scripts/script/auto_run.bash" Enter # 向后台发送命令而不进入
```
> 如果在`rc.local`中设置自启`tmux`则需要`root`权限才能运行

### 注意事项
- 在terminal界面如果按下Ctrl+s则会冻结该命令行的输出输入（如果是在编辑器则无法编辑及移动光标），可以按下Ctrl+q则可解除这种锁定
- 如果你不理解正在做什么，坚决不做

####  问题
1. expect中应该使用双引号
```expect
spawn rsync -avzP --progress -e  'ssh -p 8100' nvidia@47.98.115.107:/home/nvidia/Documents/code/install    /    ./ #报参数不识别
spawn rsync -avzP --progress -e  "ssh -p $port" $host1:/home/nvidia/Documents/code/install/  /home/test/Downloads # 应该使用双引号

```
2. sudo需要手动输入密码
```bash
echo "password" | sudo -S CMD
```


## Linux维护
### 自动化
#### 自启脚本启动顺序 
- /etc/rc.d, 内脚本(注意脚本是否一定可以返回0, 换言之不能阻塞)
- /etc/rc.local , 随系统启动
- /etc/profile , 用户登录启动
- ~/.bashrc, 随命令行启动
#### 工具列表
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
- 在/etc/profile.d/文件夹下面写脚本
- 开启服务或软件开机自启
参见[[Ubuntu设置]]
4. ssh启动远程GUI 
- 主要原理为Xserver的服务器客户端架构(本来走的就是网络), 在实现上需要再运行GUI的机子上运行客户端, 在需要显示GUI的机子上运行服务端.
- 服务器端配置(显示GUI机器)
```bash
sudo vim /etc/ssh/ssh_config
```
注释掉一下内容:
```config
X11Forwarding yes
X11DisplayOffset 10
X11UseLocalhost yes
```
连接ssh:
```bash
ssh -X user@192.168.99.2
```