
### 概念
C++是一个语言大杂烩，主要有四种编程范式:
1. 面向过程
2. 面向对象
3. 泛型编程
4. 元编程(meta programming)
关于动态编译(.so)与静态编译（.lib）
#### 基于对象与面向对象
- 继承
	继承实际在一定程度上破坏了封装。 推荐使用has a (composit)代替 is a
- 封装
- 多态
##### big five
- 构造拷贝(constructor copy)
- 赋值拷贝(assignment copy) 
- 移动构造(move copy)
- 移动赋值(move constructor)
- 析构函数
	1. 用来释放内存资源, 否则会导致内存泄漏/溢出
	2. 销毁对象的非static数据成员(析构函数体结束后)
> 基于对象与面向对象的关键区别在于是否合理抽象
#### 泛型编程及元编程

### syntax(语法)
#### 内置数据类型(包含容器)
#### std:: string
多行字符串的跨行: 
在 C++ 中，多个相邻的字符串字面量会被自动连接成一个单独的字符串。因此，虽然你的字符串在源代码中跨越了多行，但在程序中它们会被视为一个连续的字符串。
```cpp
LOG(ERROR) << "Aborting because a valid control could not be found. " 
			"Even after executing all recovery behaviors";
```
##### 枚举类型(enum)
```cpp
enum conditon {
	a = 0,
	b, 
	c,
	count, // 这样可以很方便的统计条件的数量
}
```
#### 算数运算
- 运算符的优先级(随行递减，同行取决于位置，左边比右边优先级高)
	1. NOT !
	2. \*, /, %
	3. +, -
	4. <, >，<=, >= 
	5. && AND
	6. || OR
	7. =  (assignment)
- 比较运算符号

> (a && b ) 中如果a表达式为false， b表达式是不会被执行的
#### 判断与循环

##### switch
可以处理条件比较多的情况
```cpp
int a = 0; // 1, 2 ..
switch(a){
	case 0: {
	} break;
	case 1:
	case 2: { // merge condition
	} break;
	default:
		break;
}
```
> `switch` 结合`enum`可以实现一个简单的状态机:

```cpp
enum Data {wait, get, processing}
Data data = Data::wait


swith(data){
case wait:{
	if(...) data = get

}break;
default: break;
}

```
#### 指针的概念模型
C++中的指针概念继承自C， 并发展出了对象中的智能指针。
- 基本操作
```cpp
#include <iostream>

int main() {
    int* ptr = new int(10); // 动态分配一个整数

    // 在删除前检查指针是否不为 nullptr
    if (ptr != nullptr) {
        delete ptr;  // 释放内存
        ptr = nullptr; // 将指针设为 nullptr 防止悬挂指针
    }

    // 再次检查指针以验证其是否已被删除
    if (ptr == nullptr) {
        std::cout << "Pointer successfully deleted and set to nullptr." << std::endl;
    }

    return 0;
}

```
### 异常处理
#### 基本机制`try-catch-throw`
- try: 对容易出现异常的地方使用try{}包裹
- catch: 紧跟try, 负责捕获try{}中抛出的异常
- throw:
理论上可能抛出任何类型，但是必须事知道
```cpp
try {

} catch(...) { //可以捕获任意类型

}
// catch(const std::exception& e) //可捕获标准库类型及其衍生类型
```
#### static关键字

##### class中的static
- 修饰类成员
表示在类的作用域内可与多个对象共享， 不与对象及this指针绑定
有点属性的意思
- 修饰类成员函数
与对象无关， 函数内无this指针， 不参与虚表， 可以封装工具函数
有点方法的意思
### I/0操作
#### 文件写入竞争
##### 原子写入
```cpp
void atomicWriteYaml(const std::string& filename, const YAML::Node& node) {
    std::string tempFilename = filename + ".tmp";

    // 使用yaml-cpp写入临时文件
    std::ofstream tempFile(tempFilename);
    if (tempFile.is_open()) {
        tempFile << node;
        tempFile.close();
    } else {
        std::cerr << "Unable to open temporary file" << std::endl;
        return;
    }

    // 原子性重命名临时文件为目标文件
    if (std::rename(tempFilename.c_str(), filename.c_str()) != 0) {
        std::cerr << "Error renaming temporary file" << std::endl;
    }
}
```
##### 文件锁
```cpp

```

##### 调用外部脚本
```cpp
#include <cstdio>
#include <cstdlib>
#include <iostream>

int main() {
    FILE *fp;
    char buffer[1000];

    // 假设 navigation_bash_file_ 是一个字符串，包含要执行的 Bash 文件路径
    std::string navigation_bash_file_ = "/path/to/your/script.sh"; 

    // 使用 popen 打开管道，以读方式执行 shell 命令
    fp = popen(navigation_bash_file_.c_str(), "r");
    if (fp == nullptr) {
        std::cerr << "Error: Failed to open pipe\n";
        return 1;
    }

    // 读取并输出 shell 脚本的标准输出
    while (fgets(buffer, sizeof(buffer), fp) != nullptr) {
        printf("%s", buffer);
    }

    // 关闭管道
    int ret_code = pclose(fp);
    if (ret_code == -1) {
        std::cerr << "Error: Failed to close pipe\n";
        return 1;
    }

    return 0;
}
```
> 建议仅用于简单系统命令， 切不要用于多线程环境中
### 泛型编程 (`template`)
- 模板函数
```cpp
template <class Tl, class T2>
T2 print(T1 argl, T2 arg2)
{
    cout << arg1 << " " << arg2 << endl;
    return arg2;
}
```
> 注意: 模板函数的实现也应放在头文件中，否则可能出现链接问题

### 右值引用与std::move
- 左值引用与右值引用
左值引用：类型 &引用名 = 左值表达式
右值引用：类型 && 引用名 = 右值表达式（右值引用主要用来绑定临时对象）

### lamda表达式
发现可以使用lamda表达式写一些泛化并不强的小函数(用完既扔), 也能作为functer使用，并且可以减少代码量与可读性。
下面以cout输出为例：
```C++
// 变量捕获方式
auto a = [=](){/*do something*/};// 所有当前域内可见的变量按值捕获
auto a = [&](){/*do something*/};// 所有当前域内可见的变量按引用捕获
// 捕获某个值?

auto coutPair = [](std::string a, double parameter){
	std::cout << a << "\t" << parameter << std::endl;
};
```
> 注意最后的分号

### this指针
在类的非静态函数中可以使用this指针。代表指向对象的“虚拟”指针，代表了绑定关系。
> 与python class 中的self类似
### 技巧
- 使用"前置声明"来避免头文件递归包含
前置声明允许你告诉编译器有一个名`classname`的类存在，尽管它的定义并没有在当前文件中提供。
```cpp
namespace PathOptimizationNS {
    class classname;  // Forward declaration of the class

    // Now you can use State as a pointer or reference
    classname* statePtr;
}
```

### 常用头文件
- C++ assert.h头文件
ssert.h是c标准库的一个头文件，该头文件的主要目的就是提供一个assert的宏定义。assert只是对所给的表达式求值，就像if判断语句中一样，然后如果该值为真则正常运行，否则报错，并调用abort(),产生异常中断，exit出来。
assert.h之前＃define NDEBUG可使assert什么都不做.
```C++
// uncomment to disable assert()
// #define NDEBUG
#include <cassert>
```
### flags 关键字
- override
为虚函数重载覆盖标志， 在子类中重新定义父类中已经定义的虚函数。
- 只应用在虚函数身上，子类重写基类的虚函数，其函数签名应该相同，该关键字的主要目的是帮助编译器进行检查。
```C++
#include <iostream>
 
struct A
{
    virtual void foo();
    void bar();
    virtual ~A();
};
 
// member functions definitions of struct A:
void A::foo() { [std::cout](http://en.cppreference.com/w/cpp/io/cout) << "A::foo();\n"; }
A::~A() { [std::cout](http://en.cppreference.com/w/cpp/io/cout) << "A::~A();\n"; }
 
struct B : A
{
//  void foo() const override; // Error: B::foo does not override A::foo
                               // (signature mismatch)
    void foo() override; // OK: B::foo overrides A::foo
//  void bar() override; // Error: A::bar is not virtual
    ~B() override; // OK: `override` can also be applied to virtual
                   // special member functions, e.g. destructors
    void override(); // OK, member function name, not a reserved keyword
};
 
// member functions definitions of struct B:
void B::foo() { [std::cout](http://en.cppreference.com/w/cpp/io/cout) << "B::foo();\n"; }
B::~B() { [std::cout](http://en.cppreference.com/w/cpp/io/cout) << "B::~B();\n"; }
void B::override() { [std::cout](http://en.cppreference.com/w/cpp/io/cout) << "B::override();\n"; }
 
int main() {
    B b;
    b.foo();
    b.override(); // OK, invokes the member function `override()`
    int override{42}; // OK, defines an integer variable
    [std::cout](http://en.cppreference.com/w/cpp/io/cout) << "override: " << override << '\n';
}
////////////////////////////////////////////////////////////////////
OUTPUT
B::foo();
B::override();
override: 42
B::~B();
A::~A();
////////////////////////////////////////////////////////////////////
				
```

- =default & = delete
C++如果结构或者类没有明确声明默认函数（构造函数，拷贝构造， 析构函数），那么编译器会在需要的时候生成默认版本，这可能会引发非预期的行为。
=default是明确告诉编译器要生成默认版本(如果你写了构造函数就没有默认构造函数，如果要衍生子类则很有用  )，
=delete是明确告诉编译器**禁止**生成默认版本
> 如果已经定义了构造函数， 那么编译器默认不会生成默认构造函数

主要目的是通过显式声明（explicitly）来避免非预期的行为
在C++11以前，主要是通过将不想让编译器生成的默认函数定义为private来阻止编译器。
其代码如下：
```C++
struct noncopyable { 
	noncopyable() {};
private: 
	noncopyable(const noncopyable&); 
	noncopyable& operator=(const noncopyable&); 
};
class son : private nocopyable{

};
```
> 如果设置为delete, big three function都会不可用，这意味着你确实需要写一个赋值拷贝的构造
-  constexpr
C++以后新增的flag, 声明常量值变量，在编译后会作为inline代码（换句话说，不存在于内存空间当中，相当与define）
- inline
内联函数， 将对每次函数调用在编译的时候插入对应代码， 可以提升函数调用性能， 但是会增大编译文件大小(通常在现代电脑上不是问题)
> 在类内定义的函数， 默认为inline函数
### C++ 语法糖(grammer sugar)
- for的范围循环
传统的for循环对于复杂类型来说，需要书写大量语句，例如对
```C++
vector<int>
```
中的元素进行迭代其形式如下：
```C++
# include <vector>
# include <string>
using namespace std;
// test for-loop 
int main()
{
	vector<int> elements = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
	for(auto iter = elements.begin(), iter != elements.end(), ++iter){
		cout << *iter << '\t'; //print element in vector
	}
	cout << endl;

	return 0;
}
```
而C++11引入了利用迭代器范围的循环，配合auto这个自动推断类型的声明，可以让我们的代码变的简介，从而增强可读性（个人感觉有待你与python靠拢）。其形式为：
```C++
for(auto element : elements){
	cout << element << '\t';
}
```
还有一点需要注意的是for的范围循环返回的是序列的元素本身，而上面传统的基于迭代器的循环，返回的是指向元素的迭代器。
如果需要改动元素的内容则可以将元素声明为引用类型，形式如下：
```C++
for(auto& element : elements){
	element *= 2;//每个元素扩大两倍
}
```
- auto & decltype
auto 可以让编译器帮助我们解析变量类型，但是它要与赋值操作一起用，即推断返回值的类型。
其语法为：
```C++
auto item = var;
```
decltype与auto 有所不同，其推断值可以通过变量或表达式来推断，只用类型，而可以自己进行类型的初始话。其语法为：
```C++
int i =42, *p = &i, &r = i;
decltype(r + 0) = b;//括号中为表达式，则推断结果是表达式返回类型（int 而非 int&）
decltype(r) = i;// 括号中为变量，则其推断类型为变量类型
decltype((i)) d = i; //括号中再来一个小括号，返回该变量的引用，引用值必须初始化
// 模板参数
template <typename T>
void func(T&& param) {
    decltype(param) x = std::move(param);
    // ...
}
// 决定返回值
template <typename T> auto add(T a, T b) -> decltype(a + b) { return a + b; }
// 传入模板参数
auto cmp = [](const std::pair<int, int>& a, const std::pair<int, int>& b) { return a.second > b.second; }; std::priority_queue<std::pair<int, int>, std::vector<std::pair<int, int>>,  dectype(cmp)> pq;
```
item的类型将由var的类型推断得出。
需要注意的是，auto 会忽略顶层const（但是底层const会保留）。
-  类型别名
在标准库及第三方库当中经常可以看到类型别名（还有个常见的是模板）。把他们看懂了，对于我们理解代码有莫大的帮助。不过其实这两个都很容易理解只要稍微花些时间就可以掌握。
类型别名（type alias）就是对一个类型名称进行重新命名，这样做主要有一下两个好处：
	1. 利用类型别名，让复杂的类型变的简洁，从而降低理解的成本;
	2. 可以针对基础类型进行更高维度的抽象，有时候虽然类型本身并不复杂，但是在具体应用中可以让类型名称与业务相关，从而可以增进理解。
其语法很简单：
```C++
typedef double wages;
typedef double* wages_ptr;//通过名称可以理解其代指与类型
```
该语法也可以在类内使用:
```cpp
class A {
public:
	typedef double wages;
	using wages = double; // 现代C++推荐用法

private:
...
};
```

### Effective C++
1. 如果类成员函数不是virtual那么不要在继承的时候“重载”它(条款36)， 事实上类内根本没有重载机制， 而是名称遮盖机制(条款33)
### 疑难杂症 
- char* 与 C++ string之间的互相转换
1. std::string  to const char*(不可写)
```C++
std::string str;
const char* c_char = str.c_str();
```
2. std::string to char*(可写)
- 对于早期C++版本(该方式并非异常安全)：
```C++
std::string str;
char* c_char_writable = new char[str.size() + 1];
std::copy(str.begin(), str.end(), writable);
c_char_writable[str.size()] = '\0'; //don't foget the terminating

// when use finished, remember to delete the memory
delete[] c_char_writable;
```
3. 将string字符转换为ascii码
```C++
#include <cctype>
std::string s;
toascii(s[0])
```
4.  boost::scoped_array(异常安全)
```C++
std::string str;
boost::scoped_array<char> writable(new char[str.size() + 1]);
std::copy(str.begin(), str.end(), writable.get());
writable[str.size()] = '\0'; // don't forget the terminating 0

// get the char* using writable.get()

// memory is automatically freed if the smart pointer goes 
// out of scope
```
5. std::vector（异常安全），内存占用是所需的2倍
```cpp
std::string str;
std::vector<char> writable(str.begin(), str.end());
writable.push_back('\0');

// get the char* using &writable[0] or &*writable.begin()
```
6. std::string(快速)
```cpp
std::string foo{"text"};
auto p = &*foo.begin();
```
-  helper函数写在hpp文件中，多个地方引用时出现"多次定义错误"
	1. 对于helper函数，一般都是全局的，所以尽量将定义与实现分离
	2. hpp适于写类与结构体进行封装
	3. 声明为静态函数
	4. 利用匿名命名空间进行处理
 - inline 位于cpp文件中会报链接错误
 这是因为inline会直接在函数出现的地方替换函数代码， 故需要在编译的时候知道实现的代码，解决方案是不使用inline标志，或将其放在.hpp文件中
 -  类内常量引用成员如何进行处理?
	 1. 可以在构造函数初始化列表进行赋值
- 模板函数的使用
	1. 必须把实现写在.h文件中
  
