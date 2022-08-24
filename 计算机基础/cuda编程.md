### core concept
1. 为nividia显卡特有的GPU计算接口（并行计算可大幅提高运行速度）
2. tensor cores and cuda cores
3. cuda 最小的的逻辑调度单位为线程
4. tensor cores 主要用于单精度PF32和半精度PF16的混合FMA混合4x4矩阵的乘加计算，即计算`D = A x B + C`
5. SM
6. block

### 注意事项
- 主文件后缀应为.cu（否则识别不到cuda interface的内部变量）
- cuda的主要耗时为数据拷入拷出的时间，如果需要频繁进行拷入拷出的操作（比如通信），则需要考虑是否适用cuda(应用场景应为高频计算， 而非高频通信)