昨天折腾了一个下午，发现配置~/.vimrc后完全没有生效（只是想显示一下行号）。多番查找也没找到。今天早上看到一个[bilibili视频](https://www.bilibili.com/video/av55546505)，发现里面讲的与我的问题比较相像，没有生效的原因是文件权限问题。这里又暴露了linux系统基本知识的短板。
### 问题
配置了用户根目录下的~/.vimrc之后，通过sudo vim进入文件编辑界面后，配置内容没有生效
### 原因
因为是通过sudo 进入，而sudo 进入代表当前的用户身份是root,所以vim默认读取的配置文件是系统根目录下/.vimrc而非~/.vimrc。
### 解决方案
1. 通过vim <文件名>， 进去后可以观察到配置生效
2. 通过以下配置使sudo 权限进入时默认读取当前用户配置
```
在~/.bash_aliases里加入：

alias sudo='sudo env HOME=$HOME'
```

### 常用插件
- 自动补全：ycm
- 注释：## Doxygen