### 问题
因为日常使用terminator作为命令行工具，在同一个窗口打开多个命令行工具。Ubuntu下安装也很简单：
```bash
sudo apt install terminator
```
但是在preference->layout设置中保存当前窗口布局时，总是没有更新~/.config/terminator/config（Terminator的配置文件）。
### 解决方法
尝试了很多次，发现是常见的文件权限问题。看到config的权限与用户组都是root，更改权限后问题解决。更改文件用户与用户组的命令如下：
```bash
sudo chown [username]  [filename]#更改文件所属用户，如果是文件夹则添加-R参数
sudo chgrp [usergroup] [filename]#更改文件所属用户组，如果是文件夹，则添加-R参数
```
### 参考
> [配置layout步骤参考](https://www.jianshu.com/p/e9f693c84635)
