# git clone 指定的文件

## example

> 现在有一个test仓库 https://github.com/mygithub/test
你要git clone里面的tt子目录：
在本地的硬盘位置打开Git Bash

```bash
# 创建一个空的本地仓库，同时将远程Git Server URL加入到Git Config文件中
mkdir project_folder
​
cd project_folder
​
git init
​
git remote add -f origin <url>

# 在Config中允许使用Sparse Checkout模式
git config core.sparsecheckout true

# 接下来你需要告诉Git哪些文件或者文件夹是你真正想Check Out的
# 你可以将它们作为一个列表保存在
# .git/info/sparse-checkout
# 文件中
echo “libs” >> .git/info/sparse-checkout

echo “apps/register.go” >> .git/info/sparse-checkout

echo “resource/css” >> .git/info/sparse-checkout

# 以正常方式从你想要的分支中将你的项目拉下来就可以了
git pull origin master

# 总结
1.指定远程仓库
2.指定克隆模式: 稀疏克隆模式
3.指定克隆的文件夹(或者文件)
4.拉取远程文件

```
