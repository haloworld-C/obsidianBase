### 高频常用命令行
|命令行名称|说明|
|---|---|---|
|dpkg -i <you.deb>|安装deb包|  
|apt purge <package name>|删除软件及其配置及依赖包|   
| apt remove <package name> | 删除软件（保留配置及依赖包）| 
| apt autoremove <package name> | 删除当前不需要的依赖包|  
| apt list --installed| 列出已安装软件包|  
| grep <string> | 搜索文本| 
| scp <remote_usr_name@ip_address>:<dir> <本地文件夹> | 将远程电脑中的制定文文件拷贝到本地，反过来则是推送（若是文件夹，则加参数-r）| 
|ln [参数] <源文件或目录> <目标文件或目录> |当我们需要在不同的目录，用到相同的文件时，我们不需要在每一个需要的目录下都放一个必须相同的文件，我们只要在某个固定的目录，放上该文件，然后在 其它的目录下用ln命令链接（link）它就可以，不必重复的占用磁盘空间。|-s 软链接| 
|ls -l (ll)|列出文件夹内所有的链接| 
|unlink link| 进入有软链接的/link文件夹下，删除对应的链接文件|          
|cd - | 返回上次历史目录，利用该命令可以在两个相距较远的目录之间i进行跳转|
|adduser [user name] | 创建用户 |
| passwd [user name] | 修改用户密码|
|su [user name] | 切换用户 |
| chown [user name] [filename] | 更改文件所属用户 ,如果是文件夹则添加-R参数|
| chgrp [user group] [filename] | 更改文件所属用户组 ,如果是文件夹则添加-R参数|
| whereis <package> | 查找package的环境路径| 
| whichis <file name> | 查找file的文件位置| 
| sudo ldconfig | 更新链接库|
| *网络相关*|
|telnet ip:port|            |
|clear | 清楚命令行窗口历史文本|
|man ascii | 显示ascii码对照表 | |
|nslookup  <域名>| 刷新dns域名列表 | |




### 高效小工具
1. terminator多页面命令行终端
2. fish交互式命令提示工具
3. 考虑使用aptitude作为日常软件的管理工具，而apt作为系统升级的工具

### 注意事项
- 在terminal界面如果按下Ctrl+s则会冻结该命令行的输出输入（如果是在编辑器则无法编辑及移动光标），可以按下Ctrl+q则可解除这种锁定

## Linux维护
### 自动化
1. ansible playbook
2. cron
3. expect