# iterm2 配色


# iterm2 安装

# iterm2 官方主题下载
ref： https://iterm2colorschemes.com/

推荐主题：Solarized Dark Higher Contrast
iTerm2->Preferences->Profiles->Color选择Color Presets->import
到下载好的主题目录下schemes目录下选择你要的主题导入
导入之后别忘记设置成你要的主题。

# 终端设置和ls配色
终端输入vim ~/.bash_profile
添加如下export
```
#enables colorin the terminal bash shell export
export CLICOLOR=1

#setsup thecolor scheme for list export
export LSCOLORS=gxfxcxdxbxegedabagacad
 
#sets up theprompt color (currently a green similar to linux terminal)
export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]\$  (设置几个空格，个人喜欢两个)'
#enables colorfor iTerm
export TERM=xterm-256color
```
# VIM配色
终端输入 vim .vimrc
设置如下
```
 syntax on
 set number
 set ruler
```

