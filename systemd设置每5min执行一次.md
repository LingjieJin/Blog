# 使用systemd设置每5min执行一次的脚本

ref:http://www.ruanyifeng.com/blog/2018/03/systemd-timer.html

## 1设置执行脚本service
在/usr/lib/systemd/system目录里面新建一个文件，比如mytimer.service文件
你可以写入下面的内容:
```
[Unit]
Description=MyTimer

[Service]
ExecStart=/bin/bash /path/to/mail.sh
```
ExecStart：systemctl start所要执行的命令
ExecStop：systemctl stop所要执行的命令
ExecReload：systemctl reload所要执行的命令
ExecStartPre：ExecStart之前自动执行的命令
ExecStartPost：ExecStart之后自动执行的命令
ExecStopPost：ExecStop之后自动执行的命令

注意，定义的时候，所有路径都要写成绝对路径，比如bash要写成/bin/bash，否则 Systemd 会找不到。


## 2设置timer单元
Service 单元只是定义了如何执行任务，要定时执行这个 Service，还必须定义 Timer 单元。
/usr/lib/systemd/system目录里面，新建一个mytimer.timer文件
写入下面的内容：
```
Unit]
Description=Runs mytimer every hour

[Timer]
OnUnitActiveSec=1h
Unit=mytimer.service ## 之前的执行service

[Install]
WantedBy=multi-user.target
```
[Timer]部分定制定时器。Systemd 提供以下一些字段：
OnActiveSec：定时器生效后，多少时间开始执行任务
OnBootSec：系统启动后，多少时间开始执行任务
OnStartupSec：Systemd 进程启动后，多少时间开始执行任务
OnUnitActiveSec：该单元上次执行后，等多少时间再次执行
OnUnitInactiveSec： 定时器上次关闭后多少时间，再次执行
OnCalendar：基于绝对时间，而不是相对时间执行
AccuracySec：如果因为各种原因，任务必须推迟执行，推迟的最大秒数，默认是60秒
Unit：真正要执行的任务，默认是同名的带有.service后缀的单元
Persistent：如果设置了该字段，即使定时器到时没有启动，也会自动执行相应的单元
WakeSystem：如果系统休眠，是否自动唤醒系统

OnUnitActiveSec=1h表示一小时执行一次任务
其他的写法还有
OnUnitActiveSec=*-*-* 02:00:00表示每天凌晨两点执行
OnUnitActiveSec=Mon *-*-* 02:00:00表示每周一凌晨两点执行
官方文档：https://www.freedesktop.org/software/systemd/man/systemd.time.html




