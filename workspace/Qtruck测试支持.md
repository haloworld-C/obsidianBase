#### 地图属性

|key | value  | 说明  |
|:---------|:-----------|:-----|
| path_check  |  true ; false  | 与防撞相关 | 
| check_block  |  string  | 用于判断该区域是否适用于红绿灯 | 
| motion_check  |  lanelet_id  | 当遇到障碍物时的可选便道路径 | 
| reloc_allow  |  true ; false  | ? | 
| cutin  cutout | |为是否允许变道-service lane属性| 
| turn mode|反映路径的曲率信息|straight:1 inside:2 outside:3 lanechange:5|
| lanechange_block|是否允许变道区域|101869  101874 101879 101775 124856 124846 124851 124861 |
| subtype|"road","xxxx"||

> lanechange_block属性代表aera，其特征如下所示。
![lanechange_blocke](lanelet-osm-aera.png)
#### 关于属性的问题
1. lanechange_block 的值对应的元素（polygonLayer）与其位置关系不是一一对应。表征的是不允许变道的信息
2. turn mode == 4的含义
3. 短横线中的属性如何读取

#### 港口常用术语

|缩略语 | 含义  | 备注  |
|:----------|:----------|------|
|QC|岸桥：从船上取集装箱到卡车上|  |
|Block|堆场：集中堆放集装箱的地方|由轮胎吊或者轨道吊进行操作 |
|RTG|轮胎吊：从车上抓取集装箱然后码放到堆场区域|?轮胎吊的两侧的轮子横跨堆场，所在的道路称为serviceline|
|RTGC|轨道吊|与轮胎吊类似，不同的是其必须在铺设好的轨道上运行|
|Hatch cover|仓盖板|船上的设备，会暂时放在QC的道上|
|MT|人工集卡|包括E-Truck、TT、XT（内部集卡）|
|AT|自动集卡|Auto-Truck|
|TS|锁站|人工操作，分为上锁和解锁|
|overtake|超车|当前车拋锚时，需要变道超车|
|PK|park，停车区域|Qtruck无作业时停放区域|

其他补充：
标准集装箱共有三个尺寸：20尺, 40尺 45尺
目前Qtruck可支持20尺与40尺,两种规格
bay位（类似于分隔线），6米间隔，两个bay位可以放1个40尺的标准箱。
Stack：三个bay位置之间的空间(2, 6, 10stack是可作业stack)
berth ： 船的停泊位置
by pass lane : 用来只通行不作业的路 

监控界面说明如下所示：![gui](thai.jpeg)

### 贝位坐标信息
#### 泰国（贝位对应的service lane的坐标）
B11,35,-11.2148110297,303.729429185  
D11,35,6.25518897026,246.649429185  
F11,35,23.3051889703,189.609429185  
H11,35,40.272588970256,132.1741291855

上述信息是集装箱对位信息，如果想计算车辆坐标原点的位置添加如下坐标信息（根据任务不容进行选用）
##### 40inch 箱子任务
J11_TP40_OFFSET = (-2.56633 - (-7.76040096231736),  
103.26936 - 101.696893325541)  
#J11_Stack29  
##### 20inch 箱子（前箱）
J11_TPF20_OFFSET = (28.6325789582-26.1283807943109, 112.587935096-111.871445014607)  

##### 20inch 箱子（后箱）
J11_TPA20_OFFSET = (34.6209882143-26.1283807943109, 114.355918521-111.871445014607)

## 现场测试
！！！<不要删除well_driver主文件夹：即使要删也要先与负责人确认>
车辆IP：10.94开头（会动态变化）
用户名：qtruck 密码：123qwe
#### 速度限制
```bash
/bin/bash -c "source /home/westwell/welldriver/devel/setup.bash; roslaunch routing routing_abuzhabi.launch max_speed:=3"#将最大速度限制为3m/s
```