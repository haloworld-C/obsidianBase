### 常用快捷键
|命令行名称|说明|补充|
|---|---|---|
|ctrl+b|关闭导航栏|在vim的insert模式下|
|ctrl+shift+p|打开命令栏||
|ctrl+shift+e|聚焦到文件列表||

### 配置
#### vscode特性
- snippet code
相当于代码片段的模板，可以方便地输入高频模式, 使用示例如下:
```json
{
	// Place your snippets for cpp here. Each snippet is defined under a snippet name and has a prefix, body and 
	// description. The prefix is what is used to trigger the snippet and the body will be expanded and inserted. Possible variables are:
	// $1, $2 for tab stops, $0 for the final cursor position, and ${1:label}, ${2:another} for placeholders. Placeholders with the 
	// same ids are connected.
	// Example:
	"template": {
		"prefix": "template",
		"body": [
			"template<typename T>",
			"$0"
		],
		"description": "quick input for c++ template"
	},
	"template function": {
		"prefix": "template function",
		"body": [
			"template<typename T>",
			"T $1(T $2) {",
			"    $3", 
			"}",
			"$0"
		],
		"description": "quick input for c++ template"
	}
}
```

#### 插件
- `Vscode-neovim`
	原生vim支持，使用`Vscode`作为前端`GUI`, 只用`neovim`作为后台。
-  clangd语言跳转/补全工具
	1. 先本机安装clang/clangd
	```bash
	sudo apt update
	sudo apt install clang clangd
	```
	2. vscode安装clangd插件
	3. 可能需要禁止C++插件


