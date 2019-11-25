# Docker Command 指令

## 3. Docker指令

```bash
#查看 Docker 版本
docker -v
Docker version 19.03.5, build 633a0ea

#
sudo docker pull 仓库/镜像:版本 (留空的话默认为 latest)
sudo docker run 加参数，用来创建容器

#查看运行容器
sudo docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
46c5e09150b3        ubuntu              "bash -c 'while true…"   3 hours ago         Up 3 hours                              nostalgic_lewin

#查看所有下载的镜像
sudo docker images
REPOSITORY            TAG                 IMAGE ID            CREATED             SIZE
ubuntu                latest              f576a39bda44        3 weeks ago         46.7MB
arm32v7/hello-world   latest              618e43431df9        10 months ago       1.64kB

#进入容器终端
sudo docker exec -i -t ha /bin/bash

#实时查看10行的 ha 日志
sudo docker logs -f -t --tail 10 ha

#重启 systemctl 守护进程
sudo systemctl daemon-reload

#设置 Docker 开机启动
sudo systemctl enable docker

#开启 Docker 服务
sudo systemctl start docker

#下载 Docker 图形化界面 portainer
sudo docker pull portainer/portainer

#创建 portainer 容器
sudo docker volume create portainer_data

#运行 portainer
sudo docker run -d -p 9000:9000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
```
