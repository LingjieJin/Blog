# 收集的shell常用指令

## 获取当前ip地址
```
ifconfig eth0 | grep "inet " | awk '{print $2}'
```

## 获取ssid 
```
iwlist wlan0 scan | grep ESSID | cut -d"\"" -f 2
```



