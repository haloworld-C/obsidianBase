## 关键概念
catkin为ROS的包管理工具，本质上是一个目录系统，是一种松散的组织结构。
ROS基于TCP/IP网络进行节点之间的通信，实现松散的耦合结构。
### ROS中提供4种通信方式：
1. 发布/订阅模式（异步通信）
2. 服务注册模式（同步通信）
3. 参数服务器（多个node共享不经常变动的参数）
4. nodelet共享内存方式（可以在一定程度上保证实时性）
	- nodelet允许将不同的node加载到同一个进程，从而实现不同的节点通过共享内存的形式进行publish与subscribe
	- 但是缺点是位于同一个进程nodelet如果有一个挂掉了， 那么其他也会挂掉
###  通信机制
ROS中默认callback默认是线程安全的
## 常用命令

| command | discription | comment|
|------|----------|---------|
|rosnode list | 列出所有启动节点|
| rosrun [nodename]| 启动包节点|
|rosnode kill [node name] | 杀死特定节点|
| roscore| 启动ROS| 
| roscd | 切换到对应包的目录当中|
| rqt_plot | 画图模块| 可画单维变量随时间的变化|
| rosparam| 在param sever上设置参数数据| set, get|
| rqt_graph | 查看包图视图|也可通过rosrun rqt_graph rqt_graph运行
| catkin_create_pkg [your package name] [dependency package names] | 新建ros包 | dependency为该包的依赖
| rqt_console | 查看正在运行的ros_info（）发出的消息
| rosnode kill --all | 关闭所有节点
| rosbag record /<msg_name>|录入消息数据|
| rosbag filter old.bag new.bag "topic == '/topic_name1' and topic == '/topic_name2'"|过滤bag中的某些消息|""中的逻辑表达式与python兼容|
| catkin_make --only-pkg-with-deps [package name]|编译单个包及其依赖|
| rosclean|rosclean check &&rosclean purge|清楚历史日志（当出现日志内存过大时）|
| rosdep|rosdep [package_name]|安装某个包的依赖|
| rosrun rqt_reconfigure rqt_reconfigure|动态参数配置工具|
| rosrun rqt_tf_tree rqt_tf_tree|查看`tf`树|查看两个frame之间的转换`rosrun tf tf_echo base_link target_frame`|
| nh_handle("/app")|设置相对命名空间|如果不加`/`则为相对命名|
| rosservice list|列出所有的服务|`rosservice info /your_service_name`列出具体的service|

## 网络中的IP设置
1. 单机 
如果仅在本地跑则在~/.bashrc中添加如下命令
```bash
export ROS_HOSTNAME=localhost
export ROS_MASTER_URI=http://localhost:11311
```
修改完成后记得source一下。
2. 多台机器在网络中的设置
如果多台机器在同一个网络中，则按照本地网络中的地址即可。如果多台机器不再同一网络中，则ROS官方推荐使用openvpn这个工具进行网络配置（待研究）。
在作为服务器的机器上作如下设置
```bash
export ROS_HOSTNAME=[XXX.XXX.XXX.XXX](your ip address)
esport ROS_MASTER_URI=http://[XXX.XXX.XXX.XXX]
```

## workflow
### ROS包管理
- 安装ROS以后，应该首先设置环境（以便命令行能够识别ROS命令）
```bash
$ source /opt/ros/<distro>/setup.bash
```
- 每次进入命令行时，需要执行下面操作。以便ROS可以识别我们自己编译的包。或者将其写入~/.bashrc中。
```bash
$ source devel/setup.bash # devel为在我们的catkin_ws根目录中
```
- rosdepc解决各种安装依赖
```bash
sudo pip install rosdepc
sudo rosdepc init
sudo rosdepc update
```
检查依赖:
```bash
rosdepc check --from-path [package path]
```
安装依赖:
```bash
rosdepc install --from-path [package path]
```
对整个工作空间进行依赖检查与安装:
```bash
rosdep check --from-path src --ignore-src -r -y
rosdep install --from-path src --ignore-src -r -y
```
创建包
```bash
catkin_create_pkg [your package name] [dependency package names]
```
适用其他包编译到库
1. 待使用的包
``` CMakeLists.txt
catkin_package(
    INCLUDE_DIRS include
    LIBRARIES [export_lib] # 导出该库到配置文件
    CATKIN_DEPENDS common_srvs common_msgs geometry_msgs roscpp sensor_msgs std_msgs std_srvs tf
)
add_library(${PROJECT_NAME}_utils src/common_utils.cpp)
```
2. 适用该包到包
配置package.xml
``` package.xml
<build_depend>common_libs_utils</build_depend>
<build_export_depend>common_libs_utils</build_export_depend>
<exec_depend>common_libs_utils</exec_depend>
```
`CMakeList`配置
```CMakeListx.txt
find_package(catkin REQUIRED
	COMPONENTS
		common_libs # 使用库所在的包
)

catkin_package(
INCLUDE_DIRS include
CATKIN_DEPENDS geometry_msgs nav_msgs roscpp rospy sensor_msgs std_msgs [use_lib] # 包含要使用的包
)
include_directories(
  include
  ${catkin_INCLUDE_DIRS} #包含其他包到头文件路径
)
add_executable(${PROJECT_NAME} src/active_safety_node.cpp)
target_link_libraries(${PROJECT_NAME} glog
                                    ${catkin_LIBRARIES}) #链接包库
```


## 常用模块
### rviz ROS
可视化工具，可以进行3D显示
### pluginlib
将类编译为插件，可以在其他程序中直接使用，从而降低包之间的依赖。尤其是在编译阶段，链接是在运行时才有关联。
换句话说这些plugin可以自由组合
### nodelet
可以将多个节点（nodelet）跑在同一个进程中(nodelet manager)，这些节点使用共享内存实现节点间的通讯，共享内存机制允许节点之间进行0拷贝的方式共享数据.
- nodelet的实现是基于pluginlib的，nodelet类通过pluginlib的类注册机制发布，实现使用时加载。
#### nodelet work flow
1. 编写nodelet 节点类，该类应该继承nodelet class。在类结束后应使用宏将该类导出（以便可以被外界发现）。demo如下。
```C++
//nodelet class declaration
-------------------------------------------------
# ifndef _PLANNER_
# define _PLANNER_
   
# include <pluginlib/class_list_macros.h>//for pluginlib
# include <nodelet/nodelet.h>//for nodelet
# include <ros/ros.h>
# include <std_msgs/Float64.h>
# include <geometry_msgs/Pose2D.h>
# include <thread>
namespace autoCar{
namespace plan{
     class Planner : public nodelet::Nodelet{
         public:
		 Planner():startFlag_(false){};
         ~Planner(){};//do nothing
         virtual void onInit();
         private:
         void plannerThread();
         void flagCallback(const geometry_msgs::Pose2D::ConstPtr& msg);
         private:
         std::thread thread_;
         bool startFlag_;
         ros::Publisher pub;
         ros::Subscriber sub;
     };//end of class planner
 }//end of namespace controll
 }//end of autoCar
 # endif 
 //nodelet class implemention
 -------------------------------------------------------------
 # include <auto_car/planner.h>                                                                       
# include <math.h>
//This version intend to generate a sine shape velocity file
// modified as nodelet at 20211201
namespace autoCar{
namespace plan{
    void Planner::onInit(){
         ros::NodeHandle& private_nh = getPrivateNodeHandle();
         NODELET_DEBUG("Initialized the Nodelet");
         pub = private_nh.advertise<std_msgs::Float64>("trajtory", 1);
         sub = private_nh.subscribe("simulink_pose", 1 , &Planner::flagCallback, this);
         thread_ = std::thread(std::bind(&Planner::plannerThread, this));//开启一个线程，在线程中运行>    主要的逻辑代码
     }
     void Planner::plannerThread(){
         //TODO: 是否加入线程锁
         ros::Rate loop_rate(1);
         int counter = 0;
         std_msgs::Float64 msg;//message to send
         while(ros::ok()){
             //msg.data = 5 * sin(counter * M_PI / 500) + 10;
             msg.data = 10;
             if(counter == 1000) counter = 0;
             pub.publish(msg);
             ROS_INFO("planner published target speed in thread: %f", msg.data);
             ros::spinOnce();
             loop_rate.sleep();
         }
}
     void Planner::flagCallback(const geometry_msgs::Pose2D::ConstPtr& msg){
         startFlag_ = true;
     }
     
}//end of namespace autoCar::controll
}//end of namespace autoCar
PLUGINLIB_EXPORT_CLASS(autoCar::plan::Planner,nodelet::Nodelet);//声明插件的宏[类， 基类]  
```
3. 添加plugin.xml配置文件
为了编译而进行配置，该配置主要是为了将nodelet做成插件(具体教程参见ROS wiki中的libplugin组建说明[pluginlib](ROS.md#pluginlib))，样例：
```nodelet_plugin.XML
<!-- libnodelet_auto_car为装载plugin的库文件，将来会被编译为.so文件-->
<!-- .so文件与plugin.xml文件配合即可识别步骤2中导出的类-->
<!-- 注意：最终是一个nodelet class 被编译为一个plugin，并集成在.so文件当中-->
<library path="libnodelet_auto_car">                                   
     <class name="nodelet_auto_car/Planner" 
	        type="autoCar::plan::Planner" 
			base_class_type="nodelet::Nodelet">
         <description>
         A planner nodelet to publish trajtory message
         </description>
     </class>
</library>
```
4. 然后配置CMakelists.txt文件
在包的CMakelists.txt文末加入以下内容。
```CMakelists
# add nodelet plugin
add_library(nodelet_auto_car #指定编译的lib名，这里的名字可以任意指定
    src/plannerNodelet.cpp
    )
target_link_libraries(nodelet_auto_car 
    ${catkin_LIBRARIES}
    )             
```
5.最后配置包package.xml中的依赖,添加以下内容
```package.XML
<!-- nodelet_auto_car为决定的插件的名字，应与步骤4中的lib名一致-->
	<build_depend>nodelet_auto_car</build_depend>
	<build_depend>nodelet</build_depend>
	<exec_depend>nodelet_auto_car</exec_depend>
	<exec_depend>nodelet</exec_depend>
    <export>
    <!-- Other tools can request additional information be placed here -->  
	<!--根据plugin.xml将编译好的.lib文件装载到.so文件当中-->
		<nodelet plugin="${prefix}/planner_nodelet_plugin.xml"/>
    </export>
```

6. 最后依次启动roscore->nodelet manager->nodelet节点。
具体命令可参考以下命令行参考。后续可以将nodelet像node一样写到.launch 文件中进行统一启动。官方示例如下。
```launch
<launch>
  <node pkg="nodelet" type="nodelet" name="standalone_nodelet"  args="manager"/>
  <node pkg="nodelet" type="nodelet" name="Plus"
        args="load nodelet_tutorial_math/Plus standalone_nodelet">
    <remap from="/Plus/out" to="remapped_output"/>
  </node>
  <rosparam param="Plus2" file="$(find nodelet_tutorial_math)/plus_default.yaml"/>
  <node pkg="nodelet" type="nodelet" name="Plus2" args="load nodelet_tutorial_math/Plus standalone_nodelet">
    <rosparam file="$(find nodelet_tutorial_math)/plus_default.yaml"/>
  </node>
  <node pkg="nodelet" type="nodelet" name="Plus3" args="standalone nodelet_tutorial_math/Plus">
    <param name="value" type="double" value="2.5"/>
    <remap from="Plus3/in" to="Plus2/out"/>
  </node>
</launch>
```
7. 如果使用多个nodelet加入同一个nodelet manager则应注意
- 使用一在同一个nodelet manager中的nodelet中的消息会自动将节点名称信息加入到消息当中，例如：/cmd 将会变成/control/cmd(假定control为发出/cmd的nodelet节点名称)。需要在launch文件的节点内部加入如下信息：
```lanuch
<remap from="/control/cmd" to="cmd" />
```
- 尽管将多个nodelet模块(线程)加入同一个nodelet manager(进程)中，但是这并不以为着他们之间收发的消息便是通过共享内存进行通讯的。通过ROS官方教程，我们需要发出一个share_ptr类型的消息才能实现内存共享通讯。
> [进一步资料参考](http://wiki.ros.org/nodelet)
#### nodelet 常用命令

| command | discription | comment|
|------|----------|---------|
| rosrun nodelet nodelet manager name:=nodelet_manager_auto_car | 运行nodelet manager管理节点 | 运行nodelet manager之前应先运行roscor|
| rosrun nodelet nodelet load [编译好的.so插件]/[.so文件内的插件]  name:=nodelet1| 启动编译好节点，这个动作也可以在运行时决定启动

- a nodelet class is a node
## 问题
1. 不同的publisher能否发布同名主题？（应该不可以）
2. 如果运行nodelet 出现以下报错(其他步骤均正确的情况下)
```bug
with base class type nodelet::Nodelet does not exist
```
则一般是nodemanage的命令行在编译包后没有source.

### C++范例
1.  subscriber-publisher
```C++
PID-CONTROLLER
#include "ros/ros.h"
#include "std_msgs/String.h"
#include "std_msgs/Float64.h"
#include <lanelet2_core/primitives/Lanelet.h>
#include <sstream>
#include "../include/auto_car/controllers.hpp"
/* only if get a veclocity then output the pid cmd
*/
//回调函数
void pidCallback(const std_msgs::Float64::ConstPtr& msg, PIDcontroller* pid){
float currentV = msg->data;
pid->PIDCaculator(3, currentV);

}

/**
* This tutorial demonstrates simple sending of messages over the ROS system.
*/

int main(int argc, char **argv)
{

	ros::init(argc, argv, "controller_pid");
	ros::NodeHandle n;
	ros::Publisher cmd_pub = n.advertise<std_msgs::Float64>("cmd", 1000);
//初始化控制器
	PIDcontroller pid(0, 0.0, 3, 0.1, 0);
	ros::Subscriber sub = n.subscribe<std_msgs::Float64>("car_info", 1000, bind(pidCallback, _1, &pid));
	ros::Rate loop_rate(10);
	while (ros::ok())
	{

    std_msgs::Float64 msgSend;
	msgSend.data = pid.getLastOutput();// msg.data = ss.str();
	cmd_pub.publish(msgSend);
	ROS_INFO("current cmd is:%s", std::to_string(msgSend.data).data());
	ros::spinOnce();
	loop_rate.sleep();
	}

	return 0;

}

//车辆模型
#include "ros/ros.h"
#include "std_msgs/Float64.h"
#include "../include/auto_car/controllers.hpp"

void chatterCallback(const std_msgs::Float64::ConstPtr& msg, Car_halo* car, ros::Publisher* pub)
{
	//更新车辆位置信息
	std_msgs::Float64 msgSend;
	car->update(msg->data);
	msgSend.data = car->getVelocity();
	pub->publish(msgSend);
	ROS_INFO("currentSpeed is: [%f]", msgSend.data);
}
int main(int argc, char **argv)
{
	ros::init(argc, argv, "listener");
	ros::NodeHandle n;
	Car_halo car;
	car.setDt(0.1); //通信频率为10HZ

	ros::Publisher pub = n.advertise<std_msgs::Float64>("car_info", 1000);
	ros::Subscriber sub = n.subscribe<std_msgs::Float64>("cmd", 1000, boost::bind(chatterCallback, _1, &car, &pub));
	ros::spin();
	return 0;
}
```
2. 获取`ROS`包内的文件夹目录
```cpp
#include<ros/package.h>
bash_dir_ = ros::package::getPath("scripts") + "/script/";
```
### rospy范例
#### 获取系统时间
```Python
import rospy
start = rospy.Time.now()
#do something ...
end = rospy.Time.now()
timeGap = (end - start).to_sec()
```

### tips
- publisher设置latch=True，可以保存最后一次消息，知道有receiver接收到了才会消失。
### ROS中在callback函数中处理主程序中数据的三种方式
1. 在主程序外声明全局变量
2. 在subscribe函数中利用bind机制传入该变量的指针
``` C++
ros::Subscriber sub_chasis = n.subscribe<geometry_msgs::Pose2D>("simulink_pose", 1, bind(pidCallback, _1, &pid, &cmd_pub));//其中simulick_pose为消息名称，1为缓存大小，bind函数通过绑定机制按照地址传入额外变量pid,cmd_pub,其中的_1参数为占位符号，表示pidCallback回调函数本身的参数

```
3. 编写ROS类进行接节点注册与操作，从而可以在类的内部进行数据共享。示例如下：
```C++
ros::NodeHandle nh_private("~") // ~代表当前命名空间
nh_private.getParam("parameters/dt", p_dt);
nh_private.param<double>("parameters/dt", p_dt); // 两种方式均可

```

### 配置文件的读取
#### 参数的设置
参考
```launch
<launch>
    <!-- topic -->
	<arg name="odom_topic" default="odom"/>
	<arg name="trajectory_topic" default="trajectory"/>
    <!-- load config mpc parameters-->

    <!-- start controller -->
    <node name="controller_mpc_robot" pkg="mpc_controller_robot" type="controller_mpc_robot" output="screen">
        <param name="odom" value="$(arg odom_topic)" />
        <param name="trajectory" value="$(arg trajectory_topic)" />
        <rosparam file="$(find mpc_controller_robot)/param/mpc_controller_params.yaml" command="load" />
    </node>
</launch>
```
> 其中param参数名称如果以"/"开头的话，其名称空间是全局的

```yaml
parameters:
    dt: 0.112
    pred_horizon: 10
    control_horizon: 5
weights:
    position: 1.0
    position_terminal: 2.0
    angle: 1.0
    angle_terminal: 2.0
    velocity: 0.1
    velocity_terminal: 0.0
    omega: 0.01
    accel: 0.1
    alpha: 0.0 # acceleration of omega
    jerk: 0.0 # acceleration of accel
constraints:
    max_accel: 2.0
    min_accel: -2.0
    max_omega: 1.0
    max_alpha: 0.1
    max_jerk: 10.0
```
#### 使用NodeHandle句柄读取
```C++
ros::NodeHandle nh_private("~") // ~代表当前参数命名空间
nh_private.getParam("parameters/dt", p_dt);
nh_private.param<double>("parameters/dt", p_dt); // 这两种读取方式等价,第二种更加灵活
private_nh.param("pid_param/speed/kp", speedKp, 2.4);// 提供默认参数， 更加安全
```
> `param`函数对`launch`文件中形成的`nested`参数列表进行解析，优点是易于配置，缺点是配置参数的读取较为繁琐(尤其是很多变量的时候)
####  使用map结构一次性读取
- `yaml-cpp`
参见[[yaml-cpp]]

#### 使用Dynamic Reconfigure进行读取
> 这种方式非常适合与动态调参的场景
> [tutorial](http://wiki.ros.org/dynamic_reconfigure/Tutorials)

### Q&S
1. 清理编译后应该进行source 操作以便识别路径
2. rosbag .active的处理
```bash
rosbag reindex xxx.bag.active  
rosbag fix xxx.bag.active result.bag
rm *.active
```
3. docker 中安装ROS报`GPG error: http://snapshots.ros.org`
原因是公共key已过期，需要手动删除镜像自带的源:
```dockerfile
FROM ros:melodic-ros-base-bionic
RUN rm /etc/apt/sources.list.d/*
```
4. rviz没有加载默认的配置文件
拷贝默认`default.rviz`文件到`/opt/ros/${ROS_DISTRO}/share/rviz`



### 有用的包
- plotjuggler, 用来代替rqtplot和rqtbag的绘图工具
```bash
sudo apt-get -y install qtbase5-dev libqt5svg5-dev qtdeclarative5-dev qtmultimedia5-dev libqt5multimedia5-plugins #安装依赖
sudo apt-get install ros-<version>-plotjuggler # 安装plotjuggler
sudo apt-get install ros-<version>-plotjuggler-ros # 安装rosbag 支持
```
运行:
```bash
rosrun plotjuggler plotjuggler
```
- `ros_vis_tools`
方便的`rviz`可视化工具。

### 讨论
#### 多线程环境
1. 如果时纯粹的多消息回调的话不用加资源锁， 如果有用户自定义的线程和资源，则要加锁
2. 自定义线程的ctrl+c中断处理
```Python 
#!/usr/bin/env python
import rospy
import threading

'''
@brief: simple controller for diff-robot, output:[w, v]
'''

class TrackController():
	def __init__(self):
		self.pathLock = threading.Lock()
		self.controlThread = threading.Thread(target = self.main_thread)
		self.controlThread.start()
	def main_thread(self):
		rate = rospy.Rate(30)
		try: # 这里如果不加异常处理会raise error
			while (not rospy.is_shutdown()):
				if(self.gotOdom and self.track != None):
					self.pathLock.acquire()
					# do something
					self.pathLock.release()
					rate.sleep()
					print("loop")
		except rospy.ROSInterruptException:
			pass
if __name__ == '__main__':
	try: # 异常处理保证ctrl+c 可以被捕捉到
		rospy.init_node('simple_controller')
		tc = TrackController()
		rospy.spin() # 必须,否则捕捉不到ctrl+c异常
	except KeyboardInterrupt:
		ros.signal_shutdown('KeyboardInterrupt') # shutdown the node
```
####  tf树
1. 如果在rviz中显示局部坐标系中的点，只需要将其投影到对应坐标系中即可, tf会自己转换的