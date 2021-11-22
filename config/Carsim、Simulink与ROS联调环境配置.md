### 目的
由于目前对无人驾驶的运动控制算法的验证在实车上进行比较繁琐与危险，成本较高。故考虑在carsim的车辆仿真平台上进行验证，这个平台里面的车辆模型包含动力学模型，经过了很多年的沉淀，可以比较反映真车的特性, 使用Carsim的缺点在于只能修改参数适配，其他部分是黑盒。使用Simulink有两个好处：一是Simulink中包含了ROS模块，可以利用ROS模块与Linux主机通信，而一般目前的自动驾驶算法与仿真基本上都在Linux平台上（架构也基本上是基于ROS），而是simulink可以进行快速的算法验证，先验证可行性再进行代码开发工作。
### 参考源
本文总结了一下配置carsim与simulink联调环境的过程，网上有一部分资料可以参考。不过或多或少还有没有说清楚的地方。我主要参考的是这两个来源：
1. [# ROS、Simulink、Carsim的互联与规划、控制算法的验证](https://zhuanlan.zhihu.com/p/62024133)
2.  [# 无人驾驶——Ros_simulink_carsim三者联合仿真](https://blog.csdn.net/qq_33125039/article/details/89791015)
### 配置过程
Carsim采用2016版本，simulink使用2019版本，ROS2。（不过carsim2019与simulink2019似乎不太匹配，在安装这个组合时出了各种问题，可能是破解版本的原因）后来切换到Trucksim2019与simulink2019a也可以配置成功。
1. 安装
- Linux 上ROS安装请参考官方[wiki](http://wiki.ros.org/noetic/Installation/Ubuntu)。
- Carsim与Simulink的安装由于版权问题，请自行搜索。
2. 设置Carsim(trucksim)
3. 设置Simulink的ROS模块
- 需要注意的是：尽管linux平台上安装的ros2版本，但是在Simulink中仍然要选择ros模块（而不是ROS2模块），才能正常进行通信
4. 设置ROS的主机IP地址及通信模块编写
5. 联合调试测试