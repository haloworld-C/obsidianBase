- 配置文件
```~/.Xdefaults
! TrueType font
UXTerm*faceName: DejaVu Sans Mono
XTerm*faceName: DejaVu Sans Mono
! Chinese
UXTerm*faceNameDoublesize: Noto Sans CJK SC
XTerm*faceNameDoublesize: Noto Sans CJK SC
! font size
UXTerm*faceSize: 16
XTerm*faceSize: 16
! color
UXTerm*background: black
UXTerm*foreground: white
XTerm*background: black
XTerm*foreground: white

UXTerm*geometry: 120x35+500+250
UXTerm*metaSendsEscape: true
UXTerm*eightBitInput: false
UXTerm*selectToClipboard: true
UXTerm*locale: zh_CN.UTF-8
Uxterm*utf8: true
Uxterm*utf8Title: true

XTerm*geometry: 120x35+500+250
XTerm*metaSendsEscape: true
XTerm*eightBitInput: false
XTerm*selectToClipboard: true
XTerm*locale: zh_CN.UTF-8
xterm*utf8: true
xterm*utf8Title: true
```
- 加载
进入`xterm`后，执行
```xterm
xrdb -merge .Xdefaults
```
