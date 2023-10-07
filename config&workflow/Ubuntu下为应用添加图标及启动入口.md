[source](https://blog.csdn.net/zhuawalibai/article/details/97764381)
要给软件添加启动图标，可到/usr/share/applications目录下创建相应的配置文件，以下为给obsidian配置启动图标示例：  
命令行进入/usr/share/applications目录
```bash
cd /usr/share/applications
```
执行
```bash
sudo vim obsidian.desktop
```

添加如下内容
```config
[Desktop Entry]
Name=obsidian
Name[zh_CN]=obsidian
Comment=note taking system
Exec=/home/hal/app/Obsidian-1.3.7.AppImage
Icon=/home/hal/app/icon_obsidian.png
Terminal=false
Type=Application
Categories=Application;
Encoding=UTF-8
StartupNotify=true
```
**注意:**  
Exec 和 Icon 后面的代码需要根据你 obsidian 的实际安装的位置替换（Exec就是启动软件的可执行文件位置，Icon就是要显示的启动图标位置，icon可以是jpg、png、svg等格式）。

编辑好后保存退出，然后在启动器上输入“Name[zh_CN]=”后面的内容，就可以显示相应的启动图标了。
- 设置自动启动
```bash
sudo cp /usr/share/applications/fcitx.desktop /etc/xdg/autostart/
```