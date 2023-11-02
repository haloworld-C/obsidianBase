### bash
#### syntax
0. 打印
```
echo "hello"
```
1. 变量
类似环境变量的概念:
```bash
var=123
```


2. 数组

3. 运算符

4. 函数
```bash
function check() { # 函数声明
	local ip=123 # 本地变量
	echo "$1" # 打印第一个参数
	echo "this is a function"
}
check 12 #函数调用，可以带参数
```

5. 流程控制语句
- 退出
```bash
exit 0 # 退出当前执行脚本，并返回一个状态
# 判断上个执行脚本的状态
EXCODE=$?
if [ "$EXCODE" != "0" ]; then
    echo "exit"
    exit 1
fi
```
- `if-else-then`语句
```bash
if [ "$ip_prefix" = "$target_prefix" ]; then # 注意空格
    echo "ready to push install.."
else
    echo "please check you connected to robot wifi!"
fi
```
- `while`


#### 注意事项
1. 设置默认shell
```bash
#!/bin/bash
```


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