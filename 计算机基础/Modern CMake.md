### core concept
`CMake`是一个可跨平台的统一编译工具。
其使用的语言类似shell脚本语言。

### 常用命令与环境变量

| variable | description | comment |
| ---- | ---- | ---- |
| `CMAKE_CURRENT_SOURCE_DIR` | 当前`CMakelists.txt`所在的完整目录 |  |

| command | description | comment|
|------|----------|---------|
|set| 设置环境变量值| 通常用来指代目录，环境变量通常大写|
|aux_source_directory| 某个文件夹下的左右文件名| |
|add_library| 添加动/静态链接库| |

### syntax

### 参数
- 指定安装目录
```bash
cmake -DCMAKE_INSTALL_PREFIX=/usr ..
```

### 基本用法
### 现代用法
1. 一种指定头文件路径的方法
```CMakelists.txt
set(CATCH_DIR include/test/catch2)
add_library(Catch INTERFACE) # 指定了头文件的位置, 并不会生成.so或.a的二进制文件
target_include_directories(Catch INTERFACE ${CATCH_DIR})
add_executable(catch2_test ${TEST_SOURCES})
target_link_libraries(catch2_test PUBLIC Catch)
### 现代用法
1. 一种指定头文件路径的方法
```CMakelists.txt
set(CATCH_DIR include/test/catch2)
add_library(Catch INTERFACE) # 指定了头文件的位置, 并不会生成.so或.a的二进制文件
target_include_directories(Catch INTERFACE ${CATCH_DIR})
add_executable(catch2_test ${TEST_SOURCES})
target_link_libraries(catch2_test PUBLIC Catch)
```
这样就可以这样在源文件中使用(有些繁琐):
```cpp
#include <catch.hpp>
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
3. CMakeLists.txt中如果没有指定Release则默认是Debug模式(优化等级-o0)


