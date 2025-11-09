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

## CLI
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


## API记录
- GLM
baseULR:
anthropic_base_url: https://api.z.ai/api/anthropic
open_ai_base_url: https://api.z.ai/api/coding/paas/v4
api: c1dc350b81ec4110858031280d31484d.TULqwreKQjqEQyN3
zAI: 1d46786929cf473a96dae3aadcefb5d7.Tgdho9eV6Nd6Fqo2