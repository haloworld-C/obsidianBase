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
