# Mac下安装zsh以及配置

# 安装zsh


# 配置zsh

# 别名配置
vim ~/.zshrc
```
# For server
#alias weiyidev = "ssh weiyidev"
#alias studytime = "ssh studytime"


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
