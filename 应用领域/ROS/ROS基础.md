### concepts
- ROS中四种通信机制:
	1. message消息广播机制(单工)
	2. service服务器-客户端(请求-响应)机制(双工，同步)
	3. action服务(请求-响应-回调)机制(双工，异步)
	4. 参数服务器(适用用变动不频繁的参数)
 
### comunication
#### message
message类似广播模式
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

#### service
Services are just synchronous remote procedure calls; they allow one node to call a function that executes in another nodwe
A ROS service is a special kind of topic that allows for two-way communication between nodes. (Specifically, request-response communication.)
通信可以是一对多，也可以是多对多
![ros service](ros_service.png)
#### ros spin
- 写脚本的时候遇到一个问题，在while循环中调用了rospy.spin导致while内的语句只能被执行一次:
	出现这个问题的原因是执行spin后ros中线程管理会只处理callback的线程， 而主线程则只检测rospy是否被关闭了。
