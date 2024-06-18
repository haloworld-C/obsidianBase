### core concept
#### 主要难点
- 高维度中的运动规划
- 复杂约束下的运动规划

#### 主要流程:
- 全局参考线保证全局最优(离散搜索DP)
- 局部路径保证局部最优(连续优化QP)


#### 主要方法
##### 基于搜索
- dynamic programming(DP)
通常为基于栅格地图，比较经典的算法有A*， RRT算法等
- 缺点：生成的路径为离散点，需要平滑后才能让运动体执行
##### 基于优化
- 优点，通用性足够, 比较稳定
- path_opttimizer_2
> [github](https://github.com/LiJiangnanBit/path_optimizer_2)
- Piecewise Jerk Path Optimizer
- EM-planner
> [paper]()

优化目标函数：
$$
O = w_1 \sum_{i=1}^{N}k_i^2+ w_2 \sum_{i=1}^{N-1}k^\prime_(i)^2+ w_3 \sum_{i=1}^{N}\epsilon_{\text{safe},i}^2
$$
##### 基于采样
1. control sampling method(动作采样)
- 特点：是输出是机器可执行的动作序列, 但是有可能不满足环境约束
- DWA(The Dynamic Window Approach to Collision Avoidance)
容易陷入局部最优
DWA中考虑的代价有三项：
- 朝向终点状态
- 路径周围障碍物距离最短
- 速度尽可能大(保证到最近的障碍物距离内可以刹停)


2. state space sampling method(状态采样)
1) random sampling
		* PRM(Probabilitic RoadMap)
2) on reference lane
一定满足环境约束，但是还需要追踪生成的曲线trajectory
3) lattice planner
4) 格栅地图


##### 基于学习

##### hybrid方法
- EM planner
也叫二次规划(DP + QP)

##### 人工势场(potential field)
通常用来计算避障代价

##### Graphs of Convex Sets (GCS)
一种使用MICP(混合整数规划器)方法进行同时路径搜索和平滑无碰撞路径生成的方法， 值得学习
直接在凸空间子集上进行搜索， 很有创意， 在搜索过程中也获得了优化的边界。
> 如何申城GCS
> 可能比传统方法更加耗时