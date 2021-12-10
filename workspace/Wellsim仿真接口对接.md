### 项目编译
0. 进入docker
- 用/well_driver/script/start_docker_local.sh启动docker
- 用/welldriver/script/into_docker 进入之前运行的容器
2. source
```bash
source /opt/ros/melodic/setup.bash
```
2. 编译
首次编译时应先编译一下qomolo_msgs
```bash
catkin_make --only-pkg-with-deps <qomolo_msgs> #和赛激光模块也需要重新编译
source /devel/setup.bash # 编译完成后需要更新lib关联地址
```
然后，删掉build文件夹后，再次编译和赛激光的包
```bash
catkin_make --only-pkg-with-deps <hesai_lidar>
```
然后删掉build文件夹后，运行
```bash
catkin_make
```
3. 运行
每次进入docker应运行
```bash
source /devel/setup.bash
```
然后依次运行模块节点-monitor-rivz节点
```bash
roslaunch monitor monitor.launch # 首先启动monitor节点，其他所有节点都会等待该节点
roslaunch routing routing_abuzhabi_qtruck11.launch #启动规划节点
roslaunch rviz_panel rviz_panel.launch  # 启动rviz可视化节点
```

### 代码结构梳理
![well_driver_routing_arch](well_driver_routing_arch.png)

### 需求
1. 支持急停
2. 同时支持六台车辆的路径规划，多车的交互由FMS考虑
3. 支持消息转发