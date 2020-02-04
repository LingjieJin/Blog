# 使用iterm2自动登录远程服务器

# 创建登录信息文件
```
#!/usr/bin/expect

set timeout 100
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

# 原理
当前网上有许多的不同方式实现，根本上还是利用expect解析执行脚本内容
```
expect是一个自动交互功能的工具。
expect是开了一个子进程，通过spawn来执行shell脚本，监测到脚本的返回结果，通过expect判断要进行的交互输入内容（send）
```
