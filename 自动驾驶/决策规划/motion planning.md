### core concept

#### 主要方法
##### 基于搜索
- dynamic programming(DP)
通常为基于栅格地图，比较经典的算法有A*， RRT算法等
##### 基于优化
- path_opttimizer_2
> [github](https://github.com/LiJiangnanBit/path_optimizer_2)

优化目标函数：
$$
O = w_1 \sum_{i=1}^{N}k_i^2+ w_2 \sum_{i=1}^{N-1}k^\prime_(i)^2+ w_3 \sum_{i=1}^{N}\epsilon_{\text{safe},i}^2
$$
##### 基于采样
1. control sampling method(动作采样)

好处是输出是机器可执行的动作序列, 但是有可能不满足环境约束
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


##### 基于AI

##### hybrid方法
- EM planner

##### 人工势场(potential field)
通常用来计算避障代价