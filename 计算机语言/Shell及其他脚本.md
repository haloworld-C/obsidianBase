### bash
#### basic concept
- bash中没被识别为变量的均为字符串
- C style 风格
#### syntax
0. 打印
```
#!/bin/bash #指定默认bash
echo "hello"
```
1. 变量
类似环境变量的概念:
```bash
var=123
```
- 特殊变量
```bash
$! # 当前进程pid序号
$0 # 当前脚本名称
$1,$2... # 第i个变量
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
- `while` 循环
- `for`循环
```bash
for (( ; ; )) # 无限循环
do
	echo "try to get run_id of roscore ..." >> ${LOG_DIR}/roscore.log
	if [[ $ret != "ERROR" ]]; then
		break
	fi
done
```
6. 判断

|命令行名称|说明j|
|---|---|
|-e filename| 如果 filename存在，则为真|  
|-d filename| 如果 filename为目录，则为真 |
|-f filename| 如果 filename为常规文件，则为真 
|-L filename| 如果 filename为符号链接，则为真| 
|-r filename| 如果 filename可读，则为真|
|-w filename| 如果 filename可写，则为真| 
|-x filename| 如果 filename可执行，则为真| 
|-s filename| 如果文件长度不为0，则为真| 
|-h filename| 如果文件是软链接，则为真|
|-eq | 判断相等|
|-le | 判断是否小于|
|-ge | 判断是否大于|
- 判断变量是否有值
```bash
myVar="foo"
echo $myVar
if [ -n "$myVar"]; then
	echo "yes"
else
	echo "no"
fi
```
- 判断文件是否存在
```bash
filename=example.txt
if [ ! -e ${filename} ]; then
	touch  ${filenname}
fi

```
- 判断目录是否存在
```bash
if [ ! -d ${LOG_DIR} ]; then
	mkdir -p ${LOG_DIR}
fi
```


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