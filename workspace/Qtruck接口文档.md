## general module interfaces document

|message name | message type | source module | des module  |description |
|:------------|:-------------|:--------------|:------------|:-----------|  
|/task\_info  | TaskInfo.msg | FMS           | Plan        |routing destination and other info|
|/stop\_dis   | std\_msgs::Float32 | FMS     | Plan        |轮胎吊上的激光雷达偏移量，用以调整停止位置| 
|/rain\_mode  | std\_msgs::Int8 | FMS        | Plan        |2: 有雨; 有雨的话会将最大限制速度更新到3m/s|
|/speed\_limit| Qomolo\_msgs::SpeedLimit| plan， FMS|Control, Plan       | 限制最大速度|
|/nopass\_area| Qomolo\_msgs::RectArray | FMS| Plan          | 不可通行区域信息，将会触发重新规划路径|
|/filtered\_pointcloud| sensor\_msgs::PointCloud2 | Perception| Plan     |????|
|/vehicle\_param   | std\_msgs::String | Plan     | Control  |车辆几何参数|
|/map\_path   | std\_msgs::String | Plan     | Control  |地图所在文件路径|
|/trajectory   | Qomolo\_msgs::Trajectory | Plan     | Control  |规划信息，目前是全局局路径点信息，可以优化为局部路径点|
|/vehicle\_info   | Qomolo\_msgs::VehicleState | Simulator, CANBUS     | Control  |用于仿真环境新增|
|/control\_info   | Qomolo\_msgs::ControlInfo | Control    | Simulator, CANBUS  |车辆当前时刻执行的控制指令|
|/fusion\_odom   | nav\_msgs::Odometry | Perception, Simulator     | Control  |融合定位信息|
|/trailer\_angle   | Qomolo\_msgs::TrailerAngle | Simulator, ?     | Control  |车辆几何参数|
|/rtgc   |  |      | Plan  |    |