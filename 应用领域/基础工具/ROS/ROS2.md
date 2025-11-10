### Core concept
- 相比于ROS1的改进：
	1. 增加对实时系统的支持，采用DDS作为通信中间件
	2. 去中心化Master


####  常用命令(与ROS1相同的命令见[[ROS]])

| command                          | params                      | decription  | comment                                                                                                                                                                                                                                              |
| -------------------------------- | --------------------------- | ----------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| colcon build                     | --packages-select [package] | 编译指定包       | colcon build为ROS2的编译命令行工具, 编译附加依赖colcon build --packages <name-of-pkg><br>添加Cmake参数： --cmake-args -DBUILD_TESTING=ON<br>限制多线程数:colcon build --parallel-workers 2<br>单线程编译: colcon build --executor sequential<br>限制等层多线程: MAKEFLAGS=-j4 colcon build |
| colcon test                      |                             | 统一运行测试用例    |                                                                                                                                                                                                                                                      |
| ros2 daemon start                |                             | 启动ros2的守护进程 |                                                                                                                                                                                                                                                      |
| ros2 daemon stop                 |                             | 关闭ros2的守护进程 |                                                                                                                                                                                                                                                      |
| ros2 daemon status               |                             | 查看ros2的运行状态 |                                                                                                                                                                                                                                                      |
| ros2 pkg executables [pack name] |                             | 查看包是否已经安装   |                                                                                                                                                                                                                                                      |
| ros2 bag record -o my_bag -a     |                             | 录包          |                                                                                                                                                                                                                                                      |
### Colcon test
#### gtest支持
要让新的 gtest 在 colcon test 时自动跑，关键是按 ROS2/ament-cmake 的套路把它注册进去。基本步骤如下：
1. 用 ament_add_gtest() 声明测试目标
在包的 CMakeLists（通常在 project(... ) 之后、if(BUILD_TESTING) 块里面）添加：
```CMakeLists.txt
if(BUILD_TESTING)
  find_package(ament_cmake_gtest REQUIRED)
  ament_add_gtest(my_test src/my_test.cpp)
endif()
```
这样 colcon test 会识别它是一个 gtest。需要额外的 include 路径或库，就像普通 target 那样写 target_include_directories、target_link_libraries 或 ament_target_dependencies。

2. 确保可执行文件能找到依赖
gtest 代码里如果用到了包内头文件/库，务必把 ${CMAKE_CURRENT_SOURCE_DIR}/../include 或相关库路径加进去；如果要链接 ROS2 组件，照常 ament_target_dependencies(my_test rclcpp ...)。

保持 BUILD_TESTING 默认启用
不要删掉。colcon build --cmake-args -DBUILD_TESTING=ON 时会把 gtest 一并编译。

3. 运行测试
构建：colcon build --packages-select my_pkg --cmake-args -DBUILD_TESTING=ON
执行全部测试：colcon test --packages-select my_pkg
看详细输出：colcon test --packages-select my_pkg --event-handlers console_direct+ --ctest-args --output-on-failure
4. 日志与调试
测试运行后 colcon test-result --verbose 会列出全部结果；单个 gtest 的原始输出位于 build/[pkg]/test_results/，必要时可以直接运行 build/[pkg]/test/my_test --gtest_filter=... 调试。
照这个流程安置好 gtest 后，每次执行 colcon test 就会自动构建并运行所有注册的测试。

#### 常用命令
```bash
# 运行某个包下面的所有测试
colcon test --packages-select your_pkg --ctest-args --output-on-failure
# 运行单个测试用例
colcon test --packages-select spider_navigation --ctest-args -R collision_detection_costmap_test
```
> 未解决问题， 无法在测试用例失败的时候输出详细信息