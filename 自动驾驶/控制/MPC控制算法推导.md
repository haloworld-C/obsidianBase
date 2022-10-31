### 概述

### 运动模型建模
考虑如下车辆运动模型：
$$\left\{\begin{matrix}
 \dot{x} = v*cos(\phi)
\\ \dot{y} = v*sin(\phi)
\\ \dot{\phi} = \omega = \frac{v*tan(\delta)}{L}
\\ \dot{v} = a
\end{matrix}\right.$$
该运动模型推导参见[[多车辆运动学公式推导]]。其中$v$为车辆速度(矢量，未必为车头方向)， $a$为车辆纵向加速度，$\omega$为转弯的角速度， $\delta$为前轮转角， $\phi$为车辆航向角。
### 运动模型线性化
定义系统状态$z=[x, y, \phi, v]^T$, 控制向量为$u=[a, \delta]^T$。
则上面运动方程可以写为：
$$
\begin{equation}
\begin{aligned}
\dot{z}=f(z,u)&=\frac{\partial{f}}{\partial{z}}z+\frac{\partial{f}}{\partial{u}}u=A{\times}z+B{\times}u\\
&=\left[ \begin{array}{cccc}
\frac{\partial{f_1}}{\partial{x}} & \frac{\partial{f_1}}{\partial{y}} & \frac{\partial{f_1}}{\partial{\phi}} & \frac{\partial{f_1}}{\partial{v}} \\

\frac{\partial{f_2}}{\partial{x}} & \frac{\partial{f_2}}{\partial{y}} & \frac{\partial{f_2}}{\partial{\phi}} & \frac{\partial{f_2}}{\partial{v}} \\
\frac{\partial{f_3}}{\partial{x}} & \frac{\partial{f_3}}{\partial{y}} & \frac{\partial{f_3}}{\partial{\phi}} & \frac{\partial{f_3}}{\partial{v}} \\
\frac{\partial{f_4}}{\partial{x}} & \frac{\partial{f_4}}{\partial{y}} & \frac{\partial{f_4}}{\partial{\phi}} & \frac{\partial{f_4}}{\partial{v}} \\
  \end{array} \right]{\times}z \\
&+\left[ \begin{array}{cccc}
\frac{\partial{f_1}}{\partial{a}} & \frac{\partial{f_1}}{\partial{\delta}} \\
\frac{\partial{f_2}}{\partial{a}} & \frac{\partial{f_2}}{\partial{\delta}} \\
\frac{\partial{f_3}}{\partial{a}} & \frac{\partial{f_3}}{\partial{\delta}} \\
\frac{\partial{f_4}}{\partial{a}} & \frac{\partial{f_4}}{\partial{\delta}} \\
  \end{array} \right]{\times}u \\
&=\left[ \begin{array}{cccc}
 0 & 0 & -v*sin(\phi) & cos(\phi) \\
 0 & 0 & v*cos(\phi) & sin(\phi) \\
 0 & 0 & 0 & \frac{tan(\delta)}{L} \\
 0 & 0 & 0 & 0 \\
  \end{array} \right]{\times}z \\
&+\left[ \begin{array}{cccc}
0 & 0 \\
0 & 0 \\
0 & \frac{v}{L*cos^2(\delta)} \\
0 & 1 \\
  \end{array} \right]{\times}u \\
\end{aligned}
\end{equation}
$$

### 运动状态方程离散化
采用前向欧拉法对上述线性方程进行离散化。
$$
\begin{equation}
\begin{aligned}
z_{k+1}&=z_k+f(z_k, u_k){\times}dt=z_k+(A{\times}z_k+B{\times}u_k){\times}dt\\
&=(I+A{\times}dt)z_k+(B{\times}dt)u_k\\
&=\overline{A}z_k+\overline{B}u_k
\end{aligned}
\end{equation}
$$
### 优化目标函数推导
定义未来p个周期内预测的系统状态为：
$$
X_k=\left[ z(k+1|k)^T, z(k+2|k)^T, \dots, z(k+p|k)^T  \right]^T
$$
定义到达未来p个周期内预测的系统输入为：
$$
U_k=\left[  u(k+1|k)^T, u(k+2|k)^T,\dots, u(k+p|k)^T   \right]
$$
则由上述离散状态转移方程可以写出未来p个状态的状态转移方程：
