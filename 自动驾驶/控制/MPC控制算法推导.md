### 当前研究趋势
![mpc_with_learning](../../Resourse/mpc_research_topic.png)
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
定义未来p个周期(预测步长)内预测的系统状态为：
$$
X_k=\left[ z_{k|k}^T, z_{k+1|k}^T, \dots, z_{k+p-1|k}^T  \right]^T
$$
定义到达未来p个周期内预测的系统输入为：
$$
U_k=\left[  u_{k|k}^T, u_{k+1|k}^T,\dots, u_{k+p-1|k}^T   \right]
$$
则由上述离散状态转移方程可以写出未来p个状态的状态转移方程：
$$
\begin{equation}
\begin{aligned}
z_{k+1|k}&=\overline{A}z_k+\overline{B}u_k\\
z_{k+2|k}&=\overline{A}z_{k+1|k}+\overline{B}u_{k+1|k} \\
		&={\overline{A}}^2z_k+\overline{A}{\times}\overline{B}u_k+\overline{B}u_{k+1|k} \\
		&\dots \\
z_{k+p|k}&={\overline{A}}^p{\times}z_{k+p-1|k}+{\overline{A}}^{p-1}{\times}{\overline{B}u_k}+{\overline{A}}^{p-2}{\times}{\overline{B}}u_{k+1}+\dots+\overline{A}^{p-p}\times\overline{B}u_{k+p-1|k}
\end{aligned}
\end{equation}
$$
将上式写为矩阵形式：
$$
\begin{equation}
\begin{aligned}
X_{k+1}&=\Phi\times{X_k}+\Theta\times{U_k} \\
	   &=\left[ 
		   \begin{array}{}   
		   \overline{A} \\
		   \overline{A}^2 \\
		   \vdots \\
		   \overline{A}^p
		   \end{array} 
	   \right ]_{4p\times{4}}\times{X_k} 
	   &+\left[ 
		   \begin{array}{cccc}   
		   \overline{A}^{1-1}\overline{B} & \dots & 0 & 0 \\
		   \overline{A}^{2-1}\overline{B} & \overline{A}^{1-1}\overline{B} & \dots & 0\\
		   \vdots & \vdots & \ddots & \vdots\\
		   \overline{A}^{p-1}\overline{B} & \overline{A}^{p-2}\overline{B} & \dots & \overline{A}^{p-p}\overline{B}
		   \end{array} 
	   \right ]_{4p\times{4}}\times{U_k} 
\end{aligned}
\end{equation}
$$
定义预定的控制目标(步长为p)为：
$$
R_k=\left[ r_{k}^T, r_{k+1}^T, \dots, r_{k+p-1}^T  \right]^T
$$
定义优化目标代价函数为：
$$
J(U_k)=(X_{k+1}-R_{k+1})^TQ(X_{k+1}-R_{k+1})+U_k^TW_1U_k+(U_k-U_{k-1})^TW_2(U_k-U_{k-1})

$$
将上面的$X_k$的状态转移方程带入上式，整理得以下二次型：
$$
J(u_k)=\frac{1}{2}U_k^THU_k+FU_k 
$$
其中：
$$
\begin{equation}
\begin{aligned}
\left \{\begin{matrix}
		H=2({\Theta}^TQ\Theta+W_1+W_2) 
		\\ F^T=\frac{1}{2}E^TQ\Theta-D
		\\ E=\Phi{X_k}-R_k
		\\ D=U_{k-1}^T(W_2+W_2^T)
		\end{matrix} \right .
\end{aligned}
\end{equation}
$$
上式可调用osqp进行求解，对$U_k$可以添加输入限制。
### 优化目标求解 