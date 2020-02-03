# Mac环境下bash配置
~/.bash_profile用户目录下的该文件纪录了bash的配置信息

## 修改bash配置
```bash
#enables colorin the terminal bash shell export
export CLICOLOR=1

#setsup thecolor scheme for list export
export LSCOLORS=gxfxcxdxbxegedabagacad
 
#sets up theprompt color (currently a green similar to linux terminal)
export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]\$  (设置几个空格，个人喜欢两个)'
#enables colorfor iTerm
export TERM=xterm-256color
```


## Git语法高亮设置
[参考链接](点这里, "https://segmentfault.com/a/1190000005703684")

```bash
#Git branch status
function git_status {
  local unknown untracked stash clean ahead behind staged dirty diverged
  unknown='0;34' # blue
  untracked='0;32' # green
  stash='0;32' # green
  clean='0;32' # green
  ahead='0;33' # yellow
  behind='0;33' # yellow
  staged='0;96' # cyan
  dirty='0;31' # red
  diverged='0;31' # red

  if [[ $TERM = *256color ]]; then
    unknown='38;5;20' # dark blue
    untracked='38;5;76' # mid lime-green
    stash='38;5;76' # mid lime-green
    clean='38;5;82' # brighter green
    ahead='38;5;226' # bright yellow
    behind='38;5;142' # darker yellow-orange
    staged='38;5;214' # orangey yellow
    dirty='38;5;202' # orange
    diverged='38;5;196' # red
  fi

  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [[ -n "$branch" ]]; then
    if [[ "$branch" == 'HEAD' ]]; then
       branch=$(git rev-parse --short HEAD 2>/dev/null)
    ## 建议修改
    ## 第一次从github 克隆下来的仓库，执行git rev-parse --short HEAD 2>/dev/null 为空，导致会显示 ()$现象
       branch=master
    fi
    git_status=$(git status 2> /dev/null)
    # If nothing changes the color, we can spot unhandled cases.
    color=$unknown
    if [[ $git_status =~ 'Untracked files' ]]; then
      color=$untracked
      branch="${branch}+"
    fi
    if git stash show &>/dev/null; then
      color=$stash
      branch="${branch}*"
    fi
    if [[ $git_status =~ 'working directory clean' ]]; then
      color=$clean
    fi
    if [[ $git_status =~ 'Your branch is ahead' ]]; then
      color=$ahead
      branch="${branch}"
    fi
    if [[ $git_status =~ 'Your branch is behind' ]]; then
      color=$behind
      branch="${branch}"
    fi
    if [[ $git_status =~ 'Changes to be committed' ]]; then
      color=$staged
    fi
    if [[ $git_status =~ 'Changed but not updated' ||
          $git_status =~ 'Changes not staged'      ||
          $git_status =~ 'Unmerged paths' ]]; then
      color=$dirty
    fi
    if [[ $git_status =~ 'Your branch'.+diverged ]]; then
      color=$diverged
      branch="${branch}!"
    fi
    printf "\033[%sm%s\033[0m" "$color" "($branch)"
  fi
  return 0
}

#bles colorin the terminal bash shell export
export CLICOLOR=1

#sets up thecolor scheme for list export
export LSCOLORS=gxfxcxdxbxegedabagacad

#sets up theprompt color (currently a green similar to linux terminal)
export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[01;31m\]$(git_status)\[\033[0m\]\$ '
## 建议修改
## 小写的w 改成大写的W 是以为小写的w 显示的是当前文件夹的绝对路径，放到控制台里面贴着很长，大写的W则只会显示当前文件夹的名字
export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\W\[\033[01;31m\]$(git_status)\[\033[0m\]\$ '

#enables colorfor iTerm
export TERM=xterm-256color
```

保存退出就可以了。为了确保下次开机命令依然有效，执行如下命令：
```
echo "[ -r ~/.bashrc ] && source ~/.bashrc" >> .bash_profile
```
