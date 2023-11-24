## Debug思路
- debug的目的是解决程序运行的非预期bug，一般在程序部署运行后使用。对于研发阶段的bug应该通过测试驱动的流程来规避(换句话说， 应该在能力范围内减少bug)

### Debug 工具
#### gdb
- 常用命令

|命令行名称|说明||
|---|---|---|
|help |显示命令帮助||  
|run |启动程序||  
|continue |启动程序||  
|break | 加入断点| break [源文件：行号]，在某行加入断点 break function_name为某个函数设置断点 |
|delete | 删除断点| delete [源文件：行号]，在某行加入断点 delete function_name为某个函数设置断点 |
|next|执行下一行代码|并不会进入子函数, step会进入子函数   |
|step|执行下一行代码|   |
|print my_var|查看断点处的变量状态|print/x my_var 以十六进制进行显示  |
|dispaly my_var|自动显示断点处的变量状态|dispaly/x my_var 以十六进制进行显示  |
|watch my_var|监视某个变量， 如果变量发生改变则暂停程序|  |
|backtrace|显示 seg fault 前的函数调用过程| 简称`bt` |
|where|显示 seg fault 前的函数调用过程|  |
|list|显示发生错误附近的源码|  list [function]显示function源码|

- gdb -tui
#### cgdb(图形化gdb工具)
##### core concept
- 源文件窗口
	 - 按[esc]进入源文件窗口
	 - 按o进入当前加载的程序相关的文件窗口 
- gdb调试窗口
##### 问题解决
-  显示字体过小，找不到调整菜单
按住`ctrl`单击右键

#### valgrind
##### core concept
- 常用来定位内存问题
#### `dw`库
用来记录异常抛出附近代码。
- 安装 
```bash
sudo apt install libdw-dev
```
- 使用
1. 将头文件`backward.hpp`放入工程
2. `CMakelists.txt`添加：
```CMakelists.txt
include_diretory(<backward.hpp path>)
target_link_libraries(<project name> dw)
```
3. 程序入口文件添加：
```cpp
#define BACKWARD_HAS_DW 1
#include "tools/backward.hpp"
namespace backward{
backward::SignalHandling sh;
}
```
> 在`CMakelist.txt`中需要将编译选项`-g`打开

### 常见debug问题
1. 当编译结果出现随机值，很有可能跟内存访问错误有关（比如访问越界）
2. int转float可能出现精度损失，而int转double则不会。这是浮点数的移位编码导致的

#### catkin_make
1. 编译添加debug选项
```bash
catkin_make -DCMAKE_BUILD_TYPE=Debug # 对普通的程序也适用
```
如果cmake提示会严重降低性能，则可以再添加下面的选项:
```bash
catkin_make -DCMAKE_BUILD_TYPE=Debug -DFORCE_DEBUG_BUILD=True
```
2. 需要debug的节点的lauch文件添加launch-prefix="xterm -e gdb -ex run --args"
```xml
<node pkg="waypoint_follower" type="pure_persuit" name="pure_pursuit" output="screen" launch-prefix="xterm -e gdb -ex run --args"> 
        <param name="is_linear_interpolation" value="$(arg is_linear_interpolation)"/>
</node>
```
> #可以把-ex run 去掉，这样就有机会设置断点

3. cmake 源码无法同步显示
在Cmakefile中添加如下编译选项
```CMakefile
# for debug info
# 打开编译选项
SET(CMAKE_BUILD_TYPE "Debug")\
# -O0， 不进行任何优化 
# - Wall,  让编译器报告所有警告
# -g2, 支持源码显示
# -ggdb, 支持gdb调试信息
SET(CMAKE_CXX_FLAGS_DEBUG "$ENV{CXXFLAGS} -O0 -Wall -g2 -ggdb")
# 设置release 编译选项, 与debug选项无关
SET(CMAKE_CXX_FLAGS_RELEASE "$ENV{CXXFLAGS} -O3 -Wall") 
```
### debug步骤
1. 编译应添加debug支持
- gcc/g++ 
```C
$ gcc/g++ -g factorial.c # -g 支持源码显示
```
- CMake
```CMakeLists.txt
SET(CMAKE_BUILD_TYPE "Debug")
SET(CMAKE_CXX_FLAGS_DEBUG "$ENV{CXXFLAGS} -O0 -Wall -g2 -ggdb")
```
2. 以gdb或cgdb运行程序
```bash
gdb executa_file
```
3. 调试
- 可以在主程序中添加断点，然后通过step进入调用函数中再次设置断点
