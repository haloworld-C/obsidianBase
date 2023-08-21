## Debug思路

### Debug 工具
#### gdb
- 常用命令
- gdb -tui
#### cgdb(图形化gdb工具)
#### valgrind
##### core concept
- 常用来定位内存问题
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
1. 编译应添加debug选项
- gcc/g++ 
```C
$ gcc/g++ -g factorial.c # -g 支持源码显示
```
- CMake
```CMakeLists.txt
SET(CMAKE_BUILD_TYPE "Debug")
```