### STL
#### 数据结构
##### vector
-  vector的内存机制 
1. 内存为管理对象数目内存的两倍大小，如果超过一个系数(??多少), 便需要再内存中再开辟一个区域，将现有对象拷贝。所以当vector规模很大的时候，很容易触发内存拷贝。
- 常用方法

|方法|说明|补充|
|---|---|---|
|reserve|增大vector的储存元素的能力，系数为1|主要目的是推迟内存的两倍成长， 值得注意的是reverse后之前的iter和元素引用都将失效|
|resize|改变vector的大小||
|push_back|在vector尾部插入元素||
|size|获取当前元素个数|其时间复杂度为1|
|front|获取第一个元素||
|back|获取最后一个元素||

##### list
- 在第k个元素前插入
```C++
#include <iostream>
#include <list>

int main() {
    std::list<int> myList = {10, 20, 30, 40, 50};

    // Inserting an element at the kth position (k = 2 in this example)
    int k = 2;
    std::list<int>::iterator it = myList.begin();
    std::advance(it, k);  // Move the iterator to the kth position
						  // since C++17
	// std::next(it, k); // since C++11

    myList.insert(it, 25); // Insert the value 25 at the kth position

    // Print the updated list
    for (int num : myList) {
        std::cout << num << " ";
    }
    std::cout << std::endl;

    return 0;
}

```


##### queue

##### map

##### set

##### 特殊数值
- 无穷大
```C++
#include <limits>
std::numeric_limits<T> ::infinity()
```
这个无穷大的值只有在浮点数上才有，在其他整形数值类型上为0;
如果在整型上想用一个比较大的值可以用
```c++
std::numeric_limits<T>::max()
```
代替
包含在头文件limits.h头文件当中 
#### 算法algorithm
#### 比较大小
```C++
std::max(a, b);
std::min(a, b);
```
##### 倒转元素
```C++
#include <iostream>
#include <vector>
#include <algorithm>

int main() {
    std::vector<int> myVector = {1, 2, 3, 4, 5};

    std::reverse(myVector.begin(), myVector.end());

    for (int num : myVector) {
        std::cout << num << " ";
    }

    return 0;
}
```
- 迭代器与index计算
```C++
std::next(iter, 5); //在iter迭代器上递增5(since C++11)
std::advance(iter, 5); //在iter迭代器上递增5(since C++17)
std::distance(input_path.begin(), precise_planning_iter); // 计算两个迭代器之间的步长
```
##### 取整
```C++
std::floor(); #地板除(向下取整数)
std::ceil(); #地板除（向上取整）
```
##### 绑定与注册
- 模板绑定
```C++
std::bind();
```
#### 组件
##### 随机数
- random库
- 生成随机整数
```C++
std::srand(std::time(nullptr)); // use current time as seed for random generator
int random_variable = std::rand();
```
##### chrono
C++ 共提供三种时钟计时器：
1.  system_clock
2.  high_resolution_clock
3.  steady_clock(与hight_resolution_clock类似，不过不能调整is_steady属性，indicates if the clock is monotonous)
##### std::thread
- 线程中的资源锁
std::mutex中提供两种上锁方式
	1. std::lock_guard
	2. std::unique_lock
- 原子量
	std::atomic原子操作变量，与多线程环境中保证线程安全。
> 当使用std::thread时， 需要在编译时g++ 需要在末尾加上-pthread


### boost库


### Eigen矩阵库
#### 概念
- 矩阵运算库
- row为行，col为列（动态矩阵初始化参数中第一个为行，第二个为列）
- 通过.col（index）, .row(index)返回行与列的对象
- `VectorXd`为列向量，故用`MatrixXd`表达路径时应该将点的信息储存在一列中

#### 常用接口
```C++
Eigen::MatrixXf mat; //声明一个动态矩阵
mat.resize(m,n); //将mat初始化为m行n列的矩阵
mat.block<p, q>(i, j); //返回矩阵左上角为(i, j)，矩阵大小为(p, q)的子矩阵
mat.block(i, j, p,q); //与上语句等价
```
- 使用已有其他数据结构进行初始化
```C++
#include <Eigen/Dense>
# use array intilize
double dataArray[] = {1.0, 2.0, 3.0, 4.0, 5.0, 6.0};
Eigen::Map<Eigen::Matrix<double, 2, 3>> eigenMatrix(dataArray);
# use vecotr initlize
std::vector<double> data = {1.0, 2.0, 3.0, 4.0, 5.0, 6.0};
Eigen::Map<Eigen::MatrixXd> eigenMatrix(data.data(), rows, cols);
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