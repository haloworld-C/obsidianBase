### 常用命令
![vim key](vim_key.png)

| command | discription | comment|
|------|----------|---------|
|`nj`| 向下移动n行|
|`nk`| 向上移动n行|
|Ctrl+f| 向下翻页|
| Ctrl + b | 向上翻页|
| N[enter] | 向下移动n行| n为数字|
| x | 向后删除一个字符|
| X | 向前删除一个字符|
| /word | 向下搜索名为word的字符串 | 
| ？word | 向上搜索名为word的字符串|
| n,N | 重复上一次查找操作 | 使用/word后可向下跳转（类似于下一个，N为上一个）
| :n1, n2s/word1/word2/g | 在第n1与n2行之间搜索word1并替换为word2| g的意思是替换
|:1, $s/word1/word2/g |从第一行到最后一行搜索并替换为word2
| ctrl + r |恢复上一次操作 | 与u对应
| . | 重复上次操作 | 类似word 中的f4|
| :sp | 在同一个文件中开两个文件，用于对比查看j|:vsp左右分屏幕
|:n |当通过vim [file1] [file2] ..打开了多个文件时跳到下一个文件中| :N为跳到上一个文件
| [ctrl + w] + j | 跳到上面打开同一个文件的下一个窗口|与:sp配合
| [ctrl + w] + k | 跳到上面打开同一个文件的上面窗口 | 与:sp配合
| [ctrl + w] + c | 关闭:sp打开的窗口 | 与:sp配合
| ndd | 删除所在行的向下n行 | 
| d[n] | 删除当前字符开始的n个字符 | 
| :nd | 删除第n行 | 
| :n,md | 删除第n行到第m行的内容 | 
|0, $|移动到该行第一个（最后一个字符）| 
|f_x|移动到第一个字符x出现的地方| 
|n+[space]|向后移动n个字符| 
|w|移动到下一个单词的词首| 
|b|移动到上一个单词的词首| 
|e|移动到下一个单词的词尾w| 
|[shift] + >/<|选中内容向右或者向左多行缩进/提前一个tab的长度| 
|[shift] + \*|搜索当前单词| 
|:set number|显示行号| 
|:set nonumber|不显示行号| 
|:m[mark name]|标记书签|如果书签名字是小写字母，则为局部书签，大写字母则是全局书签|
|:\`[mark name]|跳到书签的行首|
|:marks|列出所有书签|
|:delmarks [mark name]|删除书签|
|`:w ! sudo tee %` |在vim打开的只读文件中获得写权限|需要输入`sudo`密码|

- vim 配置参考：
[amix/vimrc](https://github.com/amix/vimrc)
### vim使用技巧
-  多行注释
1. 首先按esc进入命令行模式，按下ctrl+v， 进入区块选择模式
2. 在行首使用上下键选择需要注释多行
3. 按下键盘大写“I”进入首行插入模式(按了Esc退出编辑模式后才会看到多行编辑效果)
4. 此时光标会进入选中的第一行， 输入# 、// 等符号
5. 按esc退出，然后所有选中行首都会加上刚才输入的字符
> 删除同理
- 移动到行首字母
`0w`， 反之，移动到行末最后一个字符: `$e`
- 录制宏来进行复杂的重复操作
	1. normal模式下输入qa(a指寄存器，也可以是qb, qc等等)，开始录制
	2. 进行一次需要的操作
	3. normal模式下输入q，结束录制
	4. 按`@a`重复上面录制的操作， `n@a`可以指定重复操作n次
- vim 内开启`teminator`(版本8.1后支持)
	1. `:term`, 默认水平开启一个命令行, 也可以垂直切割`:vert term`
	2. exit关闭命令行
	3. vim内的命令行也支持移动normal模式(进入时默认为insert模式)
### 常见问题
- 粘贴缩进乱码
1. 命令行`:set paste`进入粘贴模式
2. 按i进入插入模式， 粘贴
3. 退出编辑模式， 然后`:set nopaste` 取消粘贴模式
```
### `neovim`配置使用
#### 安装
```bash
sudo apt-add-repository ppa:neovim-ppa/stable #版本较低
sudo add-apt-repository ppa:neovim-ppa/unstable -y #最新版本
sudo apt-get update
sudo apt-get install neovim
```
#### 配置

##### 插件使用

#### `vscode`中使用
- 区分`nvim`本地使用和在`vscode`中的使用, 进行分别配置
```$HOME/.config/nvim/init.vim
if exists('g:vscode')
    " VSCode extension
else
    " ordinary neovim
endif
```
- `setting.json`配置
```
"vscode-neovim.neovimExecutablePaths.linux": "/usr/bin/nvim",
"vscode-neovim.neovimInitVimPaths.linux": "/home/test/.config/nvim/init.vim"
```