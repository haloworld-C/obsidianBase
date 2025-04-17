> 本篇文章从以下文章取得理解。
>ref1: [iLQR_Tutorial](https://rexlab.ri.cmu.edu/papers/iLQR_Tutorial.pdf)(本文在该文章的部分内容的基础上，结合自己的理解重新整理了符号系统)
>ref2: [LQR & iLQR Linear Quadratic Regulator](https://jonathan-hui.medium.com/rl-lqr-ilqr-linear-quadratic-regulator-a5de5104c750)(从这篇文章中获取反馈矩阵的形式的理解)
>ref3: [ILQR算法约束处理与内点法DDP](https://zhuanlan.zhihu.com/p/634951102)(从这篇文章中理解到iLQR的本质是对已有轨迹和对应控制的扰动控制，进一步理解了迭代在iLQR语境中的含义)

### core concept
- 对于线性系统的二次型代价函数的问题而言， 使用LQR可以很高效的计算出一条满足要求的轨迹。其推导可参考[[LQR控制器]] 。
- 但是现实的问题中， 比如车辆的的运动学、动力学方程都是非线性系统(车轮横向运动约束)， 故需要对运动方程及代价函数在采样点进行线性化，然后再应用类似`LQR`控制器推导中用到的动态规划的思想对初始的轨迹进行"扰动"， 从而迭代地在初始轨迹附近找到一条质量更优的轨迹。
- 在`iLQR`中，我们假定已知轨迹点的状态$x$及对应的控制量$u$, 可以是通过`LQR`或者`MPC`生成的， 而我们控制量(动态规划中的决策变量)则为$\delta{u}$, 及其对应的施加扰动$\delta{x}$
### 推导过程
#### 离散状态转移方程的线性化
对于以下离散状态转移方程， 
$$
\begin{equation}
x_{k+1}=f(x_k, u_k)
\end{equation}
\tag{1.1}
$$
其中状态向量$x$维度为n, 控制向量u的维度为m.
在$(\overline{x}_k, \overline{u}_k)$处线性化， 进行一阶泰勒级数展开(二元函数):
$$
\begin{equation}
\begin{aligned}
\overline{x}_{k+1}+\delta{x_{k+1}}&=f(\overline{x}_k+\delta{x_k}, \overline{u}_k+\delta{u_k}) \\
&\approx f(\overline{x}_k, \overline{u}_k)+\frac{\partial{f}}{\partial{x}}(x_k-\overline{x}_k)+\frac{\partial{f}}{\partial{u}}(u_k-\overline{u}_k) \\
&=f(\overline{x}_k, \overline{u}_k)+\frac{\partial{f}}{\partial{x}}\delta{x_k}+\frac{\partial{f}}{\partial{u}}\delta{u_k}
\end{aligned}
\end{equation}
\tag{1.2}
$$
将式(1.1)带入(1.2), 得到: 
$$
\begin{equation}
\begin{aligned}
\delta{x_{k+1}}&=\frac{\partial{f}}{\partial{x}}\delta{x_k}+\frac{\partial{f}}{\partial{u}}\delta{u_k} \\
&=A\delta{x_k}+B\delta{u_k}
\end{aligned}
\end{equation}
\tag{1.3}
$$
显然， 矩阵A的维度为$n\times{n}$, 矩阵B的维度为$n\times{m}$, 这里矩阵求导采用分子布局的形式。
#### 代价方程转化为线性二次型的形式(optional)
代价方程(Cost Function)的一般形式为:
$$
\begin{equation}
\begin{aligned}
J(x_0, u) = \ell_f(x_N)+\sum^{N-1}_{k=0}\ell(x_k, u_k)
\end{aligned}
\end{equation}
\tag{2.1}
$$
若$J(x_0, u)$已经是线性二次型的形式: 
$$
\begin{equation}
\begin{aligned}
J(x_0, u) = \frac{1}{2}x_N^TQ_Nx_N+\sum^{N-1}_{k=0}(\frac{1}{2}x_k^TQ_kx_k+\frac{1}{2}u_k^TR_ku_k)
\end{aligned}
\end{equation}
\tag{2.2}
$$
则无需进行转化。 否则需要对非线性代价函数$\ell$进行二阶泰勒级数在上一帧的参考点($\overline{x}_k$, $\overline{u}_k$)处展开:
$$
\begin{equation}
\begin{aligned}
J(x_0,u_k)&= \ell_f(x_N)+\sum^{N-1}_{k=0}\ell(x_k, u_k) \\
&=\ell_f(\overline{x}_N) + \frac{\partial{\ell}_f}{\partial{x_N}}(x_N-\overline{x}_N)+\frac{1}{2}(x_N-\overline{x}_N)^T\frac{\partial^2\ell_f}{\partial{x_N}^2}(x_N-\overline{x}_N) \\
&+\sum_{k=1}^{N-1}[\ell(\overline{x}_k, \overline{u}_k)+\frac{\partial{\ell}}{\partial{x_k}}(x_k-\overline{x}_k)+\frac{1}{2}(x_k-\overline{x}_k)^T\frac{\partial^2\ell}{\partial{x_k}^2}(x_k-\overline{x}_k) \\
&+\frac{\partial{\ell}}{\partial{u_k}}(u_k-\overline{u}_k)+\frac{1}{2}(u_k-\overline{u}_k)^T\frac{\partial^2\ell}{\partial{u_k}^2}(u_k-\overline{u}_k) \\
&+\frac{1}{2}(x_k-\overline{x}_k)^T\frac{\partial\ell}{\partial{x_k}}\frac{\partial\ell}{\partial{u_k}}(u_k-\overline{u}_k) \\
&+\frac{1}{2}(u_k-\overline{u}_k)^T\frac{\partial\ell}{\partial{u_k}}\frac{\partial\ell}{\partial{x_k}}(x_k-\overline{x}_k)]
\end{aligned}
\end{equation}
\tag{1.3}
$$

不妨令：
$$
\left\{
\begin{equation}
\begin{aligned}
q_N&=\frac{\partial\ell_f}{\partial{x_N}} \\
Q_N&=\frac{\partial^2\ell_f}{\partial{x_N}} \\
q_k&=\frac{\partial\ell}{\partial{x_k}} \\
Q_k&=\frac{\partial^2\ell}{\partial{x_k}^2} \\
r_k&=\frac{\partial\ell}{\partial{u_k}} \\
R_k&=\frac{\partial^2\ell}{\partial{u_k}^2} \\
H_k&=\frac{\partial\ell}{\partial{x_k}}\frac{\partial\ell}{\partial{u_k}} \\
H_k^T&=\frac{\partial\ell}{\partial{u_k}}\frac{\partial\ell}{\partial{x_k}} 
\end{aligned}
\end{equation}
\tag{2.4}
\right.
$$
忽略式(2.3)中的常数项后， 得到
$$
\begin{equation}
\begin{aligned}
J(x_0, \delta{u})&=q_N\delta{x_N}+\frac{1}{2}\delta{x_N}^TQ_N\delta{x_N} \\
&+\sum_{k=1}^{N-1}[r_k\delta{u_k}+\frac{1}{2}\delta{u_k}^TR_k\delta{u_k} \\
&+q_k\delta{x_k}+\frac{1}{2}\delta{x_k}^TQ_k\delta{x_k} \\
&+\frac{1}{2}\delta{x_k}^TH_k\delta{u_k}+\frac{1}{2}\delta{u_k}^TH_k^T\delta{x_k} ]
\end{aligned}
\end{equation}
\tag{2.5}
$$
经过上面的转化, 式(1.3)与式(2.5)便组成了一个标准LQR问题。
#### 对Cost-to-go(价值函数V)应用动态规划递推







### 用到的公式