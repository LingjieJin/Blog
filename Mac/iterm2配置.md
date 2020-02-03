# iterm2 下载
ref：https://iterm2.com

或者使用homebrew下载

brew cask install iterm2

# 设置背景图
打开 Preferences 配置界面Profiles -> Window->Background mage,选择一张自己喜欢的背景图.

# iterm2 配色链接
ref：https://github.com/mbadolato/iTerm2-Color-Schemes

ref: https://iterm2colorschemes.com/

ref：https://ethanschoonover.com/solarized/

schemes 是配色方案所在的文件夹

推荐主题： Solarized Dark Higher Contrast dracula 

## 如何添加主题配色
iTerm2->Preferences->Profiles->Color选择Color Presets->import

到下载好的主题目录下schemes目录下选择你要的主题导入

## 区分目录和文件的颜色设置:
Preferences -> Profiles -> Text -> Text Rendering 

把 Draw bold text in bright colors 前面的勾去掉， 文件和目录可以很容易区分了

# 快捷键设置
## 1.全局快速隐藏和显示
打开 Preferences 配置界面，然后Profiles → Keys →Hotkey
建议使用 command+.

## 常用快捷键
```
command + t 新建标签
command + w 关闭标签
command + 数字 command + 左右方向键    切换标签
command + enter 切换全屏
command + f 查找
command + d 水平分屏
command + shift + d 垂直分屏
command + option + 方向键 command + [ 或 command + ]    切换屏幕
command + ; 查看历史命令
command + shift + h 查看剪贴板历史
ctrl + u    清除当前行
ctrl + l    清屏
ctrl + a    到行首
ctrl + e    到行尾
ctrl + f/b  前进后退
ctrl + p    上一条命令
ctrl + r    搜索命令历史
```

# iterm2 使用zsh作为默认shell
iTerm2 默认使用dash改用zsh解决方法：chsh -s /bin/zsh

iTerm2 zsh切换回原来的dash：chsh -s /bin/bash

卸载oh my zsh，在命令行输入：uninstall_oh_my_zsh




