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
|7   |lane_id |当前路径所在lanelet id| cutin and cutout curve is special|
|8   |turn_mode|当前路径点所处路径的类型| 1: straight  2: inside  3: outside 4:cutin/cutout 5: lanechange |

### FMS_interface
- 传输格式josn
- 传输工具curl
- 接口对接：ip + 端口 + 服务
#### task_fetcher
##### task_info
-  [taiguo] web_interface: "ws://"+server_ip+"/ws_echo"
|feild | meaning | description | comments  |
|:------------|:-------------|:--------------|:------------|
|header   |消息头信息       |有用信息transID, timeStamp  |通用|
|body   |消息主体      | 包含规划信息，作业任务信息， 坐船位置信息，车辆锁定信息，遥控器信息等   |abuzhabi会发送心跳，泰国没有|
###### task_info=>header
|feild | meaning | description | comments  |
|:------------|:-------------|:--------------|:------------|
|versionID   |      |   | 
|transID   |      |   | |
|messageName   |      |   | 
|messageType   |      |   | 
|isResend   |      |   | 
|timestamp   |      |   | 
|deviceType   |      |   | 
|deviceVersion   |      |   | 
###### task_info=>body
|feild | meaning | description | comments  |
|:------------|:-------------|:--------------|:------------|
|taskID   |      |   | |
|taskType   |      |   | |
|taskOp   |      |   | |
|taskCMD  |      |   | |
|updateIndex  |      |   | |
|containerType  |      | 三种：前20， 后20， 40(尺)  | |
|destination  |      |规划终点位置信息   |  详见task_info=>body=>destination表|
|estimatedTime  |      |规划终点位置信息   |  详见task_info=>body=>destination表|
|pathGuidance   |      |   | |
|routeUpdate   |      |   | |
|referID   |      |   | |
|positionOnChassis   |      |   | |
|craneID   |      |   | |
|overtake   |  由人工视情况使用，在前方车辆行驶过慢时，切换车道以超车    | 接收到overtake，触发重新规划，强制向左或向右变道   | 只有地图道路上有lanechange tag才会生效 |
|bowLoc   |      | 船头位置信息  | |
|sternLoc   |      |船尾位置信息   | |
|bollardLoc   |      |泊位0点的位置信息   | |
|isFinalNavi   |      |   | |
|inDis   |      | 切入QC弯道距离船尾距离  | 单位m, intergal  |
|outDis   |      | 切出QC弯道距离船头距离  |单位m, intergal |
###### task_info=>body==>destination
|feild | meaning | description | comments  |
|:------------|:-------------|:--------------|:------------|
|locationID   |      |   | |
|locationType   |      |   | |
|description   |      |"FMS_TO_AT"   | |
|referPostion   |      |"FMS_TO_AT"   |详见task_info=>body=>destination=>referPosition子表 |
###### task_info=>body=>destination=>referPosition
|feild | meaning | description | comments  |
|:------------|:-------------|:--------------|:------------|
|longitude   |   终点横坐标   | x_value of destination  | 与理解的正好反了 |
|latitue   | 终点纵坐标     | y_value of destination  | |
|heading   |   航向   | 终点姿态-航向  | 单位：degree |
|elevation   | 目标位置高度信息     |   | not used yet |

#####


#### status_reporter

|dim | meaning | description | comments  |
|:------------|:-------------|:--------------|:------------|
|0   |x       |车头位置坐标x   |车头坐标原点位于车头后轴中心|



### others

| | meaning  | description | comments  |
|:------------|:-------------|:--------------|:------------|
|area_num   | 港口堆场区域      |1: unknow 2:QC(岸桥) 3:TS(锁站) 4:LWA(等待区) 5:WA(等待区) 6:Yard  | |