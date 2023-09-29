### 基础语法
- 断行符 \
- python中一切皆对象，赋值均为浅拷贝
- 多行注释:三个单引号

#### 列表解析

#### lambda表达式
其形式为：lambda argument_list:expersion
```python
sqrt_2 = lambda n, n*n
```
缺点是表达式只能是一条语句。
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