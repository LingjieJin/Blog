# 获取当前Linux系统的信息

## 
```
# 使用`uname -a`获取电脑和操作系统信息
Linux raspberrypi 4.19.57-v7l+ #1244 SMP Thu Jul 4 18:48:07 BST 2019 armv7l GNU/Linux

# cat /proc/version 获取内核版本
Linux version 4.19.57-v7l+ (dom@buildbot) (gcc version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1244 SMP Thu Jul 4 18:48:07 BST 2019

# cat /etc/issue 显示发行版本
Raspbian GNU/Linux 10 \n \l

# lsb_release -a 获取发行版信息
No LSB modules are available.
Distributor ID: Raspbian
Description:    Raspbian GNU/Linux 10 (buster)
Release:        10
Codename:       buster
```
