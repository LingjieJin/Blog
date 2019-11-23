# 修改更新源的方法

1. 将本地源文件 `/etc/apt/sources.list` 替换为sources.list.xxx 同时备份本地源
cp sources.list sources.list.bak
cp sources.list.xxx sources.list

2. 将本地源文件 `/etc/apt/sources.list.d/raspi.list` 替换为raspi.list.xxx 同时备份
cp raspi.list sources.list.bak
cp raspi.list.xxx raspi.list

sudo apt-get update
