# 方法
1. 找到设置文件 /etc/dhcpcd.conf
2. 设置文件
## example
****************************************
interface eth0

static ip_address=192.168.0.10/24
static routers=192.168.0.1
static domain_name_servers=192.168.0.1

interface wlan0

static ip_address=192.168.0.200/24
static routers=192.168.0.1
static domain_name_servers=192.168.0.1
*****************************************
eth0是有线的配置，wlan0是无线配置
ip_address就是静态IP，后面要接/24
routers是网关
static domain_name_servers是DNS
3. 配置生效
sudo reboot
