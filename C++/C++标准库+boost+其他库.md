### STL
#### 组件 
- std::chrono
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