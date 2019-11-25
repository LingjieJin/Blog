# 在Raspberry 3B+ Debian burst部署Docker

在安装前建议更新软件库

## 1. 使用脚本安装

```bash
# 使用脚本自动安装docker
sudo curl -sSL https://get.docker.com | sh

# docker安装信息 
Executing docker install script, commit: f45d7c11389849ff46a6b4d94e0dd1ffebca32c1
+ sudo -E sh -c apt-get update -qq >/dev/null
+ sudo -E sh -c DEBIAN_FRONTEND=noninteractive apt-get install -y -qq apt-transport-https ca-certificates curl >/dev/null
+ sudo -E sh -c curl -fsSL "https://download.docker.com/linux/raspbian/gpg" | apt-key add -qq - >/dev/null
Warning: apt-key output should not be parsed (stdout is not a terminal)
+ sudo -E sh -c echo "deb [arch=armhf] https://download.docker.com/linux/raspbian buster stable" > /etc/apt/sources.list.d/docker.list
+ sudo -E sh -c apt-get update -qq >/dev/null
+ [ -n  ]
+ sudo -E sh -c apt-get install -y -qq --no-install-recommends docker-ce >/dev/null
+ sudo -E sh -c docker version
Client: Docker Engine - Community
 Version:           19.03.5
 API version:       1.40
 Go version:        go1.12.12
 Git commit:        633a0ea
 Built:             Wed Nov 13 07:37:22 2019
 OS/Arch:           linux/arm
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          19.03.5
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.12.12
  Git commit:       633a0ea
  Built:            Wed Nov 13 07:31:17 2019
  OS/Arch:          linux/arm
  Experimental:     false
 containerd:
  Version:          1.2.10
  GitCommit:        b34a5c8af56e510852c35414db4c1f4fa6172339
 runc:
  Version:          1.0.0-rc8+dev
  GitCommit:        3e425f80a8c931f88e6d94a8c831b9d5aa481657
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683
If you would like to use Docker as a non-root user, you should now consider
adding your user to the "docker" group with something like:

  sudo usermod -aG docker pi

Remember that you will have to log out and back in for this to take effect!

WARNING: Adding a user to the "docker" group will grant the ability to run
         containers which can be used to obtain root privileges on the
         docker host.
         Refer to https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface
         for more information.
```

## 2. 配置

```bash
sudo usermod -aG docker pi

# 运行 hello-world 镜像来做一个测试
sudo docker run arm32v7/hello-world

# 输出信息
Unable to find image 'arm32v7/hello-world:latest' locally
latest: Pulling from arm32v7/hello-world
c1eda109e4da: Pull complete
Digest: sha256:07e995a680212a0a8a01e181b3fff128d44b8fe0c11426b638ec3cde7273f0a3
Status: Downloaded newer image for arm32v7/hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (arm32v7)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/

```

## 4.Example

### 1. Hello World

```bash
# docker run 命令来在容器内运行一个应用程序
docker run ubuntu /bin/echo "Hello world"
Hello world

# 各个参数解析：

# docker Docker 的二进制执行文件。

# run 与前面的 docker 组合来运行一个容器。

# ubuntu 指定要运行的镜像
# Docker 首先从本地主机上查找镜像是否存在，如果不存在，Docker 就会从镜像仓库 Docker Hub 下载公共镜像。

# /bin/echo "Hello world" 在启动的容器里执行的命令
```

### 2. 进入docker 镜像

```bash
docker run -i -t ubuntu /bin/bash

# 进入docker image 的终端
root@94c7fc5e05f4:/#

# 各个参数解析：
# -t: 在新容器内指定一个伪终端或终端
# -i: 允许你对容器内的标准输入 (STDIN) 进行交互

# cat /proc/version
root@94c7fc5e05f4:/# cat /proc/version
Linux version 4.19.75-v7+ (dom@buildbot) (gcc version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1270 SMP Tue Sep 24 18:45:11 BST 2019

# ls
root@94c7fc5e05f4:/# ls
bin  boot  dev  etc  home  lib  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var

```

### 3. 后台启动docker

```bash
root@raspi3b-1:/home/pi# docker run -d ubuntu /bin/sh -c "while true; do echo hello world; sleep 1; done"
640208323e8aa10a5f97cec9bd2ccae85a30f3b6a3f979e1fd406eb79b1d8374

这个长字符串叫做容器 ID，对每个容器来说都是唯一的，我们可以通过容器 ID 来查看对应的容器发生了什么
首先，我们需要确认容器有在运行，可以通过 docker ps 来查看

root@raspi3b-1:/home/pi# docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
640208323e8a        ubuntu              "/bin/sh -c 'while t…"   46 seconds ago      Up 43 seconds                           recursing_neumann

输出详情介绍：

CONTAINER ID: 容器 ID。

IMAGE: 使用的镜像。

COMMAND: 启动容器时运行的命令。

CREATED: 容器的创建时间。

STATUS: 容器状态。

状态有7种：

created（已创建）
restarting（重启中）
running（运行中）
removing（迁移中）
paused（暂停）
exited（停止）
dead（死亡）
PORTS: 容器的端口信息和使用的连接类型（tcp\udp）。

NAMES: 自动分配的容器名称。

在容器内使用 docker logs 命令，查看容器内的标准输出：
root@raspi3b-1:/home/pi# docker logs 640208323e8a
hello world
hello world
hello world
hello world
hello world

```

### 4.停止容器

```bash

root@raspi3b-1:/home/pi# docker stop 640208323e8a
640208323e8a
root@raspi3b-1:/home/pi# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES

```