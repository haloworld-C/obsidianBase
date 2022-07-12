### 地图正确性检查
|lanelet ID | 检查类型  | 状态  |
|:---------|:-----------|:-----|
| 4007434  |  新增交通灯  | 忽略 | 
|          |  path_check(与防撞相关)  | 忽略 | 
|          |  check_block  | 忽略 | 
| 1966204  1966206  1966226 1966266 1966268 1966286|  right_safety_dis 0.2->0.5 |为本次更新，忽略 | 
|          |  motion_check  new | 与安全距离的修改相关?? | 
| 52450    |  reloc_allow | 新地图无该属性?? | 
|          |  tower_id   124732 | 新地图无该属性?? | 
|          |  tower_id   124732 | 新地图无该属性?? | 
| 3987738  |  left_safety_dis right   0.05->0.2| 为本次更新，忽略?? | 
| 498114  1970884 |  lanelet不存在 | 经地图中对比，发现是新地图用新的一条lanelet（6239810）代替合并的两段 | 
| 1970890 |  lanelet不存在 | 经地图中对比，发现是新地图用新的一条lanelet代替 | 
 

#### 添加cutin 及 past_time 
使车辆能够在四条道上面的service line可以切进来



#### 地图属性

|key | value  | 说明  |
|:---------|:-----------|:-----|
| path_check  |  true ; false  | 与防撞相关 | 
| check_block  |  string  | 用于判断该区域是否适用于红绿灯 | 
| motion_check  |  lanelet_id  | ? | 
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

#### 地图正确性检查
taiguo0228 -> taiguo0301,见

#### issues
1. [阿布扎比]124仿真环境AT6无法变道
![not_change_issue](not_change_line_issue.jpg)


2. [泰国]车辆跨越no pass 区域

![no_pass_issue](nopass_issue.jpg)
问题定位：在qtruck1上播放rosbag定位问题，发现no pass area区域不连续，如下图所示：

3.[泰国]AT01在G11完成任务后客户发了E10任务路径规划是从D11 bypass 绕了一圈
失效时间： 8:22

<<<<<<< HEAD
#### 现场测试
通过ssh远程车辆，车辆ip:10.94开头，会浮动。
AT05：user name:qtruck password:123qwe
```bash
ssh qtruck@10.94...
```
=======
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
>>>>>>> d65a0e91ebb733731dfb8e5c4214b4fc92a31c03
