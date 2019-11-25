# 使用docker运行一个web应用

```bash

root@raspi3b-1:/home/pi# docker pull training/webapp
Using default tag: latest
latest: Pulling from training/webapp
Image docker.io/training/webapp:latest uses outdated schema1 manifest format. Please upgrade to a schema2 image for better future compatibility. More information at https://docs.docker.com/registry/spec/deprecated-schema-v1/
e190868d63f8: Pull complete
909cd34c6fd7: Pull complete
0b9bfabab7c1: Pull complete
a3ed95caeb02: Pull complete
10bbbc0fc0ff: Pull complete
fca59b508e9f: Pull complete
e7ae2541b15b: Pull complete
9dd97ef58ce9: Pull complete
a4c1b0cb7af7: Pull complete
Digest: sha256:06e9c1983bd6d5db5fba376ccd63bfa529e8d02f23d5079b8f74a616308fb11d
Status: Downloaded newer image for training/webapp:latest
docker.io/training/webapp:latest


root@raspi3b-1:/home/pi# docker run -d -P training/webapp python app.py
c998e3418f23299d398bf9cd4426f84376c665bab5776120a69747b5b83492b6
# 参数说明:
# -d:让容器在后台运行。
# -P:将容器内部使用的网络端口映射到我们使用的主机上。




```