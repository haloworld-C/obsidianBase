## `adaptive monte carlo localization`
### basic concept
该算法是一种加入了`KLD`采样的`MCL`(粒子滤波), 主要特点有:
- 解决了全局定位的问题(比如kid-napping), 所谓全局定位的问题是指没有没有初始位置作为输入
- 从全局传感器数据进行定位， 而无需对传感器进行特征提取
- 相比`MCL`提升了性能: 采样分数较低时重新全局撒点， 采样分数很高时减小采样规模减少资源占用
### particle filter(粒子滤波)

### MCL(`monte calro location`)
> [paper](monte carlo localization: efficient position estimation for mobile robot)
蒙特卡洛定位是基于粒子滤波的算法。
主要的特点如下:
- 可以同时解决局部定位与全局定位
- 