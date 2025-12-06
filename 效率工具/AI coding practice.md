- 方法论
- 工具
## 使用场景
### 善于做什么
- chat(无需在编辑器和网页之间切换， 复制粘贴)
- 代码补全
- 简单函数及接口调用
- 语法修正, 修正编译\运行错误
- 非核心代码(测试脚本， 测试用例编写)
- 简单逻辑代码(生成或从一种语言翻译到另外一种语言)
- 简单成熟算法(生成或从一种语言翻译到另外一种语言)
### 不善于做什么
- 复杂算法
- 性能调优
- 隐蔽bug查找修正
- 对一个问题的深度思考
## 代码补全
- windsurf
- copilot
- cursor
- continue(还可以组合各种模型)
## IDE
### anti-gravity
1. 安装vpn需要开tun模式
2. 登录需要vpn开全局模式
3. zsh补全受到干扰:
```bash
sudo chown root:root /usr/share/zsh/vendor-completions/_antigravity
```
## CLI
### Aider(pair programming)
- 特点: 可以通过ide注释主动触发
#### 使用deepseek api登录

```bash
aider --model deepseek --api-key deepseek=<key> --watch-files
```
### claude
- 优点: 可以在大型项目中修改代码
- 缺点: 账号容易封, 贵
#### Cluade code api配置配置 API 接入点

为了让 Claude Code 通过 zzz-api 的代理服务访问 Anthropic 的 API，您需要设置一个环境变量。

将以下命令添加到您的 shell 配置文件中（例如/.bashrc 或 ~/.zshrc），然后重新加载您的 shell 或打开一个新的终端窗口。

```bash
export ANTHROPIC_BASE_URL="https://api.zhizengzeng.com/anthropic"
export ANTHROPIC_AUTH_TOKEN=“token_key_string”
export ANTHROPIC_MODEL=你希望使用的model
```

claude code中使用deepseek:
api: sk-5175b5cd6f324d9b95ba08812a07fd2b

```bash
export ANTHROPIC_BASE_URL="https://api.deepseek.com//anthropic"
export ANTHROPIC_AUTH_TOKEN=“sk-5175b5cd6f324d9b95ba08812a07fd2b”
export ANTHROPIC_MODEL=deepseek-reasoner
export ANTHROPIC_SMALL_FAST_MODEL="deepseek-chat"
```

### MCP
### cline
### 本地模型进行代码补全
#### ollama安装
```bash
curl -fsSL https://ollama.com/install.sh | sh
```
#### 模型拉取到本地
```bash
ollama run deepseek-coder:6.7b
```
#### continue中进行配置
```YAML
models: 
	- name: Qwen3 without Thinking for Autocomplete 
	  provider: ollama 
	  model: qwen3:4b # qwen3 is a thinking-switchable model 
	  roles: - autocomplete 
	  requestOptions: 
		extraBodyProperties: 
			think: false # turning off the thinking
```
## Practice
### Senario 1(算法翻译)


### Senario 2(非核心代码编写, 工具类， 测试类)

#### 工具类(文件缓存工具)
##### 提示
- 对于/home/hal/Documents/workspace/ros2_ws/src/apparition/include/alg_lib/hybridAstar_components/collision_detection.hpp中的collision_lookup的数据， 需要缓存到文件， 需求: 1. 希望在算完后缓存到本地文件， 然后检测本地文件是否存在；如果存在， 跳过在线预计算。然后对文件进行校验加载 2. 使用c++进行工具构建， 希望所有的实现都放到一个cache_file.hpp文件当中，放到/home/hal/Documents/workspace/ros2_ws/src/apparition/include/utils下面 3.缓存文件位置放到.ros下面 4. 文件加载性能要快 5.考虑后期兼容不同的数据类型
- 先复述需求及你实现的思路
```codex 回复
需求整理：

- 目前 HybridAstar 的 collision_lookup 每次构造都在线预计算，耗时较长。希望第一次算完后把 lookup 数据缓存到本地，下次启动先检查本地缓存；若文件存在且校验通过，直接加载，不再重复预计算。
- 缓存实现要用 C++ 写成工具模块，全部代码放入 apparition/include/utils/cache_file.hpp，方便其它地方复用，考虑未来支持多种数据类型。
- 缓存文件存放在用户家目录的 .ros 下面（如 ~/.ros/***），同时要保证加载性能高、包含基本校验，避免损坏文件导致崩溃。
- 只改 collision_detection、lookup 等使用侧，满足“检测文件→加载或写入”的流程。

实现思路：

1. 在 utils/cache_file.hpp 中封装一个轻量 cache 工具，提供：
    
    - 生成缓存路径（默认 ~/.ros，可带自定义文件名/前缀）。
    - 写入函数：接受结构体/数组的二进制数据，加上版本号、数据类型标识、尺寸等头部信息后落盘。
    - 读取函数：先校验文件存在，再比对头部（版本、数据尺寸等），都通过才映射/读取到内存，失败返回 false。
    - 未来扩展可通过模板或类型标签支持不同数据类型。
2. 在 collision_detection.hpp 构造函数里：
    
    - 先根据底盘参数、MapConfig 计算一个 cache key（例如 hash(chasis footprint、resolution、theta_sample_num、positionResolution 等)）。
    - 调用 cache 工具尝试加载 collision_lookup；如果成功，直接用；若失败则调用 Lookup::collisionLookup 在线生成，并写回缓存。
3. 为了加载快，可以直接写入连续内存（先 serialize 每个 RelativePoint 数组长度，再写入点数据），或使用简单的二进制格式，配合 std::vector resize + read.
    
4. 错误处理：若读/写出现异常，日志提醒并退回到在线生成。
    

接下来将按这个方案实现：先新增 cache_file.hpp，再修改 collision_detection 逻辑接入。
```
- 可以实施， 我希望实现utils/cache_file.hpp后为它在/home/hal/Documents/workspace/ros2_ws/src/apparition/test/lookup_collision_tests下写一个测试用例， 统计写入和加载性能；完成后运行测试用例表明功能正常

- 在/home/hal/Documents/workspace/ros2_ws/src/apparition/docs下面更新一个utils.md的文档， 说明该模块的设计思路及说明， 同步更新test下面的README.md文档
> 测试用例中文件的加载由2Min缩短到6ms
> 修改流程总耗时1 hour
## API记录
- GLM
baseULR:
anthropic_base_url: https://api.z.ai/api/anthropic
open_ai_base_url: https://api.z.ai/api/coding/paas/v4
api: c1dc350b81ec4110858031280d31484d.TULqwreKQjqEQyN3
zAI: 1d46786929cf473a96dae3aadcefb5d7.Tgdho9eV6Nd6Fqo2
- deepseek
key api: sk-5175b5cd6f324d9b95ba08812a07fd2b