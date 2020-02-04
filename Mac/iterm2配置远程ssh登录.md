# 使用iterm2自动登录远程服务器

# 创建登录信息文件
```
#!/usr/bin/expect

set PORT 22
set HOST ***.***.***.***
set USER root
set PASSWORD ***

spawn ssh -p $PORT $USER@$HOST
expect {
        "yes/no" {send "yes\r";exp_continue;}
         "*password:*" { send "$PASSWORD\r" }
        }
interact
```

# 在iterm2中导入该文件
1. 创建一个新的profile

打开iterm2 -> preferences -> Profiles
点击下面“+”号，新建一个profile。

2. 增加配置文件
选择Command 在输入框中输入
expect+刚才建的文件路径
