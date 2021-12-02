- 镜像拉取
```bash
docker pull [镜像名称]
```
- 镜像运行
```bash 
docker run -itd [镜像名称] /bin/bash
```
- 启动镜像并挂载宿主机目录
```bash
docker run -itd -v [宿主机绝对目录]：[容器绝对目录] [镜像name or ID] /bin/bash
```
- 查看正在运行的镜像
```bash
docker ps -a
```
- 进入某个运行中的镜像命令行
```bash
docker exec -it [container ID] /bin/bash
```
- 列出本机docker 镜像
```bash
docker images
```
- 退出命令行交互
```bash
exit
```

### Q&A
1.  安装docker后出现permission denied错误
- 原因：docker 进程使用Unix Socket而不是TCP端口。而默认情况下，Unix socket属于root用户，需要root权限才能访问。
- 解决方案（来源：菜鸟教程）
（1）命令行都用sudo执行
（2）docker守护进程启动的时候，会默认赋予名字为docker的用户组读写Unix socket的权限，因此只要创建docker用户组，并将当前用户加入到docker用户组中，那么当前用户就有权限访问Unix socket了，进而也就可以执行docker相关命令。
```bash
sudo groupadd docker #添加docker用户组 
sudo gpasswd -a $USER docker #将登陆用户加入到docker用户组中 
newgrp docker #更新用户组 
docker ps #测试docker命令是否可以使用sudo正常使用
```