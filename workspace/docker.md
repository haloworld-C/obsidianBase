- 镜像拉取
docker pull [镜像名称]
- 镜像运行 
docker run -it [镜像名称]
- 查看正在运行的镜像
docker ps -a
- 进入某个运行中的镜像命令行
docker exec it [container ID] /bin/bash