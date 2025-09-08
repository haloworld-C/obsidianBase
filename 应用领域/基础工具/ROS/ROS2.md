### Core concept
- 相比于ROS1的改进：
	1. 增加对实时系统的支持，采用DDS作为通信中间件
	2. 去中心化Master


####  常用命令(与ROS1相同的命令见[[ROS]])

| command                          | params                      | decription  | comment                                                                                                              |
| -------------------------------- | --------------------------- | ----------- | -------------------------------------------------------------------------------------------------------------------- |
| colcon build                     | --packages-select [package] | 编译指定包       | colcon build为ROS2的编译命令行工具, 编译附加依赖colcon build --packages <name-of-pkg><br>添加Cmake参数： --cmake-args -DBUILD_TESTING=ON |
| ros2 daemon start                |                             | 启动ros2的守护进程 |                                                                                                                      |
| ros2 daemon stop                 |                             | 关闭ros2的守护进程 |                                                                                                                      |
| ros2 daemon status               |                             | 查看ros2的运行状态 |                                                                                                                      |
| ros2 pkg executables [pack name] |                             | 查看包是否已经安装   |                                                                                                                      |
| ros2 bag record -o my_bag -a     |                             | 录包          |                                                                                                                      |
