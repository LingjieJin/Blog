# 增加 Raspibian 系统交换空间

## 增加 swap 空间

```bash
# 操作
cd /opt
sudo mkdir image
cd image
sudo touch swap
sudo dd if=/dev/zero of=/opt/image/swap bs=1024 count=2048000

# 这里需要等待一会儿 返回信息如下
# 2048000+0 records in
# 2048000+0 records out
# 2097152000 bytes (2.1 GB, 2.0 GiB) copied, 96.007 s, 21.8 MB/s

sudo mkswap /opt/image/swap
## 检查现有的交换空间大小，使用命令free
free -m
## 启动新增加的2G的交换空间，使用命令swapon：
sudo swapon /opt/image/swap
## 确认新增加的2G交换空间已经生效，使用命令free
free -m
## 修改/etc/fstab文件，使得新加的2G交换空间在系统重新启动后自动生效
sudo nano /etc/fstab
## 在文件最后加入 保存
/opt/image/swap /swap swap defaults 0 0
## 重启
sudo reboot

# Raspi输出
pi@raspberrypi:~/ $ cd /opt/
pi@raspberrypi:/opt $ ls -al
total 16
drwxr-xr-x  4 root root 4096 Jul 10 01:13 .
drwxr-xr-x 21 root root 4096 Jul 10 01:27 ..
drwxr-xr-x  3 root root 4096 Jul 10 01:13 pigpio
drwxr-xr-x  6 root root 4096 Jul 10 01:08 vc
pi@raspberrypi:/opt $ sudo mkdir image
pi@raspberrypi:/opt $ ls
image  pigpio  vc
pi@raspberrypi:/opt $ cd image/
pi@raspberrypi:/opt/image $ ls
pi@raspberrypi:/opt/image $ sudo touch swap
pi@raspberrypi:/opt/image $ ls
swap
pi@raspberrypi:/opt/image $ sudo dd if=/dev/zero of=/opt/image/swap bs=1024 count=2048000
2048000+0 records in
2048000+0 records out
2097152000 bytes (2.1 GB, 2.0 GiB) copied, 96.007 s, 21.8 MB/s
pi@raspberrypi:/opt/image $ sudo mkswap /opt/image/swap
mkswap: /opt/image/swap: insecure permissions 0644, 0600 suggested.
Setting up swapspace version 1, size = 2 GiB (2097147904 bytes)
no label, UUID=7b3e4f1c-6a69-42b0-ba8f-e8e9cc206098
pi@raspberrypi:/opt/image $ free -m
              total        used        free      shared  buff/cache   available
Mem:            924          67         262           9         594         780
Swap:            99           4          95
pi@raspberrypi:/opt/image $ sudo swapon /opt/image/swap
swapon: /opt/image/swap: insecure permissions 0644, 0600 suggested.
pi@raspberrypi:/opt/image $ free -m
              total        used        free      shared  buff/cache   available
Mem:            924          67         262           9         594         780
Swap:          2099           4        2095

```
