### Core Concept
- 一般是基于DP搜索的， 其搜索框架为J(x, u)=g(x)+h(x, u), 其中J为代价函数， g(x)为cost-so-far, h(x, u)为cost-to-go, 搜索的目标是让J(x, u)全局最小。