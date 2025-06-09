### Core concept
LQR全称为linear quadratic regulater, 即线性二次型调节器。
LQR属于最优控制的一种， 最优控制一般要求我们知道系统的模型， 并有一个Cost优化目标。
从LQR的名字我们可以看出: 
1. 需要系统模型为线性系统， 或者至少可以本地线性化;
2. 对于系统的状态稳定在零点
3. 其代价函数J为二次型的形式
### LQR控制器推导
#### 系统状态转移方程
$$
\begin{matrix}
x_{k+1}=f(x_{k},u_{k})&==A{\times}x_k+B{\times}u_k \\
\end{matrix}
\tag{1.1}
$$
上面状态转移矩阵为离散形式， 对于非线性函数的线性化、离散化参考[[MPC控制算法推导]]
对于完全可观系统$y_k = x_k$
#### 代价\目标\价值函数
$$
\begin{equation}
J(x_0, U)=min\sum{c(x_k, u_k)} = x_N^TQ_Nx_N+min\sum_{k=0}^{N-1}{(x_k^TQ_kx_k+u_k^TR_ku_k)}
\tag{1.2}
\end{equation}
$$
其中$x, u$为系统状态、控制输入向量。$x_N^TQ_Nx_N$为终端代价， 用来保证系统最终的状态收敛到0， 确保系统是稳定的。
> 注意: 代价函数为标量， 这个性质会简化到后文的一写推导。对于标量有: $J=J^T$
> $Q_k$, $R_k$均为对角矩阵(对称， 正定, 具有良好的性质， 保证后续求解方便)

影响上述代价函数的变量为$U=(u_0,u_1,...,u_{N-1})$， 其中$x_0$为当前系统的状态为已知量(可以通过测量或者估计得到)。
#### 动态规划递推
动态规划的原理基于贝尔曼法则(bellman's pricinple, 是优化理论的基石):
> An optimal policy has the property that whatever the initial state and initial decision are, the remaining decision must consitute an optimal policy with regard to the state resulting from first decision.

也就是说无论系统的初始状态是什么， 系统的最优决策一定是系统在任意最优状态下面的决策都是最优的， 也即系统的最优代价$J_N^*$一定包含$J_k^*$(第k步的最优代价), 其中$k<N$， 也意味这系统在优化代价函数的前提下， **全局** 仅有一个最优解$U^*$(也即最优决策)

下面通过动态规划的方法求使得代价函数为最小值$J^*$的$U^*$.
显然有: 
$$
J_N^* = \frac{1}{2}x_N^TQ_Nx_N+min\sum_{k=0}^{N-1}{\frac{1}{2}(x_k^TQ_kx_k+u_k^TR_ku_k)} = \frac{1}{2}x_N^TQ_Nx_N + J_{N-1}^*
\tag{1.3}
$$
当运行到第N步的时候，$J_{N-1}^*$为已知量(发生在过去)，定义一个每一步决策要优化的函数代表未来的剩余最优代价(Cost-to-go)为V_k, 那么，
$$ 
V_N = \frac{1}{2}x_N^TQ_Nx_N=\frac{1}{2}x_N^TS_Nx_N
\tag{1.4}
$$
其中$S_N$为新定义的Cost-to-go最优代价二次型的矩阵， 方便后文统一描述。
这一步不包含决策变量$u_k$， 故不需要优化， 我们向前递推一步:
$$
V_{N-1} = \frac{1}{2}x_N^TS_Nx_N+\frac{1}{2}(x_{N-1}^TQ_kx_{N-1}+u_{N-1}^TR_ku_{N-1})
\tag{1.5}
$$
第N-1不的决策$u_{N-1}$是基于$x_{N-1}$的， 系统在$u_{N-2}$的作用下已经运行到$x_{N-1}$， 为已知量。那么这一步我们要做的决策是$u_{N-1}$, 又由式$(1.1)$, $x_N$也是由$u_{N-1}$,$x_{N-1}$决定的， 故将式$(1.1)$代入$x_N$， $V_{N-1}(x_{N-1}, u_{N-1})$仅与$u_{N-1}$决策变量有关， 展开如下: 
$$
\begin{equation}
\begin{aligned}
V_{N-1} &= \frac{1}{2}(A_{N-1}x_{N-1}+B_{N-1}u_{N-1})^TS_N(A_{N-1}x_{N-1}+B_{N-1}u_{N-1})\\
&+\frac{1}{2}(x_{N-1}^TQ_{N-1}x_{N-1}+u_{N-1}^TR_{N-1}u_{N-1}) \\
\end{aligned}
\end{equation}
\tag{1.5}
$$
对$V_{N-1}$求$u_{N-1}$的偏导$\frac{\partial{V_{N-1}}}{\partial{u_{N-1}}}$,
$$
\begin{equation}
\begin{aligned}
\frac{\partial{V_{N-1}}}{\partial{u_{N-1}}} &= B_{N-1}^TS_N(A_{N-1}x_{N-1}+B_{N-1}u_{N-1})+R_{N-1}u_{N-1}
\end{aligned}
\end{equation}
\tag{1.6}
$$
V_{N-1}对$u_{N-1}$求二阶导数:
$$
\frac{\partial^2{V_{N-1}}}{\partial{u_{N-1}}^2} = B_{N-1}^TS_NB_{N-1}+R_{N-1} > 0
\tag{1.7}
$$
故其极值为最小值， 令$\frac{\partial{V_{N-1}}}{\partial{u_{N-1}}}=0$, 可求得:
$$
\begin{equation}
\begin{aligned}
u_{N-1}^* &= -(B_N^TS_NB_N+R_{N-1})^{-1}B_N^TS_NA_{N-1}x_{N-1}\\
&=-K_{N-1}x_{N-1}
\end{aligned}
\end{equation}
\tag{1.8}
$$
> $B_N^TS_NB_N+R_{N-1}$为正定方阵，其逆保证存在。 

可以看出第N-1步的控制输入为状态$x_{N-1}$的全状态负反馈， 将这个第N-1步的最优控制量代回$(1.5)$, 有
$$
\begin{equation}
\begin{aligned}
V_{N-1} &= \frac{1}{2}x_{N-1}^T[(A_{N-1}-B_{N-1}K_{N-1})^TS_N(A_{N-1}-B_{N-1}K_{N-1})+Q_{N-1}+K_{N-1}^TR_{N-1}K_{N-1}]x_{N-1} \\
&=\frac{1}{2}x_{N-1}^TS_{N-1}x_{N-1}
\end{aligned}
\end{equation}
\tag{1.9}
$$
发现式$(1.9)$与式$(1.4)$形式一样， 故每一步的最优控制量$u_k$都是当前步$x_k$的全状态负反馈，有:
$$
\left\{\begin{matrix}
S_N=Q_N\\
S_k=(A_k-B_kK_k)^TS_{k+1}(A_k-B_kK_k)+Q_k+K_{k}^TR_kK_k \\
K_k=(B_{k+1}^TS_{k+1}B_{k+1}+R_k)^{-1}B_{k+1}^TS_{k+1}A_k \\
u_k^* = -K_kx_k
\tag{2.0}
\end{matrix}\right.
$$
由于$S_N$已知(是我们设定的)， 于是我们可以递归的向前求解$K_K, S_k，u_k$, 直到$K_0$, 这样我们就得到了使$J$最小化的最优控制策略$U=(-K_0x_0, -K_1x_1,...,-K_{N-1}x_{N-1})$

> 如果系统为线性时不变系统且完全可控， 系统的稳定时间为无穷大， 那么$K_k$将会收敛为常数矩阵K。

至此我们得到了递推关系式， 总结如下: 
#### Backward and Forward

#### 算法框架
### 矩阵运算背景知识
注意: 上面的求导需要利用以下矩阵求导公式(分子布局):

$$
\left\{\begin{matrix}
\frac{\partial{(Au)}}{\partial{u}}=A^T \\
\frac{\partial{(u^TAu)}}{\partial{u}} = Au + A^Tu \\
\frac{\partial{J(y(u))}}{\partial{u}}=\frac{\partial{y}}{\partial{u}}\frac{\partial{J}}{\partial{y}}
\tag{1.7}
\end{matrix}\right.
$$