### core concept
tmux 可以包含多个 session，一个 session 可以包含多个 window， 一个 window 可以包含多个 pane

### Tmux 快捷键 & 速查表 & 简明教程
启动新会话：
    tmux [new -s 会话名 -n 窗口名]
恢复会话：
    tmux at [-t 会话名]
列出所有会话：
    tmux ls
<a name="killSessions"></a>关闭会话：
    tmux kill-session -t 会话名
关闭当前window: 
    ctrl+b x
<a name="killAllSessions"></a>关闭所有会话：
    tmux ls | grep : | cut -d. -f1 | awk '{print substr($1, 0, length($1)-1)}' | xargs kill
>  在 Tmux 中，按下 Tmux 前缀 `ctrl+b`，然后按下`:`， 进入指令配置模式
>  进入指令模式后， 按上下键可以在历史指令中切换
#### 会话

    :new<回车>  启动新会话
    s           列出所有会话
    $           重命名当前会话
#### 窗口 (标签页)

    c  创建新窗口
    w  列出所有窗口
    n  后一个窗口
    p  前一个窗口
    f  查找窗口
    ,  重命名当前窗口
    &  关闭当前窗口
#### 调整窗口排序

    swap-window -s 3 -t 1  交换 3 号和 1 号窗口
    swap-window -t 1       交换当前和 1 号窗口
    move-window -t 1       移动当前窗口到 1 号
#### 窗格（分割窗口） 
    %  垂直分割
    "  水平分割
    o  交换窗格
    x  关闭窗格
    ⍽  左边这个符号代表空格键 - 切换布局
    q 显示每个窗格是第几个，当数字出现的时候按数字几就选中第几个窗格
    { 与上一个窗格交换位置
    } 与下一个窗格交换位置
    z 切换窗格最大化/最小化
> pane快速跳转: `Ctrl+b` `q`: 显示每个窗格的编号，按下相应的数字键跳转到目标窗格。
#### 移动光标
1. Ctrl+b ↑ ：**光标切换**到上方**窗格**
2. Ctrl+b ↓ ：**光标切换**到下方**窗格**
3. Ctrl+b ← ：**光标切换**到左边**窗格**
4. Ctrl+b → ：**光标切换**到右边**窗格**
5. Ctrl+b ; ：**光标切换**到上一个**窗格**
6. Ctrl+b o ：**光标切换**到下一个**窗格**
#### <a name="syncPanes"></a>同步窗格(所有pane相应同样的操作)

这么做可以切换到想要的窗口，输入 Tmux 前缀和一个冒号呼出命令提示行，然后输入：

```
:setw synchronize-panes on # 打开
:setw synchronize-panes off # 关闭
```

你可以指定开或关，否则重复执行命令会在两者间切换。
这个选项值针对某个窗口有效，不会影响别的会话和窗口。
完事儿之后再次执行命令来关闭。[帮助](http://blog.sanctum.geek.nz/sync-tmux-panes/)
## 调整窗格尺寸
如果你不喜欢默认布局，可以重调窗格的尺寸。虽然这很容易实现，但一般不需要这么干。这几个命令用来调整窗格：

    PREFIX : resize-pane -D          当前窗格向下扩大 1 格
    PREFIX : resize-pane -U          当前窗格向上扩大 1 格
    PREFIX : resize-pane -L          当前窗格向左扩大 1 格
    PREFIX : resize-pane -R          当前窗格向右扩大 1 格
    PREFIX : resize-pane -D 20       当前窗格向下扩大 20 格
    PREFIX : resize-pane -t 2 -L 20  编号为 2 的窗格向左扩大 20 格
#### 滚动模式：
    PREFIX : [          进入vim选中模式， 按q退出
#### 文本复制模式：
- 设置鼠标支持
```conf
set-option -g mouse on # 鼠标支持, 按住shift然后负责
# 如果跨多行可以进入全页模式prefix + z
```


按下 `PREFIX-[` 进入文本复制模式。可以使用方向键在屏幕中移动光标。默认情况下，方向键是启用的。在配置文件中启用 Vim 键盘布局来切换窗口、调整窗格大小。Tmux 也支持 Vi 模式。要是想启用 Vi 模式，只需要把下面这一行添加到 .tmux.conf 中：

    set-option -g mode-keys vi
> 临时调整: ctrl + b , 再按:, 进入命令模式， 然后输入上面模式

启用这条配置后，就可以使用 h、j、k、l 来移动光标了。

想要退出文本复制模式的话，按下回车键就可以了。然后按下 `PREFIX-]` 粘贴刚才复制的文本。

一次移动一格效率低下，在 Vi 模式启用的情况下，可以辅助一些别的快捷键高效工作。

例如，可以使用 w 键逐词移动，使用 b 键逐词回退。使用 f 键加上任意字符跳转到当前行第一次出现该字符的位置，使用 F 键达到相反的效果。

    vi             emacs        功能
    ^              M-m          反缩进
    Escape         C-g          清除选定内容
    Enter          M-w          复制选定内容
    j              Down         光标下移
    h              Left         光标左移
    l              Right        光标右移
    L                           光标移到尾行
    M              M-r          光标移到中间行
    H              M-R          光标移到首行
    k              Up           光标上移
    d              C-u          删除整行
    D              C-k          删除到行末
    $              C-e          移到行尾
    :              g            前往指定行
    C-d            M-Down       向下滚动半屏
    C-u            M-Up         向上滚动半屏
    C-f            Page down    下一页
    w              M-f          下一个词
    p              C-y          粘贴
    C-b            Page up      上一页
    b              M-b          上一个词
    q              Escape       退出
    C-Down or J    C-Down       向下翻
    C-Up or K      C-Up         向下翻
    n              n            继续搜索
    ?              C-r          向前搜索
    /              C-s          向后搜索
    0              C-a          移到行首
    Space          C-Space      开始选中
                   C-t          字符调序
	

## 杂项：

    d  退出 tmux（tmux 仍在后台运行）
    t  窗口中央显示一个数字时钟
    ?  列出所有快捷键
    :  命令提示符

## 参考配置文件（~/.tmux.conf）：

下面这份配置是我使用 Tmux 几年来逐渐精简后的配置，请自取。

```bash
# key binding
set -g prefix C-x
set -g mode-keys vi
set-option -g mouse on # 鼠标支持

unbind '"'
bind - splitw -v -c '#{pane_current_path}' # 垂直方向新增面板，默认进入当前目录
unbind %
bind | splitw -h -c '#{pane_current_path}' # 水平方向新增面板，默认进入当前目录

# 绑定hjkl键为面板切换的上下左右键
bind -r k select-pane -U # 绑定k为↑
bind -r j select-pane -D # 绑定j为↓
bind -r h select-pane -L # 绑定h为←
bind -r l select-pane -R # 绑定l为→

# 绑定快捷键为r
bind r source-file ~/.tmux.conf \; display-message "Config reloaded.."
 # 绑定Ctrl+hjkl键为面板上下左右调整边缘的快捷指令
bind -r ^k resizep -U 10 # 绑定Ctrl+k为往↑调整面板边缘10个单元格
bind -r ^j resizep -D 10 # 绑定Ctrl+j为往↓调整面板边缘10个单元格
bind -r ^h resizep -L 10 # 绑定Ctrl+h为往←调整面板边缘10个单元格
bind -r ^l resizep -R 10 # 绑定Ctrl+l为往→调整面板边缘10个单元格
 bind Escape copy-mode # 绑定esc键为进入复制模式
bind -T copy-mode-vi v send-keys -X begin-selection
bind -T copy-mode-vi y send-keys -X copy-selection-and-cancel
```
