# Win10

## windows子系统linux（Ubuntu）开启ssh服务

建议使用netstat -lnp | grep 22，检查 子系统是否在监听22端口
sudo /usr/sbin/sshd -d 查看ssh状态
可以选择关闭windows自带的ssh服务，这个占用了22端口
在windows的 计算机管理->服务和应用程序->服务 里面关闭

Win10中安装Ubuntu子系统后默认是没有开启SSH服务的，需要手动配置开启.

```shell
# 1. 安装ssh服务
sudo apt install openssh-server

# 2. 修改配置文件
sudo vim /etc/ssh/sshd_config
### port 默认是22端口，如果和windows端口冲突或你想换成其他的否则不用动
Port 22
### 如果你需要用 root 直接登录系统则此处改为 yes
PermitRootLogin no
### 将 no 改为 yes 表示使用帐号密码方式登录
PasswordAuthentication no

# 3. 启动ssh服务
service ssh start
## 如果提示sshd error: could not load host key，则用下面的命令重新生成
sudo rm /etc/ssh/ssh*key
dpkg-reconfigure openssh-server

# 4. 查看服务状态
service ssh status  // sshd is running  显示此内容则表示启动正常
# 5. 此时win10可能会跳出防火墙访问设置，如果没有就要主动去修改
打开 Win10 防火墙设置，（可以通过右下角有个向上的箭头点击盾牌快速进入面板）Windows Defender 安全中心，点击下方的高级设置
```

***************

***************

## visual studio 跨平台开发

1. 新建跨平台项目

2. 编码

3. 调试
这里需要录入ssh

4. 代码补全设置（可能需要）

***************
