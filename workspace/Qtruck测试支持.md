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
| check_block  |  string  | ? | 
| motion_check  |  lanelet_id  | ? | 
| reloc_allow  |  true ; false  | ? | 
| cutin   | |为是否允许变道属性| 

#### issues
1. [阿布扎比]124仿真环境AT6无法变道
![not_change_issue](not_change_line_issue.jpg)


2. [泰国]车辆跨越no pass 区域

![no_pass_issue](nopass_issue.jpg)