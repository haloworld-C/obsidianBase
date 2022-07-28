### Debug思路

#### Debug 工具
##### gdb
##### valgrind
#### 常见debug问题
1. 当编译结果出现随机值，很有可能跟内存访问错误有关（比如访问越界）
2. int转float可能出现精度损失，而int转double则不会。这是浮点数的移位编码导致的