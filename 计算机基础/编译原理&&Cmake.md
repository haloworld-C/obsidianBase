
1. 静态库vs动态库



### 工具链
1. google 三件套
	gtest, glog, gflags


### Q&A
1. 安装库后仍无法找到？
	- case1: 如果是通过源码安装，需要执行更新库指令。
	```bash
	sudo ldconfig
	```

 也可用通过命令查询库文件是否可以被系统识别：
```bash
pkg-config --libs ipopt[pack_name]
```
2. 编译出现c++: internal compiler error: Killed (program cc1plus)问题
查看内存使用后发现是内存耗尽导致的，使用的catkin_make进行编译（默认采用-j6 多线程编译），采用单线程编译即可：
```bash
catkin_make -j1
```