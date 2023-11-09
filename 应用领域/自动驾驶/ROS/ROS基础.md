### concepts

### comunication
#### message
#### action
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

#### ros spin
- 写脚本的时候遇到一个问题，在while循环中调用了rospy.spin导致while内的语句只能被执行一次:
	出现这个问题的原因是执行spin后ros中线程管理会只处理callback的线程， 而主线程则只检测rospy是否被关闭了。
