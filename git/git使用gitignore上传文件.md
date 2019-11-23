# .gitignore文件配置

通过配置* .gitignore *文件，可以指定git管理所需要的文件
忽略代码编译过程中产生的额外文件

## 配置方法

修改.gitignore文件中的标示的方法来忽略开发者想忽略掉的文件或目录
在.gitignore文件中的每一行保存一个匹配的规则

```bash
# 此为注释 – 将被 Git 忽略

*.a       # 忽略所有 .a 结尾的文件
!lib.a    # 但 lib.a 除外
/TODO     # 仅仅忽略项目根目录下的 TODO 文件，不包括 subdir/TODO
build/    # 忽略 build/ 目录下的所有文件
doc/*.txt # 会忽略 doc/notes.txt 但不包括 doc/server/arch.txt
```

新建的文件在git中会有缓存
如果某些文件已经被纳入了版本管理中，就算是在.gitignore中已经声明了忽略路径也是不起作用的
这时候我们就应该先把本地缓存删除，然后再进行git的push，这样就不会出现忽略的文件了
git清除本地缓存命令如下

```bash
git rm -r --cached .
git add .
git commit -m 'update .gitignore'
```

## 配置参考

[GitHub](https://github.com/github/gitignore/, "github 推荐")

## example

### c++配置

```bash
# Prerequisites
*.d

# Compiled Object files
*.slo
*.lo
*.o
*.obj

# Precompiled Headers
*.gch
*.pch

# Compiled Dynamic libraries
*.so
*.dylib
*.dll

# Fortran module files
*.mod
*.smod

# Compiled Static libraries
*.lai
*.la
*.a
*.lib

# Executables
*.exe
*.out
*.app
```
