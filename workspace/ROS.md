## 关键概念
catkin为ROS的包管理工具，本质上是一个目录系统，是一种松散的组织结构。
ROS基于TCP/IP网络进行节点之间的通信，实现松散的耦合结构。ROS中提供4种通信方式：
1. 发布/订阅模式（异步通信）
2. 服务注册模式（同步通信）
3. 参数服务器（多个node共享不经常变动的参数）
4. nodelet共享内存方式（可以在一定程度上保证实时性）
## 常用命令
| command | discription | comment|
|------|----------|---------|
|rosnode list | 列出所有启动节点|
| rosrun [nodename]| 启动包节点|
| roscore| 启动ROS| 
| roscd | 切换到对应包的目录当中|
| rqt_plot | 画图模块| 可画单维变量随时间的变化|
| rosparam| 在param sever上设置参数数据| 
| rqt_graph | 查看包图视图|也可通过rosrun rqt_graph rqt_graph运行
| catkin_create_pkg [your package name] [dependency package names] | 新建ros包 | dependency为该包的依赖
| rqt_console | 查看正在运行的ros_info（）发出的消息
## 常用模块
rviz ROS的可视化工具
## ?
不同的publisher能否发布同名主题？（应该不可以）

### 范例
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