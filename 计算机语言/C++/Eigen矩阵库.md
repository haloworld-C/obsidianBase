### Eigen矩阵库
#### 概念
- 矩阵运算库
- row为行，col为列（动态矩阵初始化参数中第一个为行，第二个为列）
- 通过.col（index）, .row(index)返回行与列的对象
- Eigen中矩阵的对存储顺序为列优先
	`VectorXd`为列向量，故用`MatrixXd`表达路径时应该将点的信息储存在一列中
```cpp
MatrixXd mat(3, 2);
mat << 3, 1,
	   2, 5, 
	   9, 4;
// 打印原始数据
for (int i = 0; i < mat.size(); i++)
	cout << *(mat.data() + i) << "  ";
cout << endl << endl;
// output: 3 2 9 1 5 4
```
- 广播

#### 常用接口
- 初始化
```C++
Eigen::MatrixXf mat; //声明一个动态矩阵
mat.resize(m,n); //将mat初始化为m行n列的矩阵
```
- 高级初始化
```C++
#include <Eigen/Dense>
# use array intilize
double dataArray[] = {1.0, 2.0, 3.0, 4.0, 5.0, 6.0};
Eigen::Map<Eigen::Matrix<double, 2, 3>> eigenMatrix(dataArray);
# use vector initlize MatrixXd
std::vector<double> data = {1.0, 2.0, 3.0, 4.0, 5.0, 6.0};
Eigen::Map<Eigen::MatrixXd> eigenMatrix(data.data(), rows, cols);
# use vector initlize VectorXd
Eigen::Matrix<double, 2, 4, Eigen::RowMajor> footPrintMatrix(footPrintVec.data()); # 指定存储顺序
Eigen::MatrixXd traj = MatrixXd::Zero(); // 初始化为0矩阵
```
#### 常用操作
- 运算
	`Eigen`中乘法操作符`*`会进行严格的维度检查。
- 索引与广播
```cpp
mat.row(i); // 获取第i行

mat.colwise(); // 以列为单位进行广播操作, rowwise同理
Vector3d pose(1, 2);
mat.block(0, 0, 2, lenPoint).colwise() -= pose; # mat中点的坐标以列存储，从而获得相对位置
mat.block<p, q>(i, j); //返回矩阵左上角为(i, j)，矩阵大小为(p, q)的子矩阵
mat.block(i, j, p,q); //与上语句等价
// 调整动态矩阵大小
mat.resize() // 里面的值不保证不被改变
mat.conservativeResize(m, n) // 原有值将保持不变
```
- 算法
```cpp
// 最大值
double maxVal = vec.maxCoeff();
// 拼接矩阵, 横向
checkPoints.resize(2, scan_points_.cols() + depth_points_.cols());
checkPoints.block(0, 0, 2, scan_points_.cols()) = scan_points_;
checkPoints.block(0, scan_points_.cols(), 2, depth_points_.cols()) = depth_points_;

```
#### eigen的注意事项
- 静态大小与动态大小的区别（初始化）
- 在编译的时候，如果eigen
- 遇到一个很奇怪的现在，按理说eigen是一个纯头文件库，不需要链接，但是通过在CMake中通过find_package后需要链接才能找到Eigen的头文件，解决方案：
```CMakelists.txt
include_directories(${EIGEN3_INCLUDE_DIR})
```
- 不要使用`C++`中的auto关键字与eigen配合
#### 问题
1. 维度检查没报错
```cpp
Vector3d transGlobalPoint2local(Vector3d pose, Vector3d goal) {
    MatrixXd rotateMatrix(2, 2); 
    double yaw = pose(2); // third element in pose
    rotateMatrix << cos(yaw), sin(yaw),
                    -sin(yaw), cos(yaw);  
    return rotateMatrix * (goal - pose);
}
auto  goalLocal = helper::transGlobalPoint2local(robotPos, goalPos); //可能是auto 的原因
```