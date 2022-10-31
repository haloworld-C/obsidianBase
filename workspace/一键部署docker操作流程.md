1. 拉取release版本镜像
```bash
docker pull harbor.qomolo.com/welldriver/welldriver:release_3060_3.7.11
```
2. 使用into_docker.sh进入容器（将待测试的包放入脚本同级目录），其他包用roslaunch可以运行release版本的包，运行：
```bash
sudo su # 密码为1,由于install 需要将编译结果和配置文件拷贝到/opt/ros/melodic/share/<package>文件夹下，故需要root权限
rm -rf build/ #如果有之前编译的结果，则应该先清理一下
catkin_make -DCMAKE_INSTALL_PREFIX=/opt/ros/melodic install --only-pkg-with-deps mpc_controller pid_controller
```
