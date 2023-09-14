### core concept
Lua是一种轻量级的、可嵌入的脚本语言，它支持过程式编程、面向对象编程、函数式编程等编程范式, 类似python
### 简明教程
#### 基本语法 
```lua
curvature = 0 --全局变量
function(time, value, v1)
	if (value ~= 0) then
		curvature = v1 / value
	end
	return curvature
```
