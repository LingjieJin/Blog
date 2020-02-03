ref：https://www.jianshu.com/p/246b844f4449

# Mac下安装zsh以及配置

# 安装zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

卸载oh-my-zsh命令：uninstall_oh_my_zsh

或者使用homebrew安装
brew install zsh

或者从git上安装：
```
curl -Lo install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh
```


# 配置zsh

# 别名配置
vim ~/.zshrc
```
# For git
alias gs="git status"
alias ga='git add'
alias gd='git diff'
alias gf='git fetch'
alias grv='git remote -v'
alias gbr='git branch'
alias gpl="git pull"
alias gps="git push"
alias gco="git checkout"
alias gl="git log"
alias gc="git commit -m"
alias gm="git merge"

# For local
alias cd..="cd .."
alias cd...="cd ../.."
alias cd....="cd ../../.."
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ip="curl ip.cn"
```
source ~/.zshrc

# 基础配置
## 主题
安装成功后，用vim打开隐藏文件 .zshrc ，修改主题为 agnoster：
ZSH_THEME="agnoster"

## 安装powerline
先安装pip
sudo easy_install pip
再安装Powerline
pip install powerline-status

## 安装meslo字体
应用这个主题需要特殊的字体支持，否则会出现乱码情况，这时我们来配置字体：
安装 Meslo 字体库。
方法1、可以直接复制下面命令到终端中安装：
```
# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts
```
应用字体到iTerm2下，我自己喜欢将字号设置为16px，看着舒服（iTerm -> Preferences -> Profiles -> Text -> Change Font）
重新打开iTerm2窗口，这时便可以看到效果了

# 配置插件
切入扩展目录
cd ~/.oh-my-zsh/custom/plugins

# 高亮显示
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
打开`.zshrc`文件，在最后添加下面内容
vim  ~/.zshrc
添加代码
source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
plugins=(zsh-syntax-highlighting)
保存文件。
执行
source ~/.zshrc

# 自动提示命令
将工程克隆到当前目录
git clone git://github.com/zsh-users/zsh-autosuggestions

打开.zshrc文件，在最后添加下面内容
source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
plugins=(zsh-autosuggestions)

修改高亮提示
cd ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

vim zsh-autosuggestions.zsh 

修改 ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10' 

# 执行修改
source ~/.zshrc


# 使用homebrew安装语法高亮
brew install zsh-syntax-highlighting

配置.zshrc文件，插入一行。
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source ~/.zshrc


# 安装coreutils
brew install coreutils

# 安装自动补全插件incr
incr地址：https://mimosa-pudica.net/zsh-incremental.html
cd ~/.oh-my-zsh/plugins/
mkdir -p incr
cd incr
touch incr-0.2.zsh（将上面链接中的代码复制粘贴到incr-0.2.zsh文件中）
chmod 777 incr-0.2.zsh

## 配置.zshrc文件
 vim ~/.zshrc
 source ~/.oh-my-zsh/plugins/incr/incr*.zsh
 source ~/.zshrc 
 
# 隐藏用户名
在zshrc中添加该字段：

DEFAULT_USER="用户名"

用户名指当前电脑用户，可以用whoami查看





