# 在Raspberry Debian系统下设置systemd自启动
系统 Raspberry 3b+ Debian burst

在网上搜索文章时候，主要发现有两种方式创建，经过尝试后发现两种方法都能使用

---------------------------------------------

#方法一
这个方法是在树莓派官网上查询到的

参考ref : https://www.raspberrypi.org/documentation/linux/usage/systemd.md

1. 创建一个启动脚本

2. 在 /etc/systemd/system/ 目录下创建启动服务： myscript.service

```
[Unit]
Description=My service
After=network.target

[Service]
ExecStart=/usr/bin/python3 -u main.py
WorkingDirectory=/home/pi/myscript
StandardOutput=inherit
StandardError=inherit
Restart=always //如果你的脚本只执行一次 这里需要拉掉
User=pi

[Install]
WantedBy=multi-user.target
```

3. 使能设置

```
sudo cp myscript.service /etc/systemd/system/myscript.service

// 直接启动该服务 该操作只是临时的
sudo systemctl start myscript.service

// 关闭该服务
sudo systemctl stop myscript.service

// 加入开机自启动
sudo systemctl enable myscript.service
```
4. 完成设置

-----------------------------------------

#方法二

参考ref : https://learn.adafruit.com/running-programs-automatically-on-your-tiny-computer/systemd-writing-and-enabling-a-service

1. 创建一个启动脚本：比如
```
```

2. 在 /lib/systemd/system/ 目录下创建 .service 文件，比如 example.service
```
[Unit]
Description=My Service
 
[Service]
ExecStart=(脚本程序执行路径)
StandardOutput=inherit
StandardError=inherit
User=pi
 
[Install]
WantedBy=multi-user.target
```

3. 使能设置
```
sudo systemctl enable example.service
Created symlink /etc/systemd/system/multi-user.target.wants/example.service → /lib/systemd/system/example.service.

sudo systemctl start example.service
```

4. 查看服务是否启动
```
sudo systemctl status example.service
```

5. 完成设置

-------------------------------------------------

# systemctl 操作
```
sudo systemctl list-units --type=target
```




