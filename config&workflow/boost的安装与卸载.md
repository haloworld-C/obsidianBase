### 安装
对于初学者可以进行完全安装。安装的步骤也很简单。
1. 进入boost官网下载最新版本的源代码，然后本地解压
2. 进入解压后的顶层文件夹执行：
```bash script
sudo ./bootstrap.sh; 
sudo ./b2 install
```
> 安装后相关头文件及编译文件被拷贝到/usr/local/include和/usr/local/lib文件夹下，相应的该版本的卸载也就是把这两个文件夹下对应boost文件夹删掉就行，对应命令行如下
``` bash script
sudo rm -rf /usr/local/include/boost
sudo rm -rf /usr/local/lib/libboost*
```
3. 以上步骤已完成boost的安装，需要进入/tools/build执行相同的命令进行boost的编译工具的安装
> note: 安装后发现该版本boost与ROS相冲突，可能是ROS中已经安装了boost的缘故。
> 经过定位发现ROS中boost的安装路径为/usr/lib/x86_64-linux-gnu，而boost编译安装的版本路径在/usr/local/lib中，这两个的版本不一致则会报版本冲突的问题。（个人猜测可能是find_package(boost)与${catkin_INCLUDE_DIRS}的路径冲突导致）