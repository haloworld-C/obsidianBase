### 高频常用命令行
|命令行名称|说明|
|---|---|
|dpkg -i <you.deb>|安装deb包
| apt purge <package name> | 删除软件及其配置及依赖包
	| apt remove <package name> | 删除软件（保留配置及依赖包）
	| apt autoremove <package name> | 删除当前不需要的依赖包
	| apt list --installed| 列出已安装软件包
	| grep <string> | 搜索文本
	| scp <remote_usr_name@ip_address> <本地文件夹> | 将远程电脑中的制定文文件拷贝到本地，反过来则是推送（若是文件夹，则加参数-r）
	