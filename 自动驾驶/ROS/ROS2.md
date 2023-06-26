### Core concept
- 相比于ROS1的改进：
	1. 增加对实时系统的支持，采用DDS作为通信中间件
	2. 去中心化Master


####  常用命令(与ROS1相同的命令见[[ROS]])

| command | params | decription |comment|
|------|----------|---------|-----------------|
| colcon build  | --packages-select [package] | 编译指定包 | colcon build为ROS2的编译命令行工具 |