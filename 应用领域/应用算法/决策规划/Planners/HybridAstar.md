[ref1: Practical Search Techniques in Path Planning for Autonomous Driving]([Practical Search Techniques in Path Planning for Autonomous Driving](https://ai.stanford.edu/%7Eddolgov/papers/dolgov_gpp_stair08.pdf))
### Core Concept
1. 应用Dubins曲线或者RS曲线进行运动空间采样的方式， 保证满足动力学约束
2. 采用了A\*的搜索技巧，离散空间搜索
3. 前端采用Dubins扩展节点的方式进行A\*搜索， 后端采用优化的方式保证路径平滑(航向角没有跳变)及原理障碍物(原始论文采用的是zig-zag梯度下降的方式)
### 算法框架
#### Dubins曲线及RS曲线采样

#### A\*搜索代价函数
J=G+H
#### 优化平滑

#### 算法伪码

### 算法实现细节

#### 问题
1. 在A\*搜索阶段已经进行障碍物避障判断\考虑
2. 如果运动的对象是卡车， 以卡车的拖挂作为运动主体是否效果更好