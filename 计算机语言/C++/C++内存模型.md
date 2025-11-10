## C++内存模型

- 局部变量一般使用寄存器存储， 速度最快
- 全局变量与静态变量，位于静态存储器中
- 寄存器数目有限， 超过的局部变量在堆中， 由程序自行维护
- 用户自定义的运行时才知道类型\长度的的数据， 位于堆中， 用用户自行申请及释放

###  std标准库
#### share_ptr
- 循环引用仍有可能导致内存泄漏

##### make_shared工厂函数
##### 指针类型的转换
```cpp
boost::shared_ptr<Layer> layerPtr plugin;
boost::shared_ptr<StaticLayer> staticLayerPtr;
staticLayerPtr = boost::dynamic_pointer_cast<StaticLayer>(plugin); // 向下转换
LayerPtr = boost::static_pointer_cast<StaticLayer>(plugin); // 向上转换
```

> 注意: 无论是何种智能指针， 其资源的对象都在堆上。 对于没有手动管理的内存的小规模类而言， 如果没有构造多态的需求， 那么使用其原始对象has a as value是一种更好的实践。



### issues
1. array 与maclloc()的区别
- array是分配在stack中， 随着离开作用域该部分内存会被自动释放（其空间相对heap来说会小很多, 一般为8MB左右）
- maclloc()分配的内存位于动态内存区（heap），可用的空间一般比stack大，其缺点是需要使用者手动释放（这也是内存相关问题的主要原因（没有释放导致内存泄漏;释放后再次访问导致core dump））
