### Raspberry 3B+ 
### Raspbian buster
### opencv 4.1.1
### opencv_contrib 4.1.1

## 1.烧录树莓派镜像文件
## 2.在boot目录下新建ssh空白文件，可以通过ssh登录树莓派
## 3.进入树莓派系统，修改软件源
清华大学源地址：https://mirrors.tuna.tsinghua.edu.cn/help/raspbian/
···
cd /etc/apt/

# 编辑 `/etc/apt/sources.list` 文件，删除原文件所有内容，用以下内容取代：
deb http://mirrors.tuna.tsinghua.edu.cn/raspbian/raspbian/ buster main non-free contrib
deb-src http://mirrors.tuna.tsinghua.edu.cn/raspbian/raspbian/ buster main non-free contrib

# 编辑 `/etc/apt/sources.list.d/raspi.list` 文件，删除原文件所有内容，用以下内容取代：
deb http://mirrors.tuna.tsinghua.edu.cn/raspberrypi/ buster main ui
···
## 4.更新 apt-get update apt-get upgrade

## 1.使能树莓派摄像头
sudo raspi-config
进入interface option选项 选择 camera 使能
系统会自动重启

## 2. 重启后可以查看是否有摄像头
ls -al /dev/ | grep video
```
root@raspberrypi:/home/pi# ls -al /dev/ |grep video
crw-rw----   1 root video    29,   0 Oct 21 07:45 fb0
crw-rw----   1 root video   241,   0 Oct 21 07:45 media0
crw-rw----   1 root video   243,   0 Oct 21 07:45 vchiq
crw-rw----   1 root video   248,   0 Oct 21 07:45 vcio
crw-rw----   1 root video   244,   0 Oct 21 07:45 vcsm
crw-rw----+  1 root video    81,   3 Oct 21 07:45 video0
crw-rw----+  1 root video    81,   0 Oct 21 07:45 video10
crw-rw----+  1 root video    81,   1 Oct 21 07:45 video11
crw-rw----+  1 root video    81,   2 Oct 21 07:45 video12
```

## 3.使用树莓派摄像头获取图片
raspistill -o image.jpg

这里讲一下raspistill命令的相关参数和实验的具体效果：

-v：调试信息查看
-w：图像宽度
-h：图像高度
-rot：图像旋转角度，只支持 0、90、180、270 度（这里说明一下，测试发现其他角度的输入都会被转换到这四个角度之上）
-o：图像输出地址，例如image.jpg，如果文件名为“-”，将输出发送至标准输出设备
-t：获取图像前等待时间，默认为5000，即5秒
-tl：多久执行一次图像抓取

执行下面的指令：

raspistill -o image%d.jpg -rot 180 -w 1024 -h 768 -t 20000 -tl 5000 -v

ref:https://www.cnblogs.com/uestc-mm/p/7587783.html


# 编译opencv

## 设置系统交换空间
## 系统优化设置：增加swap空间 

```
cd /opt 
sudo mkdir image 
cd image
sudo touch swap 
sudo dd if=/dev/zero of=/opt/image/swap bs=1024 count=2048000 
## 过一段时间会返回信息，这个过程有点小长，注意不是死机了，耐心等一等。
## 返回的信息大概是： 2048000+0 records in 2048000+0 records out 2097152000 bytes (2.1 GB, 2.0 GiB) copied, 242.095 s, 8.7 MB/s

sudo mkswap /opt/image/swap 
## 检查现有的交换空间大小，使用命令free
free -m

## 启动新增加的2G的交换空间，使用命令swapon：
sudo swapon /opt/image/swap

## 确认新增加的2G交换空间已经生效，使用命令free 
free -m

## 修改/etc/fstab文件，使得新加的2G交换空间在系统重新启动后自动生效 
sudo vim /etc/fstab
## 在文件最后加入： 
/opt/image/swap /swap swap defaults 0 0

sudo reboot

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
pi@raspberrypi:/opt/image $
```

## 依赖库安装


1.官方必须依赖库
```
sudo apt-get update

sudo apt-get install cmake git

sudo apt-get install build-essential \
                     libgtk2.0-dev \
                     pkg-config \
                     libavcodec-dev \
                     libavformat-dev 
## sudo apt-get install -y build-essential libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev 
```

2.官方建议依赖库
```
sudo apt-get install python-dev \
                     libtbb2 \
                     libtbb-dev \
                     libjpeg-dev \
                     libpng-dev \
                     libtiff-dev \
                     libjasper-dev \
                     libdc1394-22-dev
## sudo apt-get install -y python-dev libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
```

3.opengl支持依赖库
```
sudo apt-get install -y freeglut3-dev mesa-common-dev libgtkglext1 libgtkglext1-dev
```

4.视频解码支持依赖库
```
sudo apt-get install checkinstall \
                     yasm \
                     libgstreamer0.10-dev \
                     libgstreamer-plugins-base0.10-dev \
                     libv4l-dev \
                     libtbb-dev \
                     libqt4-dev \
                     libgtk2.0-dev \
                     libmp3lame-dev \
                     libtheora-dev \
                     libvorbis-dev \
                     libxvidcore-dev \
                     x264 \
                     v4l-utils

## sudo apt-get install -y yasm libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev libtbb-dev libqt4-dev libgtk2.0-dev libmp3lame-dev libtheora-dev libvorbis-dev libxvidcore-dev x264 v4l-utils
```

5.其他依赖
```
sudo apt-get install libgphoto2-dev \
                     libavresample-dev \ 
                     liblapacke-dev \
                     gtk+-3.0 \
                     libgtk-3-dev \ 
                     libeigen3-dev \ 
                     tesseract-ocr \
                     liblept5 \
                     leptonica-progs \
                     libleptonica-dev
## sudo apt-get install -y libgphoto2-dev libavresample-dev liblapacke-dev gtk+-3.0 libgtk-3-dev libeigen3-dev tesseract-ocr liblept5 leptonica-progs libleptonica-dev
```


下载 OpenCV
```
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git
```

编译安装OpenCV 和 OpenCV_contribute
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D INSTALL_C_EXAMPLES=ON \
      -D INSTALL_PYTHON_EXAMPLES=ON \
      -D BUILD_EXAMPLES=ON \
      -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib-3.0.0/modules \ ## 加入额外库编译 建议路径使用绝对路径
      -D ENABLE_PRECOMPILED_HEADERS=OFF
      -D OPENCV_GENERATE_PKGCONFIG=ON \ ## 使能pkgconfig设置 4.0版本后如果不主动打开不会产生opencv.pc文件 库搜索应该使用opencv4而不是原先的opencv
      ###### 额外选项
      -D WITH_CUDA=ON \
      -D WITH_CUBLAS=1 \
      -D ENABLE_FAST_MATH=1 \
      -D CUDA_FAST_MATH=1 \
      -D WITH_CUFFT=ON \
      -D WITH_NVCUVID=ON \
      -D WITH_V4L=ON \
      -D WITH_LIBV4L=ON \
      -D WITH_OPENGL=ON \
      -D WITH_FFMPEG=ON \
      -D BUILD_TIFF=ON \
      -D WITH_LAPACK=OFF..
      -D INSTALL_C_EXAMPLES=ON \
      ..
sudo make -j4 ## 根据自己的处理器选择
sudo make clean ## 慎用 如果你想再喝一杯咖啡
sudo make install


### 在树莓派和ubuntu系统上都曾碰到同一个问题 需要加入-D ENABLE_PRECOMPILED_HEADERS=OFF选项才能继续编译
### 这里列出我编译时候的指令
```
cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D INSTALL_C_EXAMPLES=ON \
      -D INSTALL_PYTHON_EXAMPLES=ON \
      -D BUILD_EXAMPLES=ON \
      -D ENABLE_PRECOMPILED_HEADERS=OFF \
      -D OPENCV_GENERATE_PKGCONFIG=ON \
      -D OPENCV_EXTRA_EXE_LINKER_FLAGS=-latomic \
      -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-4.1.1/modules/ ..
```

### 配置 OpenCV 环境变量
```
### 编辑或新建 /etc/ld.so.conf.d/opencv.conf
sudo vim /etc/ld.so.conf.d/opencv.conf

### 添加下面这一句 表明opencv库的位置
/usr/local/lib

### 保存后退出，再输入命令
sudo ldconfig

### 然后更改环境变量，输入命令
sudo gedit /etc/bash.bashrc

### 打开之后，在文件最后面输入以下内容:
PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig 
export PKG_CONFIG_PATH
source ~/.bashrc

### 保存退出
```



