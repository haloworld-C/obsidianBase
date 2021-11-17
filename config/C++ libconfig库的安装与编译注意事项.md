### 安装
cd到解压文件目录，依次运行如下命令：
- ./configure
- make                 （运行完生成 .so 和 .a）
- make check
- make install       （将 .so 和 .a库  安装到/usr/local/lib 路径下）
- make clean
### 问题
使用[libconfig库](https://github.com/hyperrealm/libconfig)后，编写测试用例程序时报# "undefined reference to XXX"问题。
### 原因
经查找，发现是在编译阶段没有链接到libconfig的库文件的原因。官方文档中也有提及：To link with the library, specify ‘-lconfig++’ as an argument to the linker
> 关于"undefined reference to XXX"报错，这个[帖子]（https://zhuanlan.zhihu.com/p/81681440）里面有比较全面的分析。
### 解决方法
1. 如果是单个文件的编译使用g++命令中加入-lconfig++参数
```C++
g++ yourfile.cpp -o a.out -lconfig
```
2. 由于我是用CMake进行编译的，故应在CMakelist中配置以下内容：
``` CMakelist
LINK_DIRECTORIES(/usr/local/lib/) # 该目录是你编译后的静态库文件所在的目录
target_link_libraries([your pack name] -lconfig++)
```
