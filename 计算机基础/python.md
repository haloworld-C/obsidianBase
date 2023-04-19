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
- 广播
#### 常用操作
```python

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
