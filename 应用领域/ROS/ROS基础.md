### concepts
- ROS中四种通信机制:
	1. message消息广播机制(单工)
	2. service服务器-客户端(请求-响应)机制(双工，同步)
	3. action服务(请求-响应-回调)机制(双工，异步)
	4. 参数服务器(适用用变动不频繁的参数)
 
### comunication
#### message
message类似广播模式(发布-订阅), 也是一种解耦的设计模式(fascad)
- 需要线定义msg格式
c++中基本使用
```cpp
#include <ros/ros.h>
ros::NodeHandle nh("~"); #声明ros资源并指定作用域
auto sub = nh.subscribe<MessageType>("topic_name", 10, std::bind(&call_back, this, _1)); //类中使用
auto sub = nh.subscribe("topic_name", 1, <callback_func>, this); // 类中使用
auto pub = nh.advertise<MessageType>("topic_name", 1);


```
python中基本使用:
```python 
#!/usr/bin/env python
import rospy
# import you message header here
sub = rospy.Subscriber("topic_name", <MessgeType>, <call_back_function>, queue_size=1)
pub = rospy.Publisher("topic_name", <MessageType>, queue_size=1)
```
#### action
![ros_action](ros_action_model.png)
action为两个节点之间的直接双向异步通信。
action主要用在需要异步执行某些操作的时候（不需要阻塞等待），进行的通信机制。client也可以取消任务。
![lanelet2_arch](ros_action_arch.png)
action的通信协议定义在.action文件中, 由goal, feedback, results构成。格式如下:
```.action
#goal definition
int32 order
---
#result definition
int32[] sequence
---
#feedback
int32[] sequence
```
##### 基本使用
1.  C++中基本使用:
- server
```cpp
#include <chores/DoDishesAction.h>  // Note: "Action" is appended
#include <actionlib/server/simple_action_server.h>

typedef actionlib::SimpleActionServer<chores::DoDishesAction> Server;

void execute(const chores::DoDishesGoalConstPtr& goal, Server* as)  // Note: "Action" is not appended to DoDishes here
{
  // Do lots of awesome groundbreaking robot stuff here
  as->setSucceeded();
	# as->setAborted()
}

int main(int argc, char** argv)
{
  ros::init(argc, argv, "do_dishes_server");
  ros::NodeHandle n;
  Server server(n, "do_dishes", boost::bind(&execute, _1, &server), false);
  server.start();
  ros::spin();
  return 0;
}
```
- client
```cpp
#include <chores/DoDishesAction.h> // Note: "Action" is appended
#include <actionlib/client/simple_action_client.h>

typedef actionlib::SimpleActionClient<chores::DoDishesAction> Client;

void GoHomeAction::doneCB(const actionlib::SimpleClientGoalState& state, 
                            const  auto_docking::DockingResultConstPtr& result) {
    if(state == actionlib::SimpleClientGoalState::SUCCEEDED) {
        switchWorkMode(GoHomeState::Success);
        LOG(INFO) << "go docker success: " << result->success;
        if(!result->success) {
            LOG(WARNING) << "something wrong with action result, you should notice this.. ";
        }
    } else {
        switchWorkMode(GoHomeState::Failed);
        LOG(INFO) << "go docker failed or aborted" << result->success;
    }
}
int main(int argc, char** argv)
{
  ros::init(argc, argv, "do_dishes_client");
  Client client("do_dishes", true); // true -> don't need ros::spin()
  client.waitForServer();
  chores::DoDishesGoal goal;
  // Fill in goal here
  client.sendGoal(goal, doneCB);
	# client.sendGoal(goal, boost::bind(&class_call_back, this, _1, _2))
  bool finished_before_timeout = client.waitForResult(ros::Duration(5.0));
  if (client.getState() == actionlib::SimpleClientGoalState::SUCCEEDED)
    printf("Yay! The dishes are now clean");
  printf("Current State: %s\n", client.getState().toString().c_str());
  return 0;
}
```
- server
```cpp
#include <chores/DoDishesAction.h>  // Note: "Action" is appended
#include <actionlib/server/simple_action_server.h>

typedef actionlib::SimpleActionServer<chores::DoDishesAction> Server;

void execute(const chores::DoDishesGoalConstPtr& goal, Server* as)  // Note: "Action" is not appended to DoDishes here
{
	// check abort or new goal
	// Do lots of awesome groundbreaking robot stuff here
	as->setSucceeded();
	# as->setAborted()
}

int main(int argc, char** argv)
{
  ros::init(argc, argv, "do_dishes_server");
  ros::NodeHandle n;
  Server server(n, "do_dishes", boost::bind(&execute, _1, &server), false);
  server.start();
  ros::spin();
  return 0;
}
```
2. python中基本使用:
- server
```python
#! /usr/bin/env python

import roslib
roslib.load_manifest('my_pkg_name')
import rospy
import actionlib

from chores.msg import DoDishesAction

class DoDishesServer:
	def __init__(self):
		self.server = actionlib.SimpleActionServer('do_dishes', DoDishesAction, self.execute, False)
		self.server.start()

	def execute(self, goal):
		if self._as.is_preempt_requested():
			rospy.loginfo('%s: Preempted' % self._action_name)
			self._as.set_preempted()
			success = False
		# Do lots of awesome groundbreaking robot stuff here
		self.server.set_succeeded()


if __name__ == '__main__':
	rospy.init_node('do_dishes_server')
	server = DoDishesServer()
	rospy.spin()
```
- client
```python
#! /usr/bin/env python

import roslib
roslib.load_manifest('my_pkg_name')
import rospy
import actionlib

from chores.msg import DoDishesAction, DoDishesGoal

if __name__ == '__main__':
    rospy.init_node('do_dishes_client')
    client = actionlib.SimpleActionClient('do_dishes', DoDishesAction)
    client.wait_for_server()

    goal = DoDishesGoal()
    # Fill in the goal here
    client.send_goal(goal)
    client.wait_for_result(rospy.Duration.from_sec(5.0))
```

#### service
Services are just synchronous remote procedure calls; they allow one node to call a function that executes in another nodwe
A ROS service is a special kind of topic that allows for two-way communication between nodes. (Specifically, request-response communication.)
通信可以是一对多，也可以是多对多
service的效果类似函数调用，由于是阻塞的方式， 被调用的服务不应该消耗过多时间
![ros service](ros_service.png)
#### ros spin
- 写脚本的时候遇到一个问题，在while循环中调用了rospy.spin导致while内的语句只能被执行一次:
	出现这个问题的原因是执行spin后ros中线程管理会只处理callback的线程， 而主线程则只检测rospy是否被关闭了。
