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
#### carsim主面板
- 首先应该熟悉一下carsim打开后的主面板，如图。![图1](carsim1.png)
其中序号一在菜单栏中。关于carsim的详细文件教程可以在“Help”下面找到。网上的资料多为入门级别，如果需要深入细节的设置，需要在此查看相关文档，或在“Search help”中查找关键字，我常用这个功能来查找相关设定。
- 区域2为车辆模型的设定，一般我们选取车型即可。
- 区域3为相关运行环境设定（包括道路信息，运行时长，选取不同的控制器等对车辆本体而言的外部环境）
- 区域4为仿真运行设置区域，可以直接运行区域2、3设定好的数学模型，也可以设定为将模型与其他如Simulink或Labveiw或python等外部程序进行联合仿真
- 区域5为查看后处理的仿真结果的展示，可以查看生成的运行视频及对应帧的相关数据
#### 关键概念
上述区域中的选项均与一系列的设定相关联，原始数据集我们尽量不该，每次要更改设定都应执行“copy and link”操作。dataset为第一步要操作的，选取预设的数据集。以次为例，先选择“Simulink and LabVIEW”中对应的simulink的任意一个数据集。如图![图2](carsim2.png)
然后点击菜单栏下面的“Duplicate”图标。
#### 设定procedure区域

#### 设定模型运行区域

4. 设置Simulink的ROS模块
- 需要注意的是：尽管linux平台上安装的ros2版本，但是在Simulink中仍然要选择ros模块（而不是ROS2模块），才能正常进行通信
5. 设置ROS的主机IP地址及通信模块编写
6. 联合调试测试
7. 安装及测试的总结见下面链接
[Carsim多版本安装自动识别之前的lisense](Carsim多版本安装自动识别之前的lisense.md)
[Carsim](Carsim.md)

#### 配置参数
ip(通过交换机手工配置)
主机：192.168.10.101  netmask:255.255.255.0 gateway:192.168.10.100
客户机：192.168.10.102