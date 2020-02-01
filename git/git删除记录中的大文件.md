ref https://www.cnblogs.com/lout/p/6111739.html

# 查看git仓库大小
git count-objects -v

# 查找
git verify-pack -v .git/objects/pack/pack-*.idx | sort -k 3 -g | tail -5

# 找到对应的文件名（包括目录结构）
git rev-list --objects --all | grep 8f10eff91bb6aa2de1f5d096ee2e1687b0eab007

git filter-branch --index-filter 'git rm --cached --ignore-unmatch <your-file-name>'
rm -rf .git/refs/original/
git reflog expire --expire=now --all
git fsck --full --unreachable
git repack -A -d
git gc --aggressive --prune=now
git push --force [remote] master

里面最重要的两条命令是 git filter-branch 和 gc, filter-branch 真正在清理，但是只运行它也是没用的，需要再删除备份的文件，重新打包之类的，最后的gc命令，

用来收集产生的垃圾，最终清除大文件

如果真的要完全把这个对象删除，可以运行 git prune 命令
