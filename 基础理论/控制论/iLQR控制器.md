> 本篇文章从以下文章取得理解。
>ref1: [iLQR_Tutorial](https://rexlab.ri.cmu.edu/papers/iLQR_Tutorial.pdf)(本文在该文章的部分内容的基础上，结合自己的理解重新整理了符号系统)
>ref2: [LQR & iLQR Linear Quadratic Regulator](https://jonathan-hui.medium.com/rl-lqr-ilqr-linear-quadratic-regulator-a5de5104c750)(从这篇文章中获取反馈矩阵的形式的理解)
>ref3: [ILQR算法约束处理与内点法DDP](https://zhuanlan.zhihu.com/p/634951102)(从这篇文章中理解到iLQR的本质是对已有轨迹和对应控制的扰动控制，进一步理解了迭代在iLQR语境中的含义)
>ref4: [iLQR--基于最优控制iLQR/DDP的运动规划](https://blog.csdn.net/BigDavid123/article/details/138272291)（从这篇文章理解了iLQR算法的递推过程框架， 并对贝尔曼最优理论有了进一步地理解）
> ref5: [iLQR算法公式推导](https://zhuanlan.zhihu.com/p/660810899)(从这篇文章中理解到iLQR到后文说的$\delta{V}$的用途)

### core concept
- 对于线性系统的二次型代价函数的最优控制问题而言， 使用LQR可以很高效的计算出一条满足要求的轨迹。其推导可参考[[LQR控制器]] 。
- 但是现实的问题中， 比如车辆的的运动学、动力学方程都是非线性系统(车轮横向运动约束)， 故需要对运动方程及代价函数在采样点进行线性化，然后再应用类似`LQR`控制器推导框架(基于动态规划思想)。
- 在iLQR中本质上是通过施加$\delta{U}$对初始的轨迹进行"扰动"， 从而迭代地在上一次得到轨迹附近找到一条质量更优的轨迹(更低的代价)， 本质上是局部寻优。
- iLQR与DDP方法对区别是， iLQR对非线性动态方程进行一阶泰勒展开， 而DDP则进行二阶展开。
- i LQR需要一条初始轨迹$X$及对应的控制量$U$启动(可以通过LQR或其他方法得到)(是否需要初始轨迹还需要想想？)。
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
&\approx f(\overline{x}_k, \overline{u}_k)+\frac{\partial{f}}{\partial{x_k}}(x_k-\overline{x}_k)+\frac{\partial{f}}{\partial{u_k}}(u_k-\overline{u}_k) \\
&=f(\overline{x}_k, \overline{u}_k)+\frac{\partial{f}}{\partial{x_k}}\delta{x_k}+\frac{\partial{f}}{\partial{u_k}}\delta{u_k}
\end{aligned}
\end{equation}
\tag{1.2}
$$
将式(1.1)带入(1.2), 得到: 
$$
\begin{equation}
\begin{aligned}
\delta{x_{k+1}}&=\frac{\partial{f}}{\partial{x_k}}\delta{x_k}+\frac{\partial{f}}{\partial{u_k}}\delta{u_k} \\
&=A_k\delta{x_k}+B_k\delta{u_k}
\end{aligned}
\end{equation}
\tag{1.3}
$$
显然， 矩阵A的维度为$n\times{n}$, 矩阵B的维度为$n\times{m}$, 这里矩阵求导采用分子布局的形式。
#### 代价方程转化为线性二次型的形式
代价方程(Cost Function)的一般形式为:
$$
\begin{equation}
\begin{aligned}
J(x_0, u) = \ell_f(x_N)+\sum^{N-1}_{k=0}\ell_k(x_k, u_k)
\end{aligned}
\end{equation}
\tag{2.1}
$$对非线性代价函数$\ell_k$进行二阶泰勒级数在上一次优化轨迹的参考点($\overline{x}_k$, $\overline{u}_k$)处展开:
$$
\begin{equation}
\begin{aligned}
l_k(x_k+\delta{x}_k,u_k+\delta{u}_k)&= \ell_k(\overline{x}_k, \overline{u}_k)+\delta{\ell_k} \\
&\approx \ell(\overline{x}_k, \overline{u}_k)+\frac{\partial{\ell}}{\partial{x_k}}(x_k-\overline{x}_k)+\frac{1}{2}(x_k-\overline{x}_k)^T\frac{\partial^2\ell}{\partial{x_k}^2}(x_k-\overline{x}_k) \\
&+\frac{\partial{\ell}}{\partial{u_k}}(u_k-\overline{u}_k)+\frac{1}{2}(u_k-\overline{u}_k)^T\frac{\partial^2\ell}{\partial{u_k}^2}(u_k-\overline{u}_k) \\
&+\frac{1}{2}(x_k-\overline{x}_k)^T\frac{\partial\ell}{\partial{x_k}}\frac{\partial\ell}{\partial{u_k}}(u_k-\overline{u}_k) \\
&+\frac{1}{2}(u_k-\overline{u}_k)^T\frac{\partial\ell}{\partial{u_k}}\frac{\partial\ell}{\partial{x_k}}(x_k-\overline{x}_k)
\end{aligned}
\end{equation}
\tag{2.2}
$$

由上式可知:
$$
\begin{equation}
\begin{aligned}
\delta{\ell}_k=\left [ \begin{array}{c}
(\frac{\partial{\ell_k}}{\partial{x}_k})^T \\
(\frac{\partial{\ell_k}}{\partial{u}_k})^T\\
  \end{array} \right]^T\left [ \begin{array}{c}
\delta{x}_k \\
\delta{u}_k\\
  \end{array} \right]+\left [ \begin{array}{cc}
 \frac{\partial^2{\ell_k}}{\partial{x}_k^2} &  \frac{\partial^2{\ell_k}}{\partial{x}_k\partial{u_k}}\\
\frac{\partial^2{\ell_k}}{\partial{x}_k\partial{u_k}} & \frac{\partial^2{\ell_k}}{\partial{u}_k^2}\
  \end{array} \right]
\end{aligned}
\end{equation}
\tag{2.3}
$$
我们将偏导重新定义偏导矩阵如下， 后文均采用类似的定义以方便理解：
$$
\left\{
\begin{equation}
\begin{aligned}
l_{xx|k}&=\frac{\partial^2\ell_k}{\partial{x_k}^2} \\
l_{xu|k}&= \frac{\partial^2\ell_k}{\partial{x_k}\partial{u_k}}\\
l_{ux|k}&= \frac{\partial^2\ell_k}{\partial{u_k}\partial{x_k}}\\
l_{uu|k}&=\frac{\partial^2\ell_k}{\partial{u_k}^2} \\
l_{x|k}&=\frac{\partial\ell_k}{\partial{x_k}} \\
l_{u|k}&=\frac{\partial\ell_k}{\partial{u_k}} \\
\end{aligned}
\end{equation}
\tag{2.4}
\right.
$$
其中$\ell_{xx|k}$下标中$x$表示$\ell$对$x$求一次偏导数， $x$在下标中出现两次表示求的是二阶偏导， 下标$k$表示的是在离散后的系统中是第k步(轨迹中的第k个状态点), 这样定义方便我们理解后文中的递推过程。
#### 动态规划递推
##### 回顾贝尔曼优化过程

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