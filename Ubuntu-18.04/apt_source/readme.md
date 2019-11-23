# 修改更新源的方法

本地源地址 /etc/apt/sources.list
将你需要的源覆盖本地源即可，本地源备份为sources.list.bak
cp sources.list sources.list.bak
cp sources.list.xxx sources.list
sudo apt-get update
