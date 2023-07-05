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
- 广播(为默认模式)
#### 常用操作
```python
# 逐元素操作
np.sum(nparray) 
np.sin(nparray) 
np.cos(nparray)
np.sqrt(nparray) 
np.arctan(nparray) 
# 矩阵操作
np.linalg.norm(nparray) # 求矩阵\向量的2范数

# 数据转化
nparray.tolist() # 将nparray转化为list
```

### matplotlib
#### core concept

### pybind11
#### core concept
- 可以将C++的接口暴露出来，供python 进行调用。类似的库还有Boost.python
- 也可以将python的接口暴露给C++使用
#### 注意事项
- pybind11安装的时候需要添加[global]选项，否则CMakelists.txt中的find_package找不到：
```bash
pip install "pybind11[global]"
```
### pickle
用于python原生数据点永久存储，缺点是只能够被python读取。如果需要跨语言可以使用json格式进行存储。
#### 使用
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