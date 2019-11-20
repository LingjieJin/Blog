# 记录一些linux 常用指令


## pwd
打印当前工作目录

## cd
进入指定目录
“.”当前目录
“..”当前目录的上一级目录
“~”用户的主目录
“-”上一次变更当前目录前所在的目录

## echo
输出字符串或者变量
查看SHELL变量的值：
# echo $SHELL
看本机主机名：
# echo $HOSTNAME

## date
查看设置系统的时间和日期

## reboot
重启

## wget
下载网络文件

## find
find /home -name “hello” -atime +5 -ok rm -f {}
-atime:在指定时间内被存取过的文件，小时为单位
-amin: 在指定时间内被存取过的文件，分钟为单位
-ctime:指定时间内被更改的文件，小时为单位
-cmin:指定时间内被更改的文件，分钟为单位

## ifconfig
获取网络接口信息
ifconfig eth0

## uname
查看系统内核版本信息

## who
查看当前登录用户

## last
查看所有系统的登入记录

## top
动态查看系统的运行状态
```
缺省按照cpu使用情况排序
m键：按照内存排序
t键：运行时间进行排序
u键，键入用户名，查看某一用户的CPU使用情况
k键，输入PID，可终止某一进程
q键，退出top
```

## ps
查看系统进程信息
```
进程状态
R表示进行状态；S表示休眠状态；T表示暂停或终止状态机；Z表示僵死状态
1）运行态 运行或准备运行
2）等待态
可中断(TASK_ITERRUPTIBLE)
不可中断(TASK_UNITERRUPTIBLE)
3）停止态(TASK_STOPPED)
4）僵死态（TASK_ZOMBIE)

ps aux
a：显示当前终端下的所有进程信息
u：使用以用户为主的格式输出进程信息
x：显示当前用户在所有终端下的进程信息
```

## export
用于定义或修改环境变量
```
普通变量可以不用声明就可使用
$ export TEST=“Test...” #定义一个新环境变量
$ export TEST=$TEST:“add1”  #向环境变量TEST中加入新值
$ unset TEST  #删除变量
$ readonly TEST #将环境变量TEST设为只读，只读的变量不能被删除

env命令显示所有已定义的环境变量
【修改环境变量】
两种方式：
在命令行用export命令修改，只在本次登录的shell内有效,设置好的环境变量可以在当前用户运行的所有程序中使用
在配置文件中修改环境变量的默认值，新登陆仍可有效。

命令行修改环境变量
以下在用户user主目录下操作：
mkdir shdir && cd shdir
vi hello
chmod 755 hello
cd ～
export PATH=$PATH:$HOME/shdir
在任何目录下，输入hello即可执行该文件。

配置文件中修改环境变量
以下在用户user主目录下操作：
vi .profile
在文件末尾添加一行
export PATH=$PATH:$HOME/shdir
esc返回命令模式，:wq保存退出。

用source命令使配置文件立即有效
source .profile
现在，在任何目录下即可执行shdir目录下的所有可执行文件了。

```

















