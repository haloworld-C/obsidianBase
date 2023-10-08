一款开源的在线图书工具, 书写格式为Markdown。可以方便地制作导出各种格式，在线网页图书等。适合轻量级的图书。如果是正式图书还是用latex及相关插件进行排版发布。
可以使用git工具进行管理，并且方便与github进行继承。
也可用使用gitbook[网站](https://www.gitbook.com/)进行图书制作与发布。
### 安装
```bash
sudo apt-get install nodejs  # 安装nodejs
node -v  # 查看nodejs版本
sudo apt-get install npm  # 安装npm
sudo npm install gitbook-cli -g  # 安装gitbook-cli
gitbook -V  # 查看gitbook版本
```
###   GitBook 目录结构介绍
一本由 GitBook 创建的电子书籍，除了实际内容文件外，还应包含如下文件：
- `README.md`:书的介绍文字，如前言、简介，在章节中也可做为章节的简介。（必须）
- `SUMMARY.md`:定制书籍的章节结构和顺序。（必须）
- `LANGS.md`:多种语言设置。
- `GLOSSARY.md`:词量表和定义描述。

> `README.md`和`SUMMARY.md`是GitBook 制作电子书的必要文件，可用`gitbook init`命令自动生成，其余文件如有需要，可手动添加。

GitBook 基本的目录结构如下所示

```
.
├── book.json
├── README.md
├── SUMMARY.md
├── chapter-1/
|   ├── README.md
|   └── something.md
└── chapter-2/
    ├── README.md
    └── something.md
```
### 使用
- 生成书籍目录
```bash
npm install -g gitbook-summary # 安装目录生成工具
gitbook init # 生成配置文件模板
gitbook sm # 根据实际的markdown文件目录结构生成目录
```
- 编译静态网页并预览 
```bash 
gitbook serve
```
- 直接编译
```bash
gitbook build
```
> 使用`http://localhost:4000`进行预览

### 插件使用
#### Latex公式支持

