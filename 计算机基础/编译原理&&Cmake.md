### Core concept
- 编译的基本过程
编程语言文件->解析->汇编语言->机器码->链接->可执行文件
- 静态库vs动态库



### 工具链
1. google 三件套
	gtest, glog, gflags
 2. 编译时生成机器码
```bash
gcc -Og -c test.c # 生成机器码.o文件
objdump -d test.o # 根据机器码生成反汇编文件
```

### 参数
- 指定安装目录
```bash
cmake -DCMAKE_INSTALL_PREFIX=/usr ..
```

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