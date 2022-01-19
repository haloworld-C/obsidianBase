### STL
#### 组件 
- std::chrono

- std::thread
> 当使用std::thread时， 需要在编译时g++ 需要在末尾加上
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
- row为行，col为列（动态矩阵初始化参数中第一个为行，第二个为列）
- 通过.col（index）, .row(index)返回行与列的对象

###  Abseil
谷歌C++ and Python库