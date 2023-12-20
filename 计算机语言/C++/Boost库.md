### basic concept
boost库为准`STL库`, 通常包含一些最新的编程思想与特性，相当于一个试验场，对于显示优势的概念与思想通常会纳入标准库.
### 使用步骤
#### `cmake`使用
```CMakelists.txt
find_package(Boost REQUIRED)
include_directories(include ${Boost_INCLUDE_DIR})

add_executable(<target> <target_file>)
target_lick_libraries(<target> ${Boost_LIBRARIES})
```
### 分组件介绍
#### optional组件
```cpp
#include <boost/optional.hpp>
using namespace boost;
```
optional为一个与指针行为类似的容器，旨在为函数返回值无效时，提供一个判断, 使用如下:
```cpp
optional<int> a; // 一个未初始化对象，其有效真值为假
assert(a); // false
optional<int> a(1); // 初始化对象， 其有效真值为真
assert(a); // true
std::cout << *a << std::endl; // 1
```
#### boost多线程
##### atomic原子库
##### thread 库
- `unique_lock`
```cpp
#include <boost/thread.hpp>
#include <boost/thread/lock_factories.hpp>
auto lock = boost::make_unique_lock(planner_mutex); # 锁定mutex的简洁写法, 不必详细写出mutex的类型
```
##### `astoi` 库
异步线程库

```C++
#include <boost/thread/shared_mutex>

boost::shared_mutex sharedMutex; // Create a shared mutex

// Read operation (multiple threads can read simultaneously)
void ReadOperation()
{
    boost::shared_lock<boost::shared_mutex> lock(sharedMutex);
    // Perform read operations on the shared resource
} // lock goes out of scope and releases the shared lock

// Write operation (exclusive access)
void WriteOperation()
{
    boost::unique_lock<boost::shared_mutex> lock(sharedMutex);
    // Perform write operations on the shared resource
} // lock goes out of scope and releases the exclusive lock
// Recursive mutex
boost::recursive_mutex sensor_scan_mutex_;
boost::unique_lock<boost::recursive_mutex> sensor_scan_lock(sensor_scan_mutex_);
```

