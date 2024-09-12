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
$! #当前进程pid号
"$@" #是 Bash 脚本中的一个特殊参数，它代表传递给脚本或函数的所有位置参数（命令行参数），并且将每个参数视为一个独立的引号内字符串。这意味着如果你的参数中包含空格，`"$@"` 会保持这些空格不变，确保每个参数作为独立的单元处理
# 获取特殊按键
# 定义信号处理函数
function cleanup {
  echo "接收到Ctrl+C，正在终止记录..."
  exit 1
}

# 捕获Ctrl+C信号，执行信号处理函数
trap cleanup INT
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
EXCODE=$? # 或上一个函数的返回值
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
- case分支
```bash
case $depth_camera_type in 
	dw2) 
		echo "检测到 depth_camera_type 为 dw2" 
		# 这里可以添加针对 dw2 的处理代码 
		;; 
	berxel_max) 
		echo "检测到 depth_camera_type 为 berxel_max" 
		# 这里可以添加针对 berxel_max 的处理代码 
		;; 
	dw2_max) 
		echo "检测到 depth_camera_type 为 dw2_max" 
		# 这里可以添加针对 dw2_max 的处理代码 
		;; 
	*) 
		echo "未知的 depth_camera_type: $depth_camera_type" 
		# 这里可以添加默认的处理代码 
		;; 
esac
```
- `while` 循环
- `for`循环
```bash
#!/bin/bash

# 循环n次
for ((i=1; i<=100; i++)); do
    ./common_utils_test
done


for (( ; ; )) # 无限循环
do
	echo "try to get run_id of roscore ..." >> ${LOG_DIR}/roscore.log
	if [[ $ret != "ERROR" ]]; then
		break
	fi
done
```
6. 判断

| 命令行名称 | 说明j |
| ---- | ---- |
| -e filename | 如果 filename存在，则为真 |
| -d filename | 如果 filename为目录，则为真 |
| -f filename | 如果 filename为常规文件，则为真 |
| -L filename | 如果 filename为符号链接，则为真 |
| -r filename | 如果 filename可读，则为真 |
| -w filename | 如果 filename可写，则为真 |
| -x filename | 如果 filename可执行，则为真 |
| -s filename | 如果文件长度不为0，则为真 |
| -h filename | 如果文件是软链接，则为真 |
| -eq | 判断相等 |
| -le | 判断是否小于 |
| -ge | 判断是否大于等于 |
| -gt | 判断是否大于 |
| -s | 判断文件存在且非空 |
- 判断变量是否有值
```bash
myVar="foo"
echo $myVar
if [ -n "$myVar" ]; then
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
- 获取变量的字符串长度
使用内置的`${#variable}`语法来获取变量字符串的长度:
```bash
str="Hello, World!" echo "The length of str is: ${#str}"
```
7. 其他常用操作
```bash
./script1.sh & # 执行第一个脚本，并将其放入后台执行
[cmd]  /dev/null 2>&1 # 关闭显示输出
```

#### 注意事项
1. 设置默认shell
```bash
#!/bin/bash
```
2. 在脚本中source其他脚本
3.   在Shell脚本和命令行中，反引号\`被用于命令替换。命令替换是一种机制，它执行被反引号包围的命令，并将输出替换到原位置。这允许你将命令的输出赋值给变量，或者作为另一个命令的参数。`$()`具有同样的效果，且更加易读, 易于嵌套
```
files_count=$(ls -l $(pwd) | wc -l)
# 等价于
files_count=`ls -l $(pwd) | wc -l`
```
有几个好处
- 不会新开进程，就在调用脚本进程中执行(但是退出也会一起退出)
- source后可直接使用被调用脚本的变量、函数
4. sh -c 可以将字符串解析为命令脚本并执行(但是相当于新开了个shell)
```bash
v=123
sh -c 'echo $v' # 单引号中变量并不会被展开，因为是新shell, 如果这样写需要export 123
sh -c "echo $v" # 这样写没有问题， 因为在传入sh 时变量已经展开了
```

### expect
#### install
```bash
sudo apt-get install expect
```
### 常用命令

| 命令名称           | 说明                        | 补充                      |
| :------------- | :------------------------ | :---------------------- |
| expect         | 执行完一段命令后，通过模式匹配判断输入是否符合预期 |                         |
| set [variable] | 设置变量                      |                         |
| interact       | 控制权移交到上层调用者               |                         |
| send           | 向命令行发送交互指令                | 发送的命令为字符串形式，一般尾部加个\r来执行 |
| spawn          | 执行                        | 发送的命令为字符串形式，一般尾部加个\r来执行 |
### Matlab/octave
#### 常用操作/函数速查
```mat
% 基本语法
% 按照间隔生成一维向量
h = 1 : 2 : 100; %以1为初值，每次增量为2， 直到100， 生成50个数
% for循环
for 1 : 1 : 5
%do something
end
% 特殊元素
inf; 无穷大
% 矩阵运算
% 矩阵下标从1开始
a = zeros(2, 2); %声明一个2*2的方阵
% 按索引访问数值使用括号
a(1, 1); % ans = 0, 取矩阵第一行第一列
a(1, :); % 访问第一行
a(:, 1); % 访问第一列
% 标量与矩阵的运算逐元素运算
b = a + 3; %此时矩阵为每元素均为3的方阵
c = b / 2;
d = c'; % 矩阵转置
% 对于除法， 标量除矩阵应用./, 维度相等的矩阵也用./, .*等，表示逐元素操作
d = 2 ./ b;

```

| 函数                       | 说明                                              | 补充  |
| :----------------------- | :---------------------------------------------- | :-- |
| zero(row_size, col_size) | 初始化零矩阵                                          |     |
| eye()                    | 对角阵                                             |     |
| find(`cond1` \| `cond2`) | 检查矩阵中元素是否满足条件， 并返回下标(组合)                        |     |
| sub2ind                  | 将矩阵下标转换为一维数组下标                                  |     |
| [aa, bb]= meshgrid(a, b) | 生成两个相同维度矩阵(b的行数x， a的列数y), 然后aa复制x行， bb数组转置后复制y列 |     |
