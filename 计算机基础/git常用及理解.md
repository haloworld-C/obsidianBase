| command | discription | comment|
|------|----------|---------|
| git branch | 查看当前分支
| git checkout -b <branch-name> |创建新分支|
| git remote -v | 查看远程仓库主分支| 
| git fetch | 获取远程仓库内容|
| git checkout | 检查当前目录的内容进行校验（如果是子模块，需要在子目录进行checkout）|
| git checkout <分支名称> | 切换到对应的分支|git checkout -切回到之前的分支| 
| git clone <仓库地址> --recurse-submodules | 连带子模块进行拉取|
| git fetch --all && git reset --hard master && git pull | 获取所有历史分支，将head指针重置到最新master分支上|
| git push -u origin <branch_name> | 将本地分支推送到远程对应分支并关联| 后续只需要git push便可推送到对应分支|
| git push origin --delete <branch_name> | 删除远程分支|
| git branch -d <branch_name>|删除本地分支（需要退出需要删除的分支才能删除）|-D为强制删除|
| git status| 查看目前分支的修改状态|
| git log| 查看git commit 的历史记录|git shortlog 历史记录的缩略版|
| git merge <分支名称>| 将对应分支的修改合并到本分支|
| git add <filename>| 将对应文件由untrack状态提升为unstage 状态（第一第创建时候）;更新最近修改（track update）
| git rm <filename>| 将对应文件由tracked状态变为untracked状态| |
| git stash | 将将当前分支更改保存，并恢复到之前clean commit的状态|恢复git stash apply|
|git remote -v| 获取远程仓库信息|
### concepts
git pull = git fetch + git merge
### git workflow
#### general
1. 创建fork分支或者本地分支
2. 在该分支上作相应更改
3. 完成后git pull request到主分支
4. 主分支接受更改后，删除该分支的远程分支及本地分支。有新功能时返回1,进行新一轮的循环。
#### fork后更新最新代码

1、找一个空的目录下签出 fork 后的代码
git clone <fork 后仓库>
查看 remote 信息
git remote -v

2、然后添加源项目地址（距离定义为 source）
git remote add upstream <fork的源仓库>
查看 remote 信息，可以看到新增两条信息
git remote -v

3、fetch 源项目
git fetch upstream

4、合并代码
git merge upstream/master

5、把合并最新的代码推送到你的fork项目上
git push origin master

#### 其他
1. 将本地仓库推送到远程空仓库
```bash
git remote add origin <remote-repository-url>
```
2. 追踪原始仓库的变更
```bash
git remote add upstream <upstream-remote-repository-url>
```
具体流程：
- 从upstream拉去最新变更
- 合并到本地
- 将本地变更与upstream变更一起推送到本仓库origin
