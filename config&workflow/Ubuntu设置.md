### 应用图标及自启动
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

### 服务自启动
#### 配置文件
在/etc/systemd/system/目录下创建服务文件
```bash
cd /etc/systemd/system/
sudo vim my.service
```

填入以下信息，ExecStart自行替换为你自己的frp启动命令，注意路径
```service
[Unit]
Description=frpc
After=network.target
Wants=network.target

[Service]
Restart=on-failure
RestartSec=5
ExecStart=/home/work/test_algorithm/wedrive_self-innovate/frp_0.41.0_linux_arm64/frpc -c /home/work/test_algorithm/wedrive_self-innovate/frp_0.41.0_linux_arm64/frpc.ini

[Install]
WantedBy=multi-user.target
```
#### 设置自启动
- 刷新服务列表
```bash
systemctl daemon-reload
```
- 设置开机自启
```bash
systemctl enable my.service
```
- 启动服务
```bash
systemctl start my.service
```
    执行上述命令服务就可以设置开机自启并启动服务
> 服务可能会在开机时启动失败。因此在设置开机自启命令时，最好在[Service]中定义Restart和RestartSec。
#### 其他命令
下面是一些常用的systemctl命令
- 关闭开机自启
```bash
systemctl disable my.service
```
-  停止服务
```bash
systemctl stop my.service
```
- 重启服务
```bash
systemctl restart my.service
```
-  查看状态
```bash
systemctl status my.service
```
-  查看是否设置开机自启
```bash
systemctl is-enabled my.service
```
