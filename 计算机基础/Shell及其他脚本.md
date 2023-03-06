### bash


### expect
#### install
```bash
sudo apt-get install expect
```
### 常用命令

|命令名称| 说明| 补充|
|:---|:---|:---|
|expect| 执行完一段命令后，通过模式匹配判断输入是否符合预期| |
|set [variable]| 设置变量 | |
|interact | 控制权移交到上层调用者 | |
|send | 向命令行发送交互指令 | 发送的命令为字符串形式，一般尾部加个\r来执行 |
|spawn | 执行 | 发送的命令为字符串形式，一般尾部加个\r来执行 |