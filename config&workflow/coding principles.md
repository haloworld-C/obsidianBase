1. comment使用英文
2. 在变成过程中完成接口文档的编写，重视产品文档定义
3. 不直接copy代码，尤其是逻辑代码
4. 写code用vim, 看code用vscode
5. .hpp文件中完成定义+实现，无需编译即可使用，而.h应只定义声明，配合.cpp主要定义实现
6. 命名规范：
	- 变量命名：变量名称一律小写，单词间用下划线相连，类内变量词尾加"_"(结构体除外)
	- 类首字母及内部单词首字母均大写
	- 静态变量以k_开头，
	- 函数名称：小写字母开头，大小写混用
	- 引用头文件顺序：c头文件  标准库， 第三方库， 自定义库
	- 全局变量：以g_开头