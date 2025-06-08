> 本篇文章从以下文章取得理解。
>ref1: [iLQR_Tutorial](https://rexlab.ri.cmu.edu/papers/iLQR_Tutorial.pdf)(本文在该文章的部分内容的基础上，结合自己的理解重新整理了符号系统)
>ref2: [LQR & iLQR Linear Quadratic Regulator](https://jonathan-hui.medium.com/rl-lqr-ilqr-linear-quadratic-regulator-a5de5104c750)(从这篇文章中获取反馈矩阵的形式的理解)
>ref3: [ILQR算法约束处理与内点法DDP](https://zhuanlan.zhihu.com/p/634951102)(从这篇文章中理解到iLQR的本质是对已有轨迹和对应控制的扰动控制，进一步理解了迭代在iLQR语境中的含义)
>ref4: [iLQR--基于最优控制iLQR/DDP的运动规划](https://blog.csdn.net/BigDavid123/article/details/138272291)（从这篇文章理解了iLQR算法的递推过程框架， 并对贝尔曼最优理论有了进一步地理解）
> ref5: [iLQR算法公式推导](https://zhuanlan.zhihu.com/p/660810899)(从这篇文章中理解到iLQR到后文说的$\delta{V}$的用途)

> LQR的算法推导详见[[LQR控制器]].
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
其中状态向量$x$维度为n, 控制向量u的维度为m. 在$(\overline{x}_k, \overline{u}_k)$处线性化， 进行一阶泰勒级数展开(二元函数, 后文均忽略高阶项):
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
J(x_0, u) = \ell_f(x_N)+\sum^{N-1}_{k=0}\ell_i(x_i, u_i)
\end{aligned}
\end{equation}
\tag{2.1}
$$

> 应该在头脑中明确一点: 无论是$J$还是$\ell$ 函数均是关于向量($x_i$, $u_i$)的标量函数， 既然他们均为标量那么无论里面的矩阵相乘如何运算，其结果均为标量， 总有$a=a^T$ 后文公式推导将不加提醒地反复利用这一点进行同类项的合并。

对非线性代价函数$\ell_k$进行二阶泰勒级数在上一次优化轨迹的参考点($\overline{x}_k$, $\overline{u}_k$)处展开:
$$
\begin{equation}
\begin{aligned}
&\quad \ell_k(x_k+\delta{x}_k,u_k+\delta{u}_k)= 
 \ell_k(\overline{x}_k, \overline{u}_k)+\delta{\ell_k}  \\
&\approx \ell_k(\overline{x}_k, \overline{u}_k)+\frac{\partial{\ell}}{\partial{x_k}}(x_k-\overline{x}_k)+\frac{1}{2}(x_k-\overline{x}_k)^T\frac{\partial^2\ell}{\partial{x_k}^2}(x_k-\overline{x}_k) \\
& \quad +\frac{\partial{\ell}}{\partial{u_k}}(u_k-\overline{u}_k)+\frac{1}{2}(u_k-\overline{u}_k)^T\frac{\partial^2\ell}{\partial{u_k}^2}(u_k-\overline{u}_k) \\
& \quad +\frac{1}{2}(x_k-\overline{x}_k)^T\frac{\partial\ell}{\partial{x_k}}\frac{\partial\ell}{\partial{u_k}}(u_k-\overline{u}_k) \\
& \quad +\frac{1}{2}(u_k-\overline{u}_k)^T\frac{\partial\ell}{\partial{u_k}}\frac{\partial\ell}{\partial{x_k}}(x_k-\overline{x}_k)
\end{aligned}
\end{equation}
\tag{2.2}
$$

由上式可知:
$$
\begin{equation}
\begin{aligned}
\delta{\ell}_k=\left [ \begin{array}{c}
\delta{x}_k \\
\delta{u}_k\\
  \end{array} \right]^T \left [ \begin{array}{c}
\frac{\partial{\ell_k}}{\partial{x}_k} \\
\frac{\partial{\ell_k}}{\partial{u}_k}\\
  \end{array} \right]+ \frac{1}{2}\left [ \begin{array}{c}
\delta{x}_k \\
\delta{u}_k\\
  \end{array} \right]^T\left [ \begin{array}{cc}
 \frac{\partial^2{\ell_k}}{\partial{x}_k^2} &  \frac{\partial^2{\ell_k}}{\partial{x}_k\partial{u_k}}\\
\frac{\partial^2{\ell_k}}{\partial{x}_k\partial{u_k}} & \frac{\partial^2{\ell_k}}{\partial{u}_k^2}\
  \end{array} \right]\left [ \begin{array}{c}
\delta{x}_k \\
\delta{u}_k\\
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
\ell_{xx|k}&=\frac{\partial^2\ell_k}{\partial{x_k}^2} \\
\ell_{xu|k}&= \frac{\partial^2\ell_k}{\partial{x_k}\partial{u_k}}\\
l_{ux|k}&= \frac{\partial^2\ell_k}{\partial{u_k}\partial{x_k}}\\
\ell_{uu|k}&=\frac{\partial^2\ell_k}{\partial{u_k}^2} \\
\ell_{x|k}&=\frac{\partial\ell_k}{\partial{x_k}}\\
\ell_{u|k}&=\frac{\partial\ell_k}{\partial{u_k}} \\
\end{aligned}
\end{equation}
\tag{2.4}
\right.
$$
其中$\ell_{xx|k}$下标中$x$表示$\ell$对$x$求一次偏导数， $x$在下标中出现两次表示求的是二阶偏导， 下标$k$表示的是在离散后的系统中是第k步(轨迹中的第k个状态点), 这样定义方便我们理解后文中的递推过程。
#### 动态规划递推方程及初值
在递推过程中我们用到了[贝尔曼优化思想](https://en.wikipedia.org/wiki/Bellman_equation), 在我们的问题中可表述如下:
首先定义价值函数V为从最后一步N到第k步的代价和(我们后面也是从后向前递推):
$$
\begin{equation}
\begin{aligned}
V_k=min(\ell_f(x_N)+\sum^{N-k}_k{\ell_i(x_i, u_i)})
\end{aligned}
\end{equation}
\tag{2.5}
$$
由于贝尔曼法则(无论系统的初始状态是什么， 系统的最优决策一定是系统在任意最优状态下面的决策都是最优的， 也即系统的最优代价$J_N^*$一定包含$J_k^*$(第k步的最优代价), 其中$k<N$), 对于我们定义的价值函数V， 有: 
$$ 
\begin{equation}
\begin{aligned}
V_k&=min(l_f(x_N)+\sum^{N-k}_k{l_i(x_i, u_)}) \\
&=min(l_k(x_k, u_k)+l_f(x_N)+\sum^{N-K-1}_{k+1}l_i(x_i, u_i)) \\
&=min(l_k(x_k, u_k)+min(l_f(x_N)+\sum^{N-K-1}_{k+1}l_i(x_i, u_i))) \\
&=min(l_k(x_k, u_k)+V_{k+1})
\end{aligned}
\end{equation}
\tag{2.6}
$$
式2.6即我们递归关系式推导的核心, 我们定义Q函数(在贝尔曼公式中称为动作价值函数， 即考虑控制量$u_k$的待优化目标函数):
$$
\begin{equation}
\begin{aligned}
Q_k&=l_k(x_k, u_k)+V_{k+1}(x_{k+1}) \\
&=l_k(x_k, u_k)+V_{k+1}(f(x_k, u_k))
\end{aligned}
\end{equation}
\tag{2.7}
$$
> 注意式2.7中， 我们得到了$Q_k$关于($x_k$, $u_k$)的函数， 其中$\ell_k$的函数是给定的， 我们只需要知道V的函数表达式，便可以应用极值原理令$\frac{\partial{Q_k}}{\partial{u_k}}=0$得到$u_k^*$
---

下面来推导价值函数$V$的形式:
式2.6又可以写为:
$$
\begin{equation}
\begin{aligned}
V_k=min(Q_k)=Q(x_k, u_k^*) = Q_k^*
\end{aligned}
\end{equation}
\tag{2.8}
$$
**即优化后的$Q_k$即为$V_k$, 假设我们已经知道第k步的控制量(决策变量)$u_k^*$, 那么$V_k$是关于$x_k$的函数， 注意在这一步未优化前的$Q_k$是关于$x_k$,$u_k$的函数**
然后我们将$V_k$在$\overline{x}_k$附近进而二阶泰勒展开:
$$
\begin{equation}
\begin{aligned}
V_k(\overline{x}_k+\delta{x_k}) &= V_k(\overline{x}_k) + \delta{V_k} \\
&=V_k(\overline{x}_k)+\frac{\partial{V_k}}{\partial{x_k}}\delta{x_k}+\frac{1}{2}\delta{x_k}^T\frac{\partial^2{V_k}}{\partial{x_k}^2}\delta{x_k}
\end{aligned}
\end{equation}
\tag{2.9}
$$
为了与LQR的推导中的符号系统保持一致， 我们定义:
$$
\left\{
\begin{equation}
\begin{aligned}
s_k&=\frac{\partial{V_k}}{\partial{x_k}} \\
S_k&= \frac{\partial^2{V_k}}{\partial{x_k}^2}\\
\end{aligned}
\end{equation}
\tag{2.10}
\right.
$$
于是，由式2.9和式2.10有:
$$
\begin{equation}
\begin{aligned}
\delta{V_k}=s_k\delta{x_k}+\frac{1}{2}\delta{x_k}^TS_k\delta{x_k}
\end{aligned}
\end{equation}
\tag{2.11}
$$
---
现在我们得到了接下来， 我们需要去求解$s_k$, $S_k$:
我们把$Q_k$在($\overline{x}_k$, $\overline{u}_k$)处进行二阶泰勒展开(其形式与式2.2、2.3一致) :
$$
\begin{equation}
\begin{aligned}
&\quad Q_k(x_k+\delta{x}_k,u_k+\delta{u}_k)= 
 Q_k(\overline{x}_k, \overline{u}_k)+\delta{Q_k}  \\
&\approx Q_k(\overline{x}_k, \overline{u}_k)+\frac{\partial{Q}}{\partial{x_k}}(x_k-\overline{x}_k)+\frac{1}{2}(x_k-\overline{x}_k)^T\frac{\partial^2Q}{\partial{x_k}^2}(x_k-\overline{x}_k) \\
& \quad +\frac{\partial{Q}}{\partial{u_k}}(u_k-\overline{u}_k)+\frac{1}{2}(u_k-\overline{u}_k)^T\frac{\partial^2Q}{\partial{u_k}^2}(u_k-\overline{u}_k) \\
& \quad +\frac{1}{2}(x_k-\overline{x}_k)^T\frac{\partial{Q}}{\partial{x_k}}\frac{\partial{Q}}{\partial{u_k}}(u_k-\overline{u}_k) \\
& \quad +\frac{1}{2}(u_k-\overline{u}_k)^T\frac{\partial{Q}}{\partial{u_k}}\frac{\partial{Q}}{\partial{x_k}}(x_k-\overline{x}_k)
\end{aligned}
\end{equation}
\tag{2.12}
$$
整理为矩阵形式: 
$$
\begin{equation}
\begin{aligned}
\delta{Q}_k=\left [ \begin{array}{c}
\delta{x}_k \\
\delta{u}_k\\
  \end{array} \right]^T \left [ \begin{array}{c}
\frac{\partial{Q_k}}{\partial{x}_k} \\
\frac{\partial{Q_k}}{\partial{u}_k}\\
  \end{array} \right]+ \frac{1}{2}\left [ \begin{array}{c}
\delta{x}_k \\
\delta{u}_k\\
  \end{array} \right]^T\left [ \begin{array}{cc}
 \frac{\partial^2{Q_k}}{\partial{x}_k^2} &  \frac{\partial^2{Q_k}}{\partial{x}_k\partial{u_k}}\\
\frac{\partial^2{Q_k}}{\partial{x}_k\partial{u_k}} & \frac{\partial^2{Q_k}}{\partial{u}_k^2}\
  \end{array} \right]\left [ \begin{array}{c}
\delta{x}_k \\
\delta{u}_k\\
  \end{array} \right]
\end{aligned}
\end{equation}
\tag{2.13}
$$
类似2.4， 我们定义如下偏导矩阵(方便后文推导): 
$$
\left\{
\begin{equation}
\begin{aligned}
Q_{xx|k}&=\frac{\partial^2Q_k}{\partial{x_k}^2} \\
Q_{xu|k}&= \frac{\partial^2Q_k}{\partial{x_k}\partial{u_k}}\\
Q_{ux|k}&= \frac{\partial^2Q_k}{\partial{u_k}\partial{x_k}}\\
Q_{uu|k}&=\frac{\partial^2Q_k}{\partial{u_k}^2} \\
Q_{x|k}&=\frac{\partial{Q}_k}{\partial{x_k}} \\
Q_{u|k}&=\frac{\partial{Q}_k}{\partial{u_k}} \\
\end{aligned}
\end{equation}
\tag{2.14}
\right.
$$
将2.14带入2.13， 有:
$$
\begin{equation}
\begin{aligned}
\delta{Q}_k=\left [ \begin{array}{c}
\delta{x}_k \\
\delta{u}_k\\
  \end{array} \right]^T \left [ \begin{array}{c}
Q_{x|k} \\
Q_{u|k}\\
  \end{array} \right]+ \frac{1}{2}\left [ \begin{array}{c}
\delta{x}_k \\
\delta{u}_k\\
  \end{array} \right]^T\left [ \begin{array}{cc}
 Q_{xx|k} &  Q_{xu|k}\\
Q_{ux|k} & Q_{uu|k}
  \end{array} \right]\left [ \begin{array}{c}
\delta{x}_k \\
\delta{u}_k\\
  \end{array} \right]
\end{aligned}
\end{equation}
\tag{2.15}
$$
又由式2.7及1.2容易知道， 如果对里面各项施加扰动($\delta{x}_k$, $\delta{u}_k$), 有:
$$
\begin{equation}
\begin{aligned}
Q_k(\overline{x}_k+\delta{x}_k, \overline{u}_k+\delta{u}_k)&=Q_k(\overline{x}_k, \overline{u}_k)+\delta{Q}_k \\ 
&=\ell_k(\overline{x}_k+\delta{x}_k, \overline{u}_k+\delta{u}_k) \\
&\quad +V_{k+1}(f(\overline{x}_k+\delta{x}_k, \overline{u}_k+\delta{u}_k)) \\
&=\ell_k(\overline{x}_k+\delta{x}_k, \overline{u}_k+\delta{u}_k) \\
& \quad +V_{k+1}(\overline{x}_{k+1}+\delta{x}_{k+1}) \\
&=\ell_k(\overline{x}_k, \overline{u}_k)+\delta{l}_k \\
& \quad +V(\overline{x}_{k+1})+\delta{V_{k+1}}
\end{aligned}
\end{equation}
\tag{2.16}
$$
由上式及2.7我们知道:
$$
\begin{equation}
\begin{aligned}
\delta{Q}_k=\delta{l}_k+\delta{V_{k+1}}
\end{aligned}
\end{equation}
\tag{2.17}
$$
我们把式2.3、2.4、2.13、2.14带入上式， 得:
$$
\begin{equation}
\begin{aligned}
\delta{Q}_k&=\left [ \begin{array}{c}
\delta{x}_k \\
\delta{u}_k\\
  \end{array} \right]^T \left [ \begin{array}{c}
\ell_{x|k} \\
\ell_{u|k}\\
  \end{array} \right]+ \frac{1}{2}\left [ \begin{array}{c}
\delta{x}_k \\
\delta{u}_k\\
  \end{array} \right]^T\left [ \begin{array}{cc}
 \ell_{xx|k} &  \ell_{xu|k}\\
\ell_{ux|k} & \ell_{uu|k}\
  \end{array} \right]\left [ \begin{array}{c}
\delta{x}_k \\
\delta{u}_k\\
  \end{array} \right] \\
  & \quad + s_{k+1}\delta{x_{k+1}}+\frac{1}{2}\delta{x_{k+1}}^TS_{k+1}\delta{x_{k+1}}
\end{aligned}
\end{equation}
\tag{2.18}
$$
然后我们把式1.3带入式2.18， 整理得:
$$
\begin{equation}
\begin{aligned}
&\delta{Q}_k=\left [ \begin{array}{c}
\delta{x}_k \\
\delta{u}_k\\
  \end{array} \right]^T \left [ \begin{array}{c}
\ell_{x|k}+A_k^Ts_{k+1}^T \\
\ell_{u|k}+B_k^Ts_{k+1}^T \\
  \end{array} \right] \\
&+ \frac{1}{2}\left [ \begin{array}{c}
\delta{x}_k \\
\delta{u}_k\\
  \end{array} \right]^T\left [ \begin{array}{cc}
 \ell_{xx|k}+A_k^TS_{k+1}A_k &  \ell_{xu|k} + A_k^TS_{k+1}B_k\\
	\ell_{ux|k}+B_k^TS_{k+1}A_k & \ell_{uu|k} + B_k^TS_{k+1}B_k
  \end{array} \right]\left [ \begin{array}{c}
\delta{x}_k \\
\delta{u}_k\\
  \end{array} \right] 
\end{aligned}
\end{equation}
\tag{2.19}
$$
对比式2.19、2.15可知:
$$
\left\{
\begin{equation}
\begin{aligned}
Q_{xx|k}&=\frac{\partial^2Q_k}{\partial{x_k}^2}=\ell_{xx|k}+A_k^TS_{k+1}A_k\\
Q_{xu|k}&= \frac{\partial^2Q_k}{\partial{x_k}\partial{u_k}}=\ell_{xu|k}+A_k^TS_{k+1}B_k\\
Q_{ux|k}&= \frac{\partial^2Q_k}{\partial{u_k}\partial{x_k}}=\ell_{ux|k}+B_k^TS_{k+1}A_k\\
Q_{uu|k}&=\frac{\partial^2Q_k}{\partial{u_k}^2}=\ell_{uu|k} + B_k^TS_{k+1}B_k \\
Q_{x|k}&=\frac{\partial{Q}_k}{\partial{x_k}}=\ell_{x|k}+A_k^Ts_{k+1}^T \\
Q_{u|k}&=\frac{\partial{Q}_k}{\partial{u_k}}=\ell_{x|k}+A_k^Ts_{k+1}^T \\
\end{aligned}
\end{equation}
\tag{2.20}
\right.
$$
式2.19意味着当前第k步的Q的一、二阶偏导数，可以由第k步的$\ell_k$的偏导数及上一步的$s_{k+1}$, $S_{k+1}$推导得出。

---
上一步的$s_{k+1}$, $S_{k+1}$为已知量， 故推导到现在$Q_k$的一、二阶偏导数也是已知量。故当前步的$\delta{Q_k}$的函数表达式也是已知的了， 下面我们来求$u_k^*$, 由式2.8、2.12可知:
$$
\begin{equation}
\begin{aligned}
V_k=min(Q_k)=min(Q_k(\overline{x}_k, \overline{u}_k) + \delta{Q_k})
\end{aligned}
\end{equation}
\tag{2.21}
$$
式2.20中$Q_k(\overline{x}_k, \overline{u}_k)$为常数项(即上条轨迹上对的代价)， 可忽略，于是求$min(Q_k)$等价于求$min(\delta{Q_k})$。
我们先把式2.15的矩阵形式展开， 方便下一步求$\frac{\partial}{\partial{(\delta{u_k})}}$的操作:
$$
\begin{equation}
\begin{aligned}
\delta{Q}_k&=\delta{x_k}^TQ_{x|k}+\delta{u_k}^TQ_{u|k} \\
& \quad +\frac{1}{2}\delta{x_k}^TQ_{xx|k}\delta{x_k}+\frac{1}{2}\delta{x_k}^TQ_{xu|k}\delta{u_k} \\
& \quad +\frac{1}{2}\delta{u_k}^TQ_{ux|k}\delta{x_k}+\frac{1}{2}\delta{u_k}^TQ_{uu|k}\delta{u_k} \\
&= \delta{x_k}^TQ_{x|k}+Q_{u|k}^T\delta{u_k} \\
& \quad +\frac{1}{2}\delta{x_k}^TQ_{xx|k}\delta{x_k}+\frac{1}{2}\delta{x_k}^TQ_{xu|k}\delta{u_k} \\
& \quad +\frac{1}{2}\delta{x_k}^TQ_{ux|k}^T\delta{u_k}+\frac{1}{2}\delta{u_k}^TQ_{uu|k}\delta{u_k} \\
\end{aligned}
\end{equation}
\tag{2.22}
$$
> 上面整理过程中用到了$\delta{u_k}^TQ_{ux|k}\delta{x_k}=\delta{x_k}^TQ_{ux|k}^T\delta{u_k}$及  
> $\delta{u_k}^TQ_{u|k}=Q_{u|k}^T\delta{u_k}$, 因为等式两边均为标量。

根据极值原理， 我们对式2.22两侧求$\delta{u_k}$的偏导:
$$
\begin{equation}
\begin{aligned}
\frac{\partial(\delta{Q_k})}{\partial(\delta{u_k})}&=Q_{u|k}+\frac{1}{2}(Q_{xu|k}^T+Q_{ux|k})\delta{x_k}+\frac{1}{2}(Q_{uu|k}+Q_{uu_k}^T)\delta{u_k} \\
&=Q_{u|k}+Q_{xu|k}\delta{x_k}+Q_{uu|k}\delta{u_k}
\end{aligned}
\end{equation}
\tag{2.23}
$$
>上面的整理过程中用到了标量函数的二阶矩阵偏导为对称阵这个事实，有$Q_{ux|k}=Q_{xu|k}^T$, $Q_{xx|k}=Q_{xx|k}^T$, $Q_{uu|k}=Q_{uu|k}^T$, 可参考[黑塞矩阵wiki](https://zh.wikipedia.org/wiki/%E9%BB%91%E5%A1%9E%E7%9F%A9%E9%99%A3) 

接下来令是是2.23中$\frac{\partial(\delta{Q_k})}{\partial(\delta{u_k})}=0$， 求得:
$$
\begin{equation}
\begin{aligned}
u_k^*&=-Q_{uu|k}^{-1}(Q_{u|k}+Q_{xu|k}\delta{x_k}) \\
&=-Q_{uu|k}^{-1}Q_{u|k}+-Q_{uu|k}^{-1}Q_{xu|k}\delta{x_k} \\
&=d+K\delta{x_k}
\end{aligned}
\end{equation}
\tag{2.24}
$$
> 注意上式中$Q_{uu|k}^{-1}$不一定存在, 且$\frac{\partial^2(\delta{Q_k})}{\partial(\delta{u_k})^2}>0$未必成立，这时便需要进行正则化及稳定的数值解法。本文的主要目的是说明iLQR的算法原理及流程， 其数值解法暂不讨论。








### 背景知识
1. 矩阵求导(见[[LQR控制器]]中的附录)
2. 关于二元向量的标量函数的一阶、二阶泰勒展开公式: 

