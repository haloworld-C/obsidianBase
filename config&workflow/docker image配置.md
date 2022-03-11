### 概述
docker 用作日常开发环境不失为一种稳定的环境，可以在一定程度上隔离硬件环境。
配置docker主要有两种方法。

### 主要配置方式
1. 自己制作docker images


2. docker file


### 脚本配置
```bash
# start.sh
#!/bin/bash
VERSION="ubuntu1804-halo-dev"
xhost + #打开远程桌面权限
CURRENT_FILE_PATH=$(dirname $(dirname "$PWD")) #设置路径环境变量
docker run -it \  # 使用命令行交互
-d \              # 后台运行
--name halo-dev \ # 镜像名称
--net=host \      # 使用本机网络
--hostname halo2world \   # docker内主机网络名称
-e DISPLAY=unix$DISPLAY \ # 显示界面相关
-v /tmp/.X11-unix:/tmp/.X11-unix:rw \ #共享桌面显示
--privileged \    # 使容器可以访问宿主机资源
--gpus all\       # 访问显卡
-v $CURRENT_FILE_PATH/..:/home/halo2world/ \ # 挂载工作路径
-e NVIDIA_DRIVER_CAPABILITIES=all \          # 链接宿主机驱动到docker，如果没有按装官方驱动则不需要
-v /etc/localtime:/etc/localtime \           # 同步时间
-w /home/halo2world \                        # 设置进入docker后的工作路径
--rm \                                       # 退出docker后移除镜像
guangaltman/halo-dev:ubuntu1804
xhost -

```
进入docker脚本
```bash
#!/bin/bash
docker exec -it -u halo2world -e LANG=C.UTF-8 halo-dev /bin/bash
```