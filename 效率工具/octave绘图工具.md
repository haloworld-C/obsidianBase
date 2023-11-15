开源GUI绘图软件，其语法与`matlab`语法兼容且支持矩阵运算
### 安装
- `octave`软件
```bash
sudo apt install octave
```
- 安装开发环境
```bash
sudo apt install liboctave-dev
```
- 启动(建议使用root权限)
```bash
sudo octave
```
- 安装模块
前提需要使用root权限进入octave命令模式:
```octave command
pkg install -forge <package name> # 官方库网络安装
pkg install <pakage file> # 下载的库文件安装
```