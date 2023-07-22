### STL
#### 组件 
##### vector
-  vector的内存机制 
1. 内存为管理对象数目内存的两倍大小，如果超过一个系数(??多少), 便需要再内存中再开辟一个区域，将现有对象拷贝。所以当vector规模很大的时候，很容易触发内存拷贝。
- 常用方法

|命令行名称|说明|补充|
|---|---|---|
|reserve|增大vector的储存元素的能力，系数为1|主要目的是推迟内存的两倍成长， 值得注意的是reverse后之前的iter和元素引用都将失效|
|resize|改变vector的大小||
|push_back|在vector尾部插入元素||
|size|获取当前元素个数|其时间复杂度为1|
|front|获取第一个元素||
|back|获取最后一个元素||

##### chrono
C++ 共提供三种时钟计时器：
1. system_clock
2. high_resolution_clock
3. steady_clock(与hight_resolution_clock类似，不过不能调整is_steady属性，indicates if the clock is monotonous)
- std::thread
> 当使用std::thread时， 需要在编译时g++ 需要在末尾加上-pthread
- std::mutex(线程中的资源锁)
	mutex中提供两种上锁方式
		- std::lock_guard
		- std::unique_lock
- std::atomic
	原子操作变量，与多线程互操作有关。
- std::floor地板除(向下取整数)
- std::ceil地板除（向上取整）

-  std::numeric_limits<TYPE>
	::infinity() 定义无限大的数
- std::bind
	模板绑定	
- 数值相关
```cpp
std::numeric_limits<double>::infinity()
```
### boost库


### Eigen矩阵库
#### 概念
- 矩阵运算库
- row为行，col为列（动态矩阵初始化参数中第一个为行，第二个为列）
- 通过.col（index）, .row(index)返回行与列的对象

#### 常用接口
```cpp
Eigen::MatrixXf mat; //声明一个动态矩阵
mat.resize(m,n); //将mat初始化为m行n列的矩阵
mat.block<p, q>(i, j); //返回矩阵左上角为(i, j)，矩阵大小为(p, q)的子矩阵
mat.block(i, j, p,q); //与上语句等价
```
#### eigen的注意事项
- 静态大小与动态大小的区别（初始化）
- 在编译的时候，如果eigen
- 遇到一个很奇怪的现在，按理说eigen是一个纯头文件库，不需要链接，但是通过在CMake中通过find_package后需要链接才能找到Eigen的头文件，解决方案：
```CMakelists.txt
include_directories(${EIGEN3_INCLUDE_DIR})
```

###  Abseil
谷歌C++ and Python库

#### 谷歌三件套
##### gflags
glags在添加链接库报错：
```error
undefined reference to symbol '_ZN6google14FlagRegistererC1IiEEPKcS3_S3_PT_S5_'
```
需要在CMakeLists.txt中添加-lgflags：
```CMakeLists.txt
IF (HELLO_FOUND AND gflags_FOUND)
    ADD_EXECUTABLE(useHello useHello.cpp)
    TARGET_LINK_LIBRARIES(useHello ${HELLO_LIBRARY}
                                   ${gflags_LIBRARY}
                                   -lgflags)

```

##### glog

##### gtest