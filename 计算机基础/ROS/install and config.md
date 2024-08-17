### install
推荐小鱼一键安装
### config

### core concept 
- ros1 中master节点只能有一个
常用命令
|命令行名称|说明||
|---|---|---|
|sudo apt install ros-melodic-tf2-geometry-msgs|安装对应的ros包| 对应好ros版本|
|rostopic hz [message_name]|查看消息频率| |
|roscd|切换不同的ros package|该包需要被编译过 |
|rospack find [pack_name]|确认ros包是否安装| |

### 问题
- 当ros源为清华源，系统源为科大源时，经常会报依赖错误（尽量保持一致）
