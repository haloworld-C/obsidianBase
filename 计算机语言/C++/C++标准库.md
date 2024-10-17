## 容器通用操作
### 算法Algorithm
## 数据结构
### 顺序容器
#### 通用操作
#### vector
-  vector的内存机制 
1. 内存为管理对象数目内存的两倍大小，如果超过一个系数(??多少), 便需要再内存中再开辟一个区域，将现有对象拷贝。所以当vector规模很大的时候，很容易触发内存拷贝。
- 常用方法

| 方法        | 说明                    | 补充                                             |
| --------- | --------------------- | ---------------------------------------------- |
| reserve   | 增大vector的储存元素的能力，系数为1 | 主要目的是推迟内存的两倍成长， 值得注意的是reverse后之前的iter和元素引用都将失效 |
| resize    | 改变vector的大小           |                                                |
| push_back | 在vector尾部插入元素         |                                                |
| size      | 获取当前元素个数              | 其时间复杂度为1                                       |
| front     | 获取第一个元素               |                                                |
| back      | 获取最后一个元素              |                                                |
```cpp
# 保留容器内存拷贝
#include <vector> 
#include <algorithm> 
int main() { 
	std::vector<int> source = {6, 7, 8, 9, 10}; 
	std::vector<int> destination = {1, 2, 3, 4, 5}; 
	destination.clear(); // 清空 destination 
	// 确保有足够的空间接收源容器的元素 
	destination.reserve(source.size()); 
	std::copy(source.begin(), source.end(), std::back_inserter(destination)); 
	return 0; 
}
// 常用初始化方法
std::vector<int> a(n, 0); //默认初始化vector， 大小为n
std::vector<vector<int> > b(n, vector<int>(n, 0)); // 大小n*n
```
#### string
string是有char构成的数组， 为常量， 不可修改。
- 常用操作
```cpp
// 初始化
string b(size_t n, char c); 
string a = "abce";
// 操作
std::string subStr = a.substr(index_start, count); // 从index开始的n个size组成的子串, 如果不提供第二个参数， 那么截取范围为[index_start, size)
// return [index_start, index_start + count)
int = a.find("bc"); // 查询bc第一次出现的位置, 返回下标位置
int = a.find("bc", 2); // 查询bc第一次出现的位置, 从index 2开始找， 如果失败返回string::npos
// 字符串转换
#incude<string>
std::stoi(std::string a); // 将字符串转换为整型
std::to_string(int a); // 将数字转换为字符串
```
- 按照空格分隔字符串
```cpp

#include <iostream>
#include <string>
#include <vector>

using namespace std;

vector<string> split(const string& s) {
    vector<string> tokens;
    size_t start = 0;
    size_t end = s.find(' ');

    while (end != string::npos) {
        tokens.push_back(s.substr(start, end - start));
        start = end + 1;
        end = s.find(' ', start);
    }

    // 处理最后一个子串
    if (start != s.length()) {
        tokens.push_back(s.substr(start));
    }

    return tokens;
}
// 方法2：
std::vector<std::string> splitStringBySpace(const std::string& str) {
    std::vector<std::string> result;
    std::istringstream iss(str);
    std::string word;
    while (iss >> word) {
        result.push_back(word);
    }
    return result;
}
```
- 其他辅助函数
```cpp
std::stoi(str); // 将string转换为int类型
```
#### list
- 在第k个元素前插入
```C++
#include <iostream>
#include <list>

int main() {
    std::list<int> myList = {10, 20, 30, 40, 50};

    // Inserting an element at the kth position (k = 2 in this example)
    int k = 2;
    std::list<int>::iterator it = myList.begin();
    std::advance(it, k);  // Move the iterator to the kth position
						  // since C++17
	// std::next(it, k); // since C++11

    myList.insert(it, 25); // Insert the value 25 at the kth position

    // Print the updated list
    for (int num : myList) {
        std::cout << num << " ";
    }
    std::cout << std::endl;

    return 0;
}

```

### 适配器(adapter container)
#### queue
是对已有的数据的结构的二次封装。
- 常用操作
```cpp
queue.pop(); // 队首出列
queue.push(); // 队尾入列
queue.emplace(); // 构造队尾入列
```
> 当当前容器为空时， pop出来的元素为默认值， 需要留意
#### stack
是对已有的数据的结构的二次封装。
- 常用操作
```cpp
stack.push(a); // 压栈操作
stack.pop(); // 弹栈操作
stack.top(); // 查看栈顶
stack.emplace(a, b) // 如果stack中的元素结构比较复杂， 比较方便

```
#### std::priority_queue
底层容器默认为vector
优先队列每次排序后默认会对队列进行排序(默认为升序, 最大元素位于堆顶)， 这用pop默认将最大值弹出。
优先队列的底层实现为大顶堆，见数据结构的堆的介绍。
- 常用操作
```cpp
// 构造
std::map<int, int> myMap = {{1, 5}, {3, 2}, {2, 4}};
auto cmp = [](const std::pair<int, int>& a, const std::pair<int, int>& b) {
    return a.second > b.second;
};// 小顶堆
std::priority_queue<std::pair<int, int>, std::vector<std::pair<int, int>>, decltype(cmp)> pq(cmp);
for (auto& it : myMap) { pq.push(it);}
pq.pop();
pq.push();

```
### 关联容器
#### map(字典)
map主要有三个字类:
- std::map, 内部实现为排序红黑树(平衡搜索树), 有序(其值的迭代器遍历key升序排列)
- `std::multimap`, 内部实现为红黑树, 有序
- std::unordered_map, 内部实现为哈希表, 无序
对于红黑树， key-value结构， 访问、插入复杂度均为log(n)。
对于哈希表， 查询、增删复杂度均为O(1)

其中key必须为可哈希的。
###### 基本操作
- 初始化
```cpp
#include<map>
std::map<int, int> data{{1, 2}, {3, 4}};
```
- 插入元素
如果没有键值则直接创建, 如果又插入键值则更新其value.
```cpp
data[2] = 3;
```
- 搜索
```cpp
#include<map>

std::map<int, int> data{{1, 2}, {3, 4}};
const int index = 2;
auto iter = data.find(index);
if(iter != data.end()) {
	// has key
	//...
}
// 遍历
for(const auto& pair : data) {
	int key = data.first;
	int value  = data.second;
}
```
#### 技巧
1. 利用map的key有序的特性对数组进行排序
### set
C++上实现是通过适配器实现的，即index和value一样的map, 所以其分类与map类似:
- std::map, 内部实现为排序红黑树, 有序
- `std::multimap`, 内部实现为红黑树, 有序
- std::unordered_map, 内部实现为哈希表, 无序
对于红黑树， key-value结构， 访问、插入复杂度均为log(n)。
对于哈希表， 查询、增删复杂度均为O(1)

#### 基本操作
```cpp
# include<unordered_map>
// 初始化
std::unordered_map<int> a{1, 2, 3};
std::vector<int> b{2, 2, 3};
std::unordered_map<int> c(b.begin(), b.end());// 使用其他容器初始化

c.insert(0);// 插入元素
a.erase(2); // 删除元素
// 查找元素
if(c.find(5) != c.end()) { // 集合中存在
	// do something
}
// 利用count来判断， 简化写法
if(c.count(5)) { // 与上面写法等价， 但是更简洁
	// do something
}
// 遍历

// 集合操作
a.merge(b); // 操作过后a为原始a, b的并集
			// b为原始a, b的交集
```
### 高阶
- 自定义hash函数
```cpp
#include <vector>
#include <unordered_set>
#include <numeric>

struct MyHash {
    size_t operator()(const std::vector<int>& v) const {
        // 使用异或操作来组合元素的hash值，保证顺序无关性
        size_t hash = 0;
        for (int num : v) {
            hash ^= std::hash<int>()(num);
        }
        return hash;
    }
};

int main() {
    std::vector<int> v1 = {1, 2, 3};
    std::vector<int> v2 = {3, 2, 1};

    // 使用自定义hash函数的unordered_set
    std::unordered_set<std::vector<int>, MyHash> mySet;
    mySet.insert(v1);
    mySet.insert(v2);

    // 由于v1和v2的hash值相同，实际上只插入了一个元素
    std::cout << "Size of the set: " << mySet.size() << std::endl;
}
// 使用lamda自定义数据类型的hash函数
// 自定义对 array<int, 26> 类型的哈希函数
auto arrayHash = [fn = hash<int>{}] (const array<int, 26>& arr) -> size_t {
    return accumulate(arr.begin(), arr.end(), 0u, [&](size_t acc, int num) {
        return (acc << 1) ^ fn(num);
    });
}
unordered_map<array<int, 26>, vector<string>, decltype(arrayHash)> mp(0, arrayHash);

```

### 特殊数值
- 数学符号
```cpp
#include <cmath>

M_PI // 附带了c语言中定义的宏
```
- 无穷大
```C++
#include <limits>
std::numeric_limits<T> ::infinity()
```
这个无穷大的值只有在浮点数上才有，在其他整形数值类型上为0;
如果在整型上想用一个比较大的值可以用
```c++
std::numeric_limits<T>::max()
```
- epsilon
通常用来判断两个浮点数相等
```cpp
std::numeric_limits<float>::epsilon(); //为1.0和float的下一个可表示值之间的差值
										// best practice: std::numeric_limits<float>::epsilon()*100
```
代替
包含在头文件limits.h头文件当中 
- `bitset`
C++内置的一种二进制封装
```cpp
#include <iostream>       // std::cout
#include <bitset>         // std::bitset

int main ()
{
	std::bitset<4> foo; // 初始化为4位二进制数
	std::bitset<4> foo(5); // 用数值初始化
	std::cout << "foo: " << foo << std::cout // output: 1001
	foo[1]=1; // 访问并赋值
	foo.set(pos, 1); // 将对应下标位置的值设为1, true
	long result = foo.ulong(); // 转换为 unsigned long
	long long result = foo.ullong(); // 转换为unsigned long long 
	std::string result = foo.string(); // 转换为字符串
}
```
- 随机数
随机数包含于random库中， 通常与概率相关。常用方法如下:
```cpp 
#include <iostream> 
#include <random> 
int main() { 
	// 使用随机设备生成种子 
	std::random_device rd; 
	// 使用 Mersenne Twister 引擎 
	std::mt19937 gen(rd()); 
	// 创建均匀分布器，范围为 [0, 1)
	std::uniform_real_distribution<> dis(0.0, 1.0); 
	// 生成随机数 
	double randomValue = dis(gen); std::cout << "Random value between 0 and 1: " << randomValue << std::endl; 
	return 0; 
}
```
## 算法algorithm
- 常用算法整理
```cpp
std::find(starIter, endIter, val); // return endIter when failed
auto maxIter = std::max_element(starIter, endIter); // 取出最大值*maxIter
auto minIter = std::min_element(starIter, endIter); // 取出最大值*minIter
std::map<int, int> myMap = {{1, 10}, {2, 20}, {3, 30}}; // Method 1: Using std::accumulate and a lambda expression 
int sum1 = std::accumulate(myMap.begin(), myMap.end(), 0, [](int sum, const std::pair<int, int>& pair) { return sum + pair.second; });
# 需要自己保证写入的容器有足够 last - first的空间
# 输入迭代器范围: [firt, last)
std::copy( InputIt first, InputIt last,OutputIt d_first);
std::swap(T& a, T&b);// 交换两个数
std::reverse(container.begin(), container.end()); //翻转元素， 左闭右开
std::sort(c.begin(), c.end()); // 默认为升序
std::sort(c.begin(), c.end(), [](int a, int b){ return a < b}); // 小于号为升序
std::sort(c.rbegin(), c.rend()); // 降序, 区间[)
```
### 常用辅助函数
```C++
isdigit(char a); // 判断字符是否为数字字符
std::max(a, b);
std::min(a, b);
```
### 倒转元素
```C++
#include <iostream>
#include <vector>
#include <algorithm>

int main() {
    std::vector<int> myVector = {1, 2, 3, 4, 5};

    std::reverse(myVector.begin(), myVector.end());

    for (int num : myVector) {
        std::cout << num << " ";
    }

    return 0;
}
```
- 迭代器与index计算
```C++
std::next(iter, 5); //在iter迭代器上递增5(since C++11)
std::advance(iter, 5); //在iter迭代器上递增5(since C++17)
std::distance(input_path.begin(), precise_planning_iter); // 计算两个迭代器之间的步长
```
### 取整
```C++
std::floor(); #地板除(向下取整数)
std::ceil(); #地板除（向上取整）
```
### 绑定与注册
- 模板绑定
```C++
std::bind();
```
### 随机数
- random库
- 生成随机整数
```C++
std::srand(std::time(nullptr)); // use current time as seed for random generator
int random_variable = std::rand();
```
## 时钟 
### chrono
C++ 共提供三种时钟计时器：
1.  system_clock
2.  high_resolution_clock
3.  steady_clock(与hight_resolution_clock类似，不过不能调整is_steady属性，indicates if the clock is monotonous)
C++中原生的sleep方式:
```cpp
#include <thread>
std::this_thread::sleep_for(std::chrono::seconds(1));// sleep one seconds
// 计时
auto last_time = std::chrono::high_resolution_clock::now();
// do something
auto duration_ms = std::chrono::duration_cast<std::chrono::milliseconds>(
                std::chrono::high_resolution_clock::now() - last_time);
double time_cost = duration_ms.count() / 1000.0;
LOG(INFO) << "tf transformation cost: " << time_cost << " seconds";
```
## 多线程
### std::thread

> 当使用std::thread时， 需要在编译时g++ 需要在末尾加上-pthread
### 原子量
	std::atomic原子操作变量，与多线程环境中保证线程安全。
### 互斥量
并不是所有变量都是可以原子操作的， 这时候就需要锁(lock)依据互斥量(mutex)进行保护。

### 资源锁
### std::lock_guard
### std::unique_lock
- 基本用法
```cpp
// unique_lock example
#include <iostream>       // std::cout
#include <thread>         // std::thread
#include <mutex>          // std::mutex, std::unique_lock

std::mutex mtx;           // mutex for critical section

void print_block (int n, char c) {
  // critical section (exclusive access to std::cout signaled by lifetime of lck):
  std::unique_lock<std::mutex> lck (mtx);
  for (int i=0; i<n; ++i) { std::cout << c; }
  std::cout << '\n';
}

int main ()
{
  std::thread th1 (print_block,50,'*');
  std::thread th2 (print_block,50,'$');

  th1.join();
  th2.join();

  return 0;
}
// try lock
std::unique_lock<std::mutex> lck (mtx, std::defer);
if(lck.try_lock()) {
	// do something
	lck.unlock();
} else {
	std::cout << "failed to get lock.." << std::endl;
}

```

### std::unique_lock