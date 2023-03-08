关于动态编译(dll)与静态编译（.lib）


## c语言补遗
### C语言当中的输出控制符

常用的输出控制符主要有以下几个：  

|控制符 |说明|
|---|---|
|%d |按十进制整型数据的实际长度输出。
|%ld|输出长整型数据。
|%md|m 为指定的输出字段的宽度。如果数据的位数小于 m，则左端补以空格，若大于 m，则按实际位数输出。
|%u |输出无符号整型（unsigned）。输出无符号整型时也可以用 %d，这时是将无符号转换成有符号数，然后输出。但编程的时候最好不要这么写，因为这样要进行一次转换，使 CPU 多做一次无用功。
|%c|用来输出一个字符。
|%f |用来输出实数，包括单精度和双精度，以小数形式输出。不指定字段宽度，由系统自动指定，整数部分全部输出，小数部分输出 6 位，超过 6 位的四舍五入。
|%.mf|输出实数时小数点后保留 m 位，注意 m 前面有个点。
|%o|以八进制整数形式输出，这个就用得很少了，了解一下就行了。
|%s|用来输出字符串。用 %s 输出字符串同前面直接输出字符串是一样的。但是此时要先定义字符数组或字符指针存储或指向字符串，这个稍后再讲。
|%x（或 %X 或 %#x 或 %#X）|以十六进制形式输出整数，这个很重要。

### 内存操作
```C++
  
void * memset ( void * ptr, int value, size_t num );//内存分配及初始化
void* memcpy( void* dest, const void* src, [std::size_t]//内存拷贝，需要知道内存大小
			 
```
### char* 与 C++ string之间的互相转换
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
- boost::scoped_array(异常安全)
```C++
std::string str;
boost::scoped_array<char> writable(new char[str.size() + 1]);
std::copy(str.begin(), str.end(), writable.get());
writable[str.size()] = '\0'; // don't forget the terminating 0

// get the char* using writable.get()

// memory is automatically freed if the smart pointer goes 
// out of scope
```
- std::vector（异常安全），内存占用是所需的2倍
```cpp
std::string str;
std::vector<char> writable(str.begin(), str.end());
writable.push_back('\0');

// get the char* using &writable[0] or &*writable.begin()
```
- std::string(快速)
```cpp
std::string foo{"text"};
auto p = &*foo.begin();
```
## C++
### 概念

#### 左值引用与右值引用
左值引用：类型 &引用名 = 左值表达式
右值引用：类型 && 引用名 = 右值表达式（右值引用主要用来绑定临时对象）

#### C++ 常用库
1. STL
#### std::numeric_limits<T> ::infinity()
- 这个无穷大的值只有在浮点数上才有，在其他整形数值类型上为0;
- 如果在整型上想用一个比较大的值可以用std::numeric_limits<T>::max()代替
- 包含在头文件<limits>当中 
2. Boost
3. Eigen





### 头文件
#### C++ assert.h头文件
ssert.h是c标准库的一个头文件，该头文件的主要目的就是提供一个assert的宏定义。assert只是对所给的表达式求值，就像if判断语句中一样，然后如果该值为真则正常运行，否则报错，并调用abort(),产生异常中断，exit出来。
该宏声名，只需在包含assert.h之前＃define NDEBUG
可以通过#undef NDEBUG进行屏蔽

 
### C++ 语法糖(grammer sugar)
#### for的范围循环
传统的for循环对于复杂类型来说，需要书写大量语句，例如对vector<int> 中的元素进行迭代其形式如下：
```C++
# include <vector>
# include <string>
using namespace std;
/test for-loop 
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
#### auto & decltype
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
```
item的类型将由var的类型推断得出。
需要注意的是，auto 会忽略顶层const（但是底层const会保留）。
#### 类型别名 typedef & template
在标准库及第三方库当中经常可以看到类型别名（还有个常见的是模板）。把他们看懂了，对于我们理解代码有莫大的帮助。不过其实这两个都很容易理解只要稍微花些时间就可以掌握。
##### 类型别名
类型别名（type alias）就是对一个类型名称进行重新命名，这样做主要有一下两个好处：
	1. 利用类型别名，让复杂的类型变的简洁，从而降低理解的成本;
	2. 可以针对基础类型进行更高维度的抽象，有时候虽然类型本身并不复杂，但是在具体应用中可以让类型名称与业务相关，从而可以增进理解。
其语法很简单：
```C++
typedef double wages;
typedef double* wages_ptr;//通过名称可以理解其代指与类型
```

### flags
#### override
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

#### =default & = delete
C++如果结构或者类没有明确声明默认函数（构造函数，拷贝构造， 析构函数），那么编译器会在需要的时候生成默认版本，这可能会引发非预期的行为。
=default是明确告诉编译器要生成默认版本(如果你写了构造函数就没有默认构造函数，如果要衍生子类则很有用  )，
=delete是明确告诉编译器**禁止**生成默认版本
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
#### constexpr
C++以后新增的flag, 声明常量值变量，在编译后会作为inline代码（换句话说，不存在于内存空间当中，相当与define）

#### 右值引用与std::move

### 遇到的问题
1. ROS plugin中的函数加入inline 标志后无法识别
