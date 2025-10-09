### Cluade code api配置配置 API 接入点

为了让 Claude Code 通过 zzz-api 的代理服务访问 Anthropic 的 API，您需要设置一个环境变量。

将以下命令添加到您的 shell 配置文件中（例如/.bashrc 或 ~/.zshrc），然后重新加载您的 shell 或打开一个新的终端窗口。

```bash
export ANTHROPIC_BASE_URL="https://api.zhizengzeng.com/anthropic"
export ANTHROPIC_AUTH_TOKEN=“token_key_string”
export ANTHROPIC_MODEL=你希望使用的model
```