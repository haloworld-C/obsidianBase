### core concept
一个`YAML`配置文件一次性加载的`C++`开源库。
### 安装
[github](https://github.com/jbeder/yaml-cpp)
```dockerfile
RUN tar -xzvf /home/firefly/carto_libs/yaml-cpp-yaml-cpp-0.6.0.tar.gz && \
    cd yaml-cpp-yaml-cpp-0.6.0 && mkdir build && cd build && env CFLAGS='-fPIC' CXXFLAGS='-fPIC' cmake -DCMAKE_INSTALL_PREFIX=/usr/local/stow/yaml-cpp -DYAML_BUILD_SHARED_LIBS=OFF .. && \ 
    make && make install >> ../install.info
RUN cd /usr/local/stow && \
    stow yaml-cpp  && \
    echo "Finish yaml-cpp"
```
### 使用
- 基本用法
```C++
YAML::Node config = YAML::LoadFile("config.yaml"); # 加载
const std::string username = config["username"].as<std::string>(); # 参数读取
if(config["username"]) # 判断参数是否存在
```
- 特殊结构加载
```C++
struct Vec3 { double x, y, z; /* etc - make sure you have overloaded operator== */ };
namespace YAML {
template<> // 特化
struct convert<Vec3> {
  static Node encode(const Vec3& rhs) { // functor
    Node node;
    node.push_back(rhs.x);
    node.push_back(rhs.y);
    node.push_back(rhs.z);
    return node;
  }

  static bool decode(const Node& node, Vec3& rhs) {
    if(!node.IsSequence() || node.size() != 3) {
      return false;
    }

    rhs.x = node[0].as<double>();
    rhs.y = node[1].as<double>();
    rhs.z = node[2].as<double>();
    return true;
  }
};
}
```