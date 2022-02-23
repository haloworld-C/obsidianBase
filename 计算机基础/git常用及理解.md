| command | discription | comment|
|------|----------|---------|
| git branch | 查看当前分支
| git checkout -b <branch-name> |创建新分支|
| git remote -v | 查看远程仓库主分支| 
| git fetch | 获取远程仓库内容|
| git checkout | 检查当前目录的内容进行校验（如果是子模块，需要在子目录进行checkout）|
| git checkout <分支名称> | 切换到对应的分支| 
| git clone <仓库地址> --recurse-submodules | 连带子模块进行拉取|
| git fetch -all && git reset --hard master && git pull | 获取所有历史分支，将head指针重置到最新master分支上|

	
