# Systemd的一些常用指令

参考:
ref: https://blog.csdn.net/sky__man/article/details/78178821
ref: https://blog.csdn.net/jiankunking/article/details/79826025

---------------------------------------------------------------------------------

## systemctl 管理指令
```
# 重启系统
$ sudo systemctl reboot

# 关闭系统，切断电源
$ sudo systemctl poweroff

# CPU停止工作
$ sudo systemctl halt

# 暂停系统
$ sudo systemctl suspend

# 让系统进入冬眠状态
$ sudo systemctl hibernate

# 让系统进入交互式休眠状态
$ sudo systemctl hybrid-sleep

# 启动进入救援状态（单用户状态）
$ sudo systemctl rescue

```

------------------------------------------------------------------------------

## systemd-analyse 分析指令
```
//systemd-analyze命令用于查看启动耗时

# 查看启动耗时
$ systemd-analyze                                                                                       

# 查看每个服务的启动耗时
$ systemd-analyze blame

# 显示瀑布状的启动过程流
$ systemd-analyze critical-chain

# 显示指定服务的启动流
$ systemd-analyze critical-chain xxx.service

```

------------------------------------------------------------------------------

## hostnamectl 主机信息指令
```
// hostnamectl命令用于查看当前主机的信息

# 显示当前主机的信息
$ hostnamectl

# 设置主机名。
$ sudo hostnamectl set-hostname xxx

```

------------------------------------------------------------------------------

## localectl 本地化指令
```
// localectl命令用于查看本地化设置

# 查看本地化设置
$ localectl

# 设置本地化参数。
$ sudo localectl set-locale LANG=en_GB.utf8
$ sudo localectl set-keymap en_GB

```

------------------------------------------------------------------------------

## timedatectl 时区指令
```
// timedatectl命令用于查看当前时区设置

 查看当前时区设置
$ timedatectl

# 显示所有可用的时区
$ timedatectl list-timezones                                                                                   

# 设置当前时区
$ sudo timedatectl set-timezone America/New_York
$ sudo timedatectl set-time YYYY-MM-DD
$ sudo timedatectl set-time HH:MM:SS

```

------------------------------------------------------------------------------

## loginctl
```
// loginctl命令用于查看当前登录的用户

# 列出当前session
$ loginctl list-sessions

# 列出当前登录用户
$ loginctl list-users

# 列出显示指定用户的信息
$ loginctl show-user xxx

```

------------------------------------------------------------------------------

## systemctl 查看系统服务 
```
# 列出正在运行的 Unit
$ systemctl list-units

# 列出所有Unit，包括没有找到配置文件的或者启动失败的
$ systemctl list-units --all

# 列出所有没有运行的 Unit
$ systemctl list-units --all --state=inactive

# 列出所有加载失败的 Unit
$ systemctl list-units --failed

# 列出所有正在运行的、类型为 service 的 Unit
$ systemctl list-units --type=service

systemctl list-unit-files       ##列出服务的开机状态
# 列出所有配置文件
$ systemctl list-unit-files

# 列出指定类型的配置文件
$ systemctl list-unit-files --type=service

// 这个命令会输出一个列表
$ systemctl list-unit-files

UNIT FILE              STATE
chronyd.service        enabled
clamd@.service         static
clamd@scan.service     disabled

显示每个配置文件的状态，一共有四种
enabled：已建立启动链接
disabled：没建立启动链接
static：该配置文件没有[Install]部分（无法执行），只能作为其他配置文件的依赖
masked：该配置文件被禁止建立启动链接

# 显示系统状态
$ systemctl status

# 显示单个 Unit 的状态
$ sysystemctl status xxx.service

# 显示远程主机的某个 Unit 的状态
$ systemctl -H root@xxxx status httpd.service

systemctl stop sshd             ##关闭指定服务

systemctl start sshd            ##开启指定服务

systemctl restart sshd          ##从新启动服务

systemctl enable sshd           ##设定指定服务开机开启
Systemd 默认从目录/etc/systemd/system/读取配置文件
但是，里面存放的大部分文件都是符号链接，指向目录/usr/lib/systemd/system/
真正的配置文件存放在那个目录。
$ sudo systemctl enable clamd@scan.service
# 等同于
$ sudo ln -s '/usr/lib/systemd/system/clamd@scan.service' '/etc/systemd/system/multi-user.target.wants/clamd@scan.service'

systemctl disable sshd          ##设定指定服务开机关闭

systemctl reload sshd           ##使指定服务从新加载配置

# 重载所有修改过的配置文件
$ sudo systemctl daemon-reload

# 显示某个 Unit 的所有底层参数
$ systemctl show httpd.service

# 显示某个 Unit 的指定属性的值
$ systemctl show -p CPUShares httpd.service

# 设置某个 Unit 的指定属性
$ sudo systemctl set-property httpd.service CPUShares=500

systemctl list-dependencies sshd    ##查看指定服务的倚赖关系
systemctl list-dependencies --all nginx.service ## 查看target所有依赖

systemctl mask  sshd            ##冻结指定服务

systemctl unmask sshd           ##启用服务

systemctl set-default multi-user.target ##开机不开启图形

systemctl set-default graphical.target  ##开机启动图形

```

-------------------------------------------------------------------------------

### systemctl status
```
systemctl   status     服务名称

// 状态字段解释  
loaded             ##系统服务已经初始化完成，加载过配置

active（running）       ##正有一个或多个程序正在系统中执行， vsftpd就是这种模式

atcive（exited）        ##僅執行一次就正常結束的服務， 目前並沒有任何程序在系統中執行

atcive（waiting）       ##正在執行當中，不過還再等待其他的事件才能继续处理

inactive            ##服务关闭

enbaled           ##服务开机启动

disabled          ##服务开机不自启

static                ##服务开机启动项不可被管理

failed                ##系统配置错误

```

--------------------------------------------------------------------------------

## 配置文件的区块
官方文档：https://www.freedesktop.org/software/systemd/man/systemd.unit.html

[Unit] 区块通常是配置文件的第一个区块，用来定义 Unit 的元数据，以及配置与其他 Unit 的关系。
它的主要字段如下：
· Description：简短描述
· Documentation：文档地址
· Requires：当前 Unit 依赖的其他 Unit，如果它们没有运行，当前 Unit 会启动失败
· Wants：与当前 Unit 配合的其他 Unit，如果它们没有运行，当前 Unit 不会启动失败
· BindsTo：与Requires类似，它指定的 Unit 如果退出，会导致当前 Unit 停止运行
· Before：如果该字段指定的 Unit 也要启动，那么必须在当前 Unit 之后启动
· After：如果该字段指定的 Unit 也要启动，那么必须在当前 Unit 之前启动
· Conflicts：这里指定的 Unit 不能与当前 Unit 同时运行
· Condition…：当前 Unit 运行必须满足的条件，否则不会运行
· Assert…：当前 Unit 运行必须满足的条件，否则会报启动失败

[Install]通常是配置文件的最后一个区块，用来定义如何启动，以及是否开机启动。
它的主要字段如下：
· WantedBy：它的值是一个或多个 Target，当前 Unit 激活时（enable）符号链接会放入/etc/systemd/system目录下面以 Target 名 + .wants后缀构成的子目录中
· RequiredBy：它的值是一个或多个 Target，当前 Unit 激活时，符号链接会放入/etc/systemd/system目录下面以 Target 名 + .required后缀构成的子目录中
· Alias：当前 Unit 可用于启动的别名
· Also：当前 Unit 激活（enable）时，会被同时激活的其他 Unit

[Service]区块用来 Service 的配置，只有 Service 类型的 Unit 才有这个区块。
它的主要字段如下：
- Type：定义启动时的进程行为。它有以下几种值。
- Type=simple：默认值，执行ExecStart指定的命令，启动主进程
- Type=forking：以 fork 方式从父进程创建子进程，创建后父进程会立即退出
- Type=oneshot：一次性进程，Systemd 会等当前服务退出，再继续往下执行
- Type=dbus：当前服务通过D-Bus启动
- Type=notify：当前服务启动完毕，会通知Systemd，再继续往下执行
- Type=idle：若有其他任务执行完毕，当前服务才会运行
- ExecStart：启动当前服务的命令
- ExecStartPre：启动当前服务之前执行的命令
- ExecStartPost：启动当前服务之后执行的命令
- ExecReload：重启当前服务时执行的命令
- ExecStop：停止当前服务时执行的命令
- ExecStopPost：停止当其服务之后执行的命令
- RestartSec：自动重启当前服务间隔的秒数
- Restart：定义何种情况 Systemd 会自动重启当前服务，可能的值包括always（总是重启）、on-success、on-failure、on-abnormal、on-abort、on-watchdog
- TimeoutSec：定义 Systemd 停止当前服务之前等待的秒数
- Environment：指定环境变量

-----------------------------------------------------------------------------------------------------









