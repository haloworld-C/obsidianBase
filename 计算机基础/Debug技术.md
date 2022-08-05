### Debug思路

#### Debug 工具
##### gdb
##### valgrind
#### 常见debug问题
1. 当编译结果出现随机值，很有可能跟内存访问错误有关（比如访问越界）
2. int转float可能出现精度损失，而int转double则不会。这是浮点数的移位编码导致的

#### catkin_make
1. 编译添加debug选项
```bash
catkin_make -DCMAKE_BUILD_TYPE=debug
```
2. 需要debug的节点的lauch文件添加launch-prefix="xterm -e gdb -ex run --args"
```xml
<node pkg="waypoint_follower" type="pure_persuit" name="pure_pursuit" output="screen" launch-prefix="xterm -e gdb -ex run --args">
        <param name="is_linear_interpolation" value="$(arg is_linear_interpolation)"/>
</node>
```