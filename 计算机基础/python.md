### 基础语法

### 官方库
#### pyinstaller 
python脚本打包为可执行文件
### 第三方库
### numpy
####  core concept
- ndarray, 核心数据结构
- broadcasting(element by element)
- axis
### matplotlib
#### core concept
### paho-mqtt
#### core concept 
mqtt(MQ Telemetry Transport)是基于物联网(loT)的网络协议。
- publish/subscribe
- messages(command or data)
- topics
- broker(代理，server)
	消息管理与分发器，通过topics进行publish/subscribe的匹配(换言之，publisher 和 subcriber并不进行直接的连接，以实现发送者和接受者之间的解耦)
	broker docker: emqx/emqx
其基本的通信模型如下图所示：
![MQTT 通信模型](../../Resourse/mqtt_concept.png)
