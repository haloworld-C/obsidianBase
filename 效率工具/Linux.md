1. 录屏软件
- vokoscreen, 优点是界面友好易用， 可以选定区域录制屏幕, 安装命令如下：
```bash
sudo apt install -y vokoscreen
```
2. 屏幕像素尺
- kruler, 可以用来量图片的像素长度, 安装命令如下：
```bash
sudo apt install -y kruler
```
3. pdf阅读器
- Okular,易用，也有标记功能
```bash
sudo apt install okular
```
- foxit 阅读器
功能更加完整，体验更好，推荐
4. 电子书发布工具gitbook
- 可以方便的将markdown内容制作成电子书，并发布为github.io的网页
5. 视频播放软件
- VLC
Linux下最强播放器
6. rsyslog日志工具
多平台的轻量级日志服务器, 介绍见[[Syslog]]
7. 串口工具
minicom
8. 远程命令行终端
tmux
9. 压缩工具7z(压缩效率最高)
常用命令
```bash
# 压缩
7z a my_archive.7z /path/to/directory_or_file
# 解压
7z x my_archive.7z -o output_directory
# 列出压缩包内文件
7z l my_archive.7z
# 按照大小分割文件
7z a -v100m -mx0 large_archive.7z /path/to/largefile
# 合并分割的文件并解压
cat large_archive.7z.* > combined_large_archive.7z
7z x combined_large_archive.7z
```
10. shell交互`starship` + fish
```bash
curl https://sh.rustup.rs -sSf | sh
cargo install starship --locked
```
11. 截图工具
