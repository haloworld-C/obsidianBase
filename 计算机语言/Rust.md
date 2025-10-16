rust是一种操作系统级别的高级语言, 兼具良好的性能与开发效率。
## core concept
### 特点
- rust中所有变量默认都是不可变的
- rust中可以安全的处理引用(零拷贝)
- 很多种高级语言的杂糅
### 所有权
- 没有垃圾回收机制


## 安装
- linux
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## 编译工具rustc cargo
### `rustc`
用来手动编译文件, 比如下面的hello world:
```main.rs
fn main() {
	println!("Hello, world!");
}
```
编译命令
```bash
rustc main.rs
```

- panic
在编译阶段, 如果检测到溢出、非法访问等错误， 程序会显式提示(相当于warning)
### cargo
rust的包管理工具, 也是相比C++有优势的地方, 用来管理大型工程。

|命令行名称|说明||
|---|---|---|
|cargo new [pack name]|创建包| |  
|cargo check|在工程编译前先检查能否被编译| 耗时很少|  
|cargo build|工程编译| cargo build默认在debug模式下进行编译, 使用cargo build --release 进行发布编译 |
|cargo run|工程编译并运行|   |
## syntax
### 注释
与C++一样使用`//`
#### 文档注释
### 变量
#### 变量声明
```rust
let num = String::new()
```
注意到`num`并没有指定变量类型， 通过let声明变量名， 并将其绑定到`String::new()`创建的对象上， 变量默认为不可变类型(C/C++中const的概念)
如果声明变量是可变的可以(相当于C++中mutable const的概念)
```rust
let mut num = String::new()
```
##### 隐藏变量(shadow)
rust可以允许用同样的变量名来声明新的数据类型(比`mut`更加自由)， 即与python中类似的动态类型, 这将给程序带来极大的自由度, 与python变量不同的是其动态类型是在编译阶段(且需要显式指定)， 在运行阶段是静态类型。
```rust
let mut num = String::new()
let guess: u32 = Int::new()
```
##### 常量const
const不光默认不可变， 而且永久不可变
```rust
const MAX: u32 = 100_000; // 数字中下划线为辅助， 编译器将忽略
```
> 常量允许隐藏吗? 
#### 变量类型 
rust中变量分为两类: 标量类型(scalar)和复合类型(compound)
##### 标量类型(scalar)
主要为整数类型(`i8~i64`, `u8~u64`)、浮点数类型(`f32`, `f64`)、布尔类型(bool)及字符类型(char, 为`unicode`编码, 占4字；节)
1. 整数类型
特殊类型: `isize`, `usize` 取决于运行平台, 在32位架构是32位; 在64位架构是64位.
整数的默认类型推导为32位.
```rust
98_222 // Decimal
0xff // Hex
0o77 // Octal
0b1111_0000 // Binary
b'A' // byte
// 除了byte外， 其他数值后均可以附加类型, 以便显式提醒
```
- 数值运算
```rust
let sum = 5 + 4;
let sub = 24 - 12;
let div = 25 / 14;
let mul = 4 * 3
let remainder = 13 % 4 // 取余
// 基本运算与其他语言大同小异
```
2. 浮点类型
浮点数默认为64位
```rust
let x = 2.0;
let y: uf32 = 2.0;
```
3. 布尔类型
布尔类型大小为一个字节
```rust
let isSuccess = true;
```
4. 字符类型
rust中字符类型占4个字节， 为`unicode`编码
```rust
let c = 'z'
```

> 字符串是如何处理的

##### 复合类型(compound)
主要为元组类型(tuple)、数组类型(array)
> 注意: rust本身并没有内建(built-in)常用的数据结构, 应该也是通过包拓展方式提供
1. 元组类型(tuple)
元组类型为不同类型变量的集合体, 与python类似.
```rust
let tup = (500, 6.4, 'a');
let (x, y, z) = tup; // destructuring
let x = tup.0; 
let y = tup.1;
let z = tup.2;
```
2. 数组类型(array)
- 数组与其他语言中的array概念一致， 为相同类型变量的连续存储的序列
- 数组类型为固定长度， 一旦声明不允许改变长度
```rust
let a = [1, 2, 3, 4, 5];
let first = a[0];
let a = [3; 5]; // 3, 3, 3, 3, 3
```
### 控制流
#### 条件分支
##### if - else if - else
```rust
let number = 3; 
if number < 5 {
	println!("ture");
} else {
	println!("false");
}
// rust 并不会将其他类型的值隐式转换为true or false
if number != 0 {
	println!("not equal to zero");
}
if number == 0 {
	println!("equal to zero");
}
let number = 10
if number < 5 {
	println!("less than 5");
} else if number < 12 {
	println!("between (5, 12)");
} else {
	println!("larger than 12");
}
// if 分支为表达式， 则需要类型一致, 因为变量只能拥有单一类型
```
> =>是什么含义

 ##### 条件分支match
```rust
use std::cmp::Ordering;

match guess.cmp(&secret_number) { // 注意到比较是由对象进行管理
    Ordering::Less => println!("Too small!"),
    Ordering::Greater => println!("Too big!"),
    Ordering::Equal => {
        println!("Bingo!"),
    }
}
// 注意分支使用,分割
```
#### 循环
loop, while , for
##### 无限循环loop
```rust
loop {
	//...
}// 使用break进行循环中断
```
##### 条件循环while
```rust
let mut number = 3;
while number != 0 {
	println!("number: {}", number);
	number = number - 1; // 没有number--
}
```
##### 遍历循环for
```rust
let a = [1, 2, 3, 4, 5];
for element in a.iter() {
	println!("{} ", element);

}
for number in (1, 4) {
	println!("{}", number)
}
// range 范围为左闭右开(与python类似)
```

### 函数
函数体的关键字为`fn`, 其内容由花括号包裹
```rust
fn my_func {
	//...
}
```
rust中`fn`的位置没有要求， 并不要求先声明后使用， 只要在使用作用域可见即可.
```rust
fn main() {
	another_fn();
}
fn another_fn() {
	println!("Another function");
}
```
#### 函数参数
rust中函数参数需要显式指明, 函数参数也是函数签名的一部分.
```rust
fn main() {
	another_fn(5);
}
fn another_fn(x: i32) {
	println!("value of x: {}", x);
}
```
#### 语句与表达式
- 带分号的就是语句， 语句没有返回值
```rust
let y = 6; // 表达式, expression
```
- 表达式具有返回结果
```rust
let x = 5;
let y = {
	let x = 3;
	x + 1
}; // 4
```
#### 函数返回值
rust通过表达式隐式返回值
```rust
fn five() -> i32 {
	5
}
fn main() {
	let x = five()
	println!("the value of x is: ", x);
}
```

> rust没有return保留字？

## 好用的rust工具
- ripgrep， 搜索匹配工具
- starship, 终端提示工具
- 