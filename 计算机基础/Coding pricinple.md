### 代码规范

### coding flow
1. 设计应自上而下, 从问题域开始设计
2. 在同一层次应先设计接口
3. 先实现，后优化
4. 编译前仔细检查代码（尽可能发现错误），可以有效检验自己对于概念理解的正确性;

### code principle
1. PPP(Pesuade program process)
2. 面向接口编程,面向问题编程
3. 小步变更
4. compile-test-commit(记录与管理变更)
5. 采用分解的思路很难有原创性
6. code into your language, NOT coding in your language
7. 在同一层次进行抽象(abstraction in same level)
#### Coding style pricinple
1. comment 用英文
2. 不直接copy代码，尤其是逻辑代码
3. 写code用vim， 看代码用vscode
4. 头文件hpp文件无需预编译，尽可能用（如果写为.h和.cpp则应遵循.h中定义接口，.cpp定义实现）
5. 在.h及.hpp中编写接口文档
6. 命名规范
	1. 变量一律小写，单词间用下划线相连。
	2. 类名采用驼峰命名，首字母大写
	3. 函数名称采用驼峰命名，首字母小写(不要害怕函数或变量名称很长)
	4. 静态变量s\_开头， 全局变量g\_开头， 引用变量r\_开头，类内变量m\_开头
	5. 常量全大写
	6. 类内变量不用使用前缀或后缀(可以使用this指针调用进行区分) 
7. 引用头文件顺序
	1. C头文件
	2. 标准库
	3. 第三方库
 #### best
  practice
 ##### 函数
 1. 函数参数尽量少(不要超过三个)
 2. 一个函数应该只做一件事