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

#### /trajitory(routing points) definination
|dim | meaning | description | comments  |
|:------------|:-------------|:--------------|:------------|
|0   |x       |车头位置坐标x   |车头坐标原点位于车头后轴中心|
|1   |y       |车头位置坐标y   |车头坐标位于车头后轴中心|
|2   |speed   |规划速度       |该路径点规划速度|
|3   |yaw     |车头航向航向    |右手坐标系 |
|4   |tx      |托挂位置坐标x   |托挂坐标原点位于托挂后轴轮轴中心|
|5   |ty      |托挂位置坐标y   ||
|6   |tyaw    |托挂航向角      |右手坐标系|
|7   |lane_id |当前路径所在lanelet id| |
|8   |turn_mode|当前路径点所处路径的类型| 1: straight  2: inside  3: outside 4:cutin 5:cutout |
