[ref1: Practical Search Techniques in Path Planning for Autonomous Driving]([Practical Search Techniques in Path Planning for Autonomous Driving](https://ai.stanford.edu/%7Eddolgov/papers/dolgov_gpp_stair08.pdf))
[ref2: Path Planning in Unstructured Environments: A Real-time Hybrid A* Implementation for Fast and Deterministic Path Generation for the KTH Research Concept Vehicle](http://www.diva-portal.org/smash/get/diva2:1057261/FULLTEXT01.pdf)


参考实现:
1. apollo- open space planner
2. https://github.com/karlkurzer/path_planner
### Core Concept
1. 应用Dubins曲线或者RS曲线进行运动空间($x$, $y$, $\theta$)采样的方式， 保证满足动力学约束
2. 采用了A\*的搜索技巧，离散空间搜索(其中向后的采样并不是每次都会计算没N个节点采样一次， 并且N随这距离障碍物越近越小)
3. 前端采用Dubins扩展节点的方式进行A\*搜索， 后端采用CG优化的方式(障碍物梯度信息使用Voronoi势场提供)保证路径平滑(航向角没有跳变)及原理障碍物(原始论文采用的是zig-zag梯度下降的方式)

### 算法框架
#### Dubins曲线及RS曲线采样
Dubins曲线以运动学进行采样， 是考虑运动约束的

#### A\*搜索代价函数
扩展的方式为采样， 采样的过程也进行障碍物判断的剪枝
$J=G+H_1+H_2$, 
其中$H_1$为不考虑障碍物的到懂点的最短运动距离(Rubin曲线意义下)和欧式距离的较小值（可离线提前计算）
其中$H_2$为考虑障碍物忽略运动特性的最短距离(利用d*， A\*等算法)
G在论文中没有提， 根据A\*算法， 可以选择为走过的距离

#### Vorrino图

#### 优化平滑
#### CG优化(共轭梯度优化)

#### 非线性优化(非参数插值优化,仍使用CG方法)



#### 算法伪码

### 算法实现细节

#### 问题
1. 在A\*搜索阶段已经进行障碍物避障判断\考虑
2. 如果运动的对象是卡车， 以卡车的拖挂作为运动主体是否效果更好