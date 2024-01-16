### concept
系统选择首选debian(稳定性极佳)
追求上手既用，兼容性最好：ubuntu(稳定性欠佳，第三方库支持比较好)

### 各种配置
#### 设置密码
- 设置root密码
只有设置了root密码后才能使用`su`命令
```bash
sudo passwd root #连续输入两次新密码
```
- 设置用户密码
```
sudo passwd [username] #根据提示输入两次密码
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
### 挂载硬盘
比如将/home挂载到其他硬盘下:
0. 查看存储介质
```bash
sudo fdisk -l
```
1. 如果没有格式化，格式化为ext4
```bash
sudo mkfs -t ext4 /dev/abcd
```
2. 将新硬盘临时挂载在一个目录下:
```bash
sudo mkdir /mnt/home # or /media/home
sudo mount /dev/abcd /mnt/home
df -h # 查看是否挂载成功
```
3. 同步(复制)原home路径下的文件到硬盘中:
```bash
sudo cp -a /home/* /mnt/home/
# or 
sudo rsync -aXS /home/. /mnt/home/.
sudo mv /home /home_old # 备份原始目录
```
4. 重新挂载硬盘到/home下
```bash
sudo umount /dev/abcd
sudo mkdir /home
sudo mount /dev/abcd /home
```
5. 设置自动挂载
```bash
sudo blkid # 查看硬盘识别号UUID
```
修改`/etc/fstab`文件实现开机自动挂载:
```/etc/fstab
UUID=9aa48a41-cbab-452c-85e29a4602190e84  /home  ext4  defaults  0  2
#第一列：UUID为硬盘识别号
# 第五列 0： 不备份dump
# 第六列 2： 开机自检
```
### 维护
#### service
- 查看service状态
```bash
systemctl status rsyslog.service # 只看当前启动日志
journalctl -u rsyslog.service # 历史启动日志
```
### issues
1. 发现Ubuntu系统进不去，是因为根目录下空间满了的原因，软件也装不进去，debug了半天发现是一个假的大文件导致，删除了就好了。