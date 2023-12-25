### concept
系统选择首选debian(稳定性极佳)
追求上手既用，兼容性最好：ubuntu(稳定性欠佳，第三方库支持比较好)

### 各种配置
#### 设置root密码
只有设置了root密码后才能使用`su`命令
```bash
sudo passwd root #连续输入两次新密码
```
### 内核升级
#### 图形界面工具`ukuu-gtk`
- 添加源
```bash
 sudo add-apt-repository ppa:teejee2008/ppa && sudo apt update
```
- 安装
```bash
sudo apt-get install ukuu
```
### 环境变量 
- 修改hostname
```/etc/hostname
[your hostname] # 重启生效
hostname newname # 让hostname立即生效
主要配置:
```



### issues
1. 发现Ubuntu系统进不去，是因为根目录下空间满了的原因，软件也装不进去，debug了半天发现是一个假的大文件导致，删除了就好了。