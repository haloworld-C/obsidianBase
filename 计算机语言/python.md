### 实用技巧
#### 不运行代码， 先检查语法
python3 -m py_compile motion_precision_benchmark.py
### 基础语法
- 断行符 \ 或将多个语句放在()内
- python中一切皆对象，赋值均为浅拷贝
- 多行注释:三个单引号
#### 数据结构
##### list
```python
a = [] #初始化
```
##### map 
```python
a = {}
for key in a: 
	# 遍历key

```
#### 列表解析

#### lambda表达式
其形式为：lambda argument_list:expersion
```python
sqrt_2 = lambda n, n*n
```
缺点是表达式只能是一条语句。
#### 类class
```python
  #! /usr/bin/env python
 import rospy
 import actionlib
 import actionlib_tutorials.msg

 class FibonacciAction(object):
    # create messages that are used to publish feedback/result
	# _feedback为类内属性， 相当与c++中的static成员函数
     _feedback = actionlib_tutorials.msg.FibonacciFeedback()
     _result = actionlib_tutorials.msg.FibonacciResult()

     def __init__(self, name):
         self._action_name = name
         self._as = actionlib.SimpleActionServer(self._action_name, actionlib_tutorials.msg.FibonacciAction, execute_cb=self.execute_cb, auto_start=False)
         self._as.start()
```
#### 内存开销
在python中
```python
x = x + y
```
的运算实际上x已经是一个新对象了， 其id已经改变(可以使用`id(x)`进行观察)
#### 异常处理
##### basic idea
- 使用try-except-finally结构处理
- 异常是基于事件机制，当前程序无法处理，抛出异常请调用者处理
##### 标准异常

|异常名称|描述|
|---|---|
|BaseException|	所有异常的基类|
|SystemExit|	解释器请求退出|
|KeyboardInterrupt|	用户中断执行(通常是输入^C)|
|Exception	|常规错误的基类|
|StopIteration	|迭代器没有更多的值|
|GeneratorExit| 生成器(generator)发生异常来通知退出|
|StandardError|	所有的内建标准异常的基类|
|ArithmeticError|	所有数值计算错误的基类|
|FloatingPointError|	浮点计算错误|
|OverflowError|	数值运算超出最大限制|
|ZeroDivisionError|	除(或取模)零 (所有数据类型)|
|AssertionError|	断言语句失败|
|AttributeError|	对象没有这个属性|
|EOFError|	没有内建输入,到达EOF 标记|
|EnvironmentError|	操作系统错误的基类|
|IOError|	输入/输出操作失败|
|OSError|	操作系统错误|
|WindowsError|	系统调用失败|
|ImportError|	导入模块/对象失败|
|LookupError|	无效数据查询的基类|
|IndexError	|序列中没有此索引(index)|
|KeyError|	映射中没有这个键|
|MemoryError|	内存溢出错误(对于Python 解释器不是致命的)|
|NameError	未声明/初始化对象 (没有属性)|
|UnboundLocalError|	访问未初始化的本地变量|
|ReferenceError	|弱引用(Weak reference)试图访问已经垃圾回收了的对象|
|RuntimeError|	一般的运行时错误|
|NotImplementedError|	尚未实现的方法|
|SyntaxError|	Python 语法错误|
|IndentationError| 缩进错误|
|TabError|	Tab 和空格混用|
|SystemError|	一般的解释器系统错误|
|TypeError|	对类型无效的操作|
|ValueError|	传入无效的参数|
|UnicodeError|	Unicode 相关的错误|
|UnicodeDecodeError|	Unicode 解码时的错误|
|UnicodeEncodeError	|Unicode 编码时错误|
|UnicodeTranslateError	|Unicode 转换时错误|
|Warning|	警告的基类|
|DeprecationWarning|	关于被弃用的特征的警告|
|FutureWarning	|关于构造将来语义会有改变的警告|
|OverflowWarning|	旧的关于自动提升为长整型(long)的警告|
|PendingDeprecationWarning|	关于特性将会被废弃的警告|
|RuntimeWarning|	可疑的运行时行为(runtime behavior)的警告|
|SyntaxWarning|	可疑的语法的警告|
|UserWarning|	用户代码生成的警告|
##### 基本用法
```python
try:
    fh = open("testfile", "w")
    fh.write("这是一个测试文件，用于测试异常!!")
except (IOError, RuntimeError):
	# 捕获多个异常
    print "Error: 没有找到文件或读取文件失败"
else:
    print "内容写入文件成功"
    fh.close()

try:
	#do something
finally:
	# 无论抛出异常都会执行
```
### 官方库
#### pyinstaller 
python脚本打包为可执行文件
### 第三方库
#### 安装方式
主要通过pip包管理工具进行安装:
- pip安装
```bash
sudo apt install python-pip
```
- 具体包安装
```bash
pip install [package name] #适用python2
pip3 install [package name] #适用python3
```
使用国内源:
- 临时使用：
```bash
pip3 install numpy -i https://pypi.tuna.tsinghua.edu.cn/simple
```
- 配置文件
```~/.pip/pip.conf
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
[install]
trusted-host = https://pypi.tuna.tsinghua.edu.cn
```
- 命令行设置
```bash
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
```

#### numpy
#####  core concept
- ndarray, 核心数据结构
- broadcasting(element by element)
- axis
- 广播(为默认模式)
##### 常用操作
```python
# 初始化矩阵
np.array([1, 2, 3, 4], dtype=int64)
np.empty([rows, cols]) #只分配内存对象，而不进行初始化，会快很多
np.zeros(rows, cols) # 分配内存对象，并将所有元素初始化为0

# 逐元素操作
np.sum(nparray) 
np.sin(nparray) 
np.cos(nparray)
np.sqrt(nparray) 
np.arctan(nparray) 
# 矩阵操作
np.linalg.norm(nparray) # 求矩阵\向量的2范数
nparray.shape[0] # 返回矩阵维度的元组，并获取行h数
np.delete(nparray, [range_min, range_max], axis = 0) #按照范围删除行

# 数据转化
nparray.tolist() # 将nparray转化为list
```
#### pandas

#### matplotlib
##### core concept

#### pybind11
##### core concept
- 可以将C++的接口暴露出来，供python 进行调用。类似的库还有Boost.python
- 也可以将python的接口暴露给C++使用
##### 注意事项
- pybind11安装的时候需要添加[global]选项，否则CMakelists.txt中的find_package找不到：
```bash
pip install "pybind11[global]"
```
#### pickle
用于python原生数据点永久存储，缺点是只能够被python读取。如果需要跨语言可以使用json格式进行存储。
##### 使用
> ref: [基于内存点二进制和python对象转化](https://zhuanlan.zhihu.com/p/544792469)
```python
import pickle

tup1 = ('hello Python', {1, 2, 3}, None)

# 使用pickle.dumps()函数将元组tup1转换成p1
p1 = pickle.dumps(tup1)
print(p1)

# 使用pickle.loads()函数将p1转化成Python对象
t2 = pickle.loads(p1)
print(t2)
```
#### pynput
- 键盘鼠标交互库
安装
```bash
pip install pynput
```
> 平替: termios(未测试)
```python
class KeyInteract
    self.keyListener = Listener(on_press = self.on_press)
    self.keyListener.start()
    self.keyListener.join()
    # keyboard interact callback
    def on_press(self, key):
        try:
            # print('key {0} pressed'.format(key.char))
            if key.char == 'q':
                self.keyListener.stop()
                rospy.signal_shutdown('KeyboardInterrupt') # shutdown the node
        except AttributeError:
            # print("Special key {0} pressed".format(key))
            pass
        if key == Key.space: # space key
            print("set task point {0}".format(len(self.taskPoints)))
            self.taskPoints.append(self.curPos.tolist())

```
##### demo
```python 
from pynput.keyboard import Key, Listener # keyboard interaction lib
keyListener = Listener(on_press = self.on_press, suppress=True)# suppress 代表全局监听
keyListener.start()
def on_press(self, key):
	try:
		print('key {0} pressed'.format(key.char))
		if key.char == 'q':
			self.isFinished = True
		except AttributeError:
			print("some thing goes wrong..")
```
##### 遇到的问题
- pip2 安装最新版本失败
解决方案: 安装低版本(这也是常用多一种安装软件包失败多解决方案)
```bash
pip install pynput==1.6.0
```
- ssh到arm 平台上无效
在本机的ssh配置文件/etc/ssh/sshd_config中去掉以下行的注释:
```/etc/ssh/sshd_config
X11Forwarding yes
X11DisplayOffset 10
X11UseLocalhost yes
```
然后登录的时候在ssh命令中加入x server选项:
```bash
ssh user@address -X
```
- ssl证书问题
使用以下证书添加特定域名的信任:
```bash
pip install --trusted-host pypi.python.org package_name
pip install --trusted-host pypi.tuna.tsinghua.edu.cn pynput==1.6.0 -i https://pypi.tuna.tsinghua.edu.cn/simple
```