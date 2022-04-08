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
catkin_make --only-pkg-with-deps <qomolo_msgs hesai_lidar> #和赛激光模块也需要重新编译
source devel/setup.bash # 编译完成后需要更新lib关联地址
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
roslaunch mpc_controller sim_control_qtruck11.launch # 启动控制节点
roslaunch rosbridge_server rosbridge_websocket.launch # 启动rosbridge
roslaunch rviz_panel rviz_panel.launch  # 启动rviz可视化节点
```

### 代码结构梳理
![well_driver_routing_arch](well_driver_routing_arch.png)
qtruck规划控制部分接口文档详见[Qtruck接口文档](Qtruck接口文档.md)
### 多车路径测试
目前多车路径的测试是分别跑在六台笔记本上，接收FMS发过来的路径信息，然后输出路径发送给仿真环境。
六台笔记本地址为：
[qtruck11]
192.168.103.25 ansible_ssh_user=qomolo ansible_ssh_pass="123" ansible_sudo_pass="123"
[qtruck12]
10.66.12.193 ansible_ssh_user=westwell ansible_ssh_pass="xijingkeji" ansible_sudo_pass="xijingkeji"

[qtruck13]
10.66.12.192 ansible_ssh_user=westwell ansible_ssh_pass="xijingkeji" ansible_sudo_pass="xijingkeji"
[qtruck14]
10.66.12.186 ansible_ssh_user=qomolo ansible_ssh_pass="q" ansible_sudo_pass="q"
[qtruck15]
10.66.12.185 ansible_ssh_user=westwell ansible_ssh_pass="1" ansible_sudo_pass="1"
[qtruck16]
10.66.12.115 ansible_ssh_user=westwell ansible_ssh_pass="1" ansible_sudo_pass="1"
#### 多车环境测试流程：
1. ssh进入每个笔记本（代表一辆qtruck），然后启动所有模块
```bash
ssh westwell@192.168.103.25 #进入第一辆车命令行，其他依次类推
```
2. 启动本地docker
```bash
./start_docker_qtruck_simulate.sh
```
3. 启动所有模块
```bash
./start_abuzhabi_all_module_simulate.sh
```
4. 在本地安装启动多车监控面板
进入well_driver的/remote_monitor分支，然后编译项目。编译后通过脚本启动(本地docker 需要启动，但是不需要进入docker执行)。
```bash
./start_server_monitor_abuzhabi.sh
```
> 备注：当前版本只支持一个监控服务器，需要在/script/client/client_simulate.py中修改服务器地址。
#### 非多车环境（模拟6号车）
1. 编译test_noproxy分支（需要将master分支合并到本地）
```bash
git pull origin master --recurse-submodules
catkin_make
```
2. 启动本地docker
```bash
./start_docker_qtruck_simulate.sh
```
3. 启动所有模块
```bash
./start_abuzhabi_all_module_simulate.sh
```
#### 配置测试集群Ip+端口
1， 在master最新分支上新建一个modify_ip分支
2. 修改launch与code中的ip（_test.launch）与端口(task_fetcher_abzhabi 与 status_reporter_abuzhabi文件夹内，共8处端口)
3. 编译后按照上面的脚本启动节点
4. 车辆编号在start docker 的脚本中储存：PR_ID
### 需求
1. 支持急停
2. 同时支持六台车辆的路径规划，多车的交互由FMS考虑
3. 支持消息转发
### 问题记录
1、控制周期是由消息触发，是否有不稳定的问题
2、对接仿真时发现其姿态转换有问题，导致控制失稳
### 注意事项
1. 在修改地图验证路径前，需要在rviz中验证一遍是否能够规划路径

## 现场测试
！！！<不要删除well_driver主文件夹：即使要删也要先与负责人确认>
车辆IP：10.94开头（会动态变化）
用户名：qtruck 密码：123qwe
