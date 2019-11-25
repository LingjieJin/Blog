## 
系统优化设置：增加swap空间
1：
cd /opt
sudo mkdir image
sudo touch swap
sudo dd if=/dev/zero of=/opt/image/swap bs=1024 count=2048000
过一段时间会返回信息，这个过程有点小长，注意不是死机了，耐心等一等。返回的信息大概是：
2048000+0 records in
2048000+0 records out
2097152000 bytes (2.1 GB, 2.0 GiB) copied, 242.095 s, 8.7 MB/s
 
2：
sudo mkswap /opt/image/swap
检查现有的交换空间大小，使用命令free：
free -m
 
3：
启动新增加的2G的交换空间，使用命令swapon：
sudo swapon /opt/image/swap
 
确认新增加的2G交换空间已经生效，使用命令free
free -m
 
4：
修改/etc/fstab文件，使得新加的2G交换空间在系统重新启动后自动生效
sudo vim /etc/fstab
 
5：
在文件最后加入：
/opt/image/swap    /swap    swap    defaults 0 0


### 依赖库安装

***
1.官方必须依赖库
```
sudo apt-get update
sudo apt-get install cmake git
sudo apt-get install build-essential \
                     libgtk2.0-dev \
                     pkg-config \
                     libavcodec-dev \
                     libavformat-dev
## sudo apt-get install build-essential libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev
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
## sudo apt-get install python-dev libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
```

3.opengl支持依赖库
```
sudo apt-get install freeglut3-dev mesa-common-dev libgtkglext1 libgtkglext1-dev
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

## sudo apt-get install yasm libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev libtbb-dev libqt4-dev libgtk2.0-dev libmp3lame-dev libtheora-dev libvorbis-dev libxvidcore-dev x264 v4l-utils
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
## sudo apt-get install libgphoto2-dev libavresample-dev liblapacke-dev gtk+-3.0 libgtk-3-dev libeigen3-dev tesseract-ocr liblept5 leptonica-progs libleptonica-dev
```

***

***
库依赖整理
安装OpenCV的相关工具

安装cmake编译器
sudo apt-get install build-essential cmake git pkg-config

安装OpenCV的图像工具包
/*************************/
libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev
/**************************/
sudo apt-get install libjpeg8-dev 
sudo apt-get install libtiff5-dev 
sudo apt-get install libjasper-dev 
sudo apt-get install libpng12-dev 

安装视频I/O包
sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get install libxvidcore-dev libx264-dev

安装gtk2.0和优化函数包
sudo apt-get install libgtk2.0-dev
sudo apt-get install libatlas-base-dev gfortran

安装一些opencv的内部库，例如矩阵操作
sudo apt-get install libatlas-base-dev gfortran

安装python2.7 和 python 3的一些开发工具
sudo apt-get install python2.7-dev python3-dev

libhdf5
 sudo apt-get update
    sudo apt-get install libhdf5-dev libhdf5-serial-dev

/******/
sudo apt-get update
sudo apt-get install -y build-essential git cmake pkg-config \
    libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev \
    libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
    libxvidcore-dev libx264-dev libgtk2.0-dev \
    libatlas-base-dev gfortran \
    python2.7-dev python3-dev
/******/

/******/
sudo apt-get update
$ sudo apt-get upgrade
$ sudo apt-get -y install build-essential cmake cmake-qt-gui pkg-config 
                libpng12-0 libpng12-dev libpng++-dev libpng3 libpnglite-dev 
                zlib1g-dbg zlib1g zlib1g-dev pngtools libtiff5-dev libtiff5 libtiffxx0c2 libtiff-tools
$ sudo apt-get install libgtk2.0-dev
/******/



### 下载 OpenCV
```
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git
```


### 编译安装 OpenCV
```
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D INSTALL_C_EXAMPLES=ON \
      -D INSTALL_PYTHON_EXAMPLES=ON \
      -D BUILD_EXAMPLES=ON \
      -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib-3.0.0/modules \ ## 加入额外库编译 建议路径使用绝对路径
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

### OpenCV库信息和版本查看

```
### 4.1.1版本需要使用opencv4查看
pkg-config --modversion opencv4
pkg-config --libs opencv4
pkg-config --cflags opencv4
```

### 使用 cmake 编译 OpenCV 项目

```
### 新建CMakeLists.txt文件并添加以下内容
set(OpenCV_DIR /usr/local/share/OpenCV)
find_package(OpenCV 4.0.1 REQUIRED)
include_directories(SYSTEM ${OpenCV_INCLUDE_DIRS} /usr/local/include)
```
```
cmake_minimum_required(VERSION 2.8)
project( DisplayImage )
set(OpenCV_DIR /usr/local/opencv-4.0.1/lib/cmake/opencv4)
find_package(OpenCV REQUIRED )
add_executable( opencv_test opencv_test.cpp )
target_link_libraries( opencv_test ${OpenCV_LIBS} )
```

```
### 执行
cmake . -DCMAKE_CXX_FLAGS="-std=c++11" # opencv4.0 需要 c++ 11 支持
make
./opencv_test test.jpg
```

##
安装CMake等编译openCV源码的工具

sudo apt-get install build-essential cmake pkg-config
安装几种常见格式的图像操作的包，方便我们能从硬盘上读取不同格式的图像

sudo apt-get install libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev
同样的，我们也需要视频操作的包

sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
下面安装gtk2.0（树莓派很可能下载错误，更换中科大或者清华源即可，ubuntu有可能出现包版本过高的情况，需要将依赖包降级安装）

 sudo apt-get install libgtk2.0-dev
优化函数包

  sudo apt-get install libatlas-base-dev gfortran

### 安装过程遇到的问题

***

#### 编译安装 ippicv 库的特别慢的解决办法

1.下载地址 直接访问OpenCV在Github上的opencv_3rdparty也可以找到文件的具体地址 https://github.com/opencv/opencv_3rdparty/tree/ippicv/master_20170418/ippicv

2.修改cmake 
将 opencv/3rdparty/ippicv文件夹下的 ippicv.cmake中，第47行
```
https://raw.githubusercontent.com/opencv/opencv_3rdparty/${IPPICV_COMMIT}/ippicv/
改成： 
file://{刚刚手动下载的IPP文件的上一级目录}/
```

参考：
[1](https://yinguobing.com/install-ippcv-manually/)
[2](https://www.cnblogs.com/yongy1030/p/10293178.html)

***

***
#### OpenCV 4.0.1 CUDA 编译问题
1.设置 --DWITH_CUDA=ON 时需要设置 -DOPENCV_EXTRA_MODULES_PATH=<opencv_contrib>/modules

2.如果没有contrib额外库, make 的时候会出现错误：gpu_mat.cu:47:2: error: #error "opencv_cudev is required".
Github - opencv_contrib

3.在 opencv_contrib/modules/face 中会要下载 face_landmark_model.dat 文件(69M)，也会遇到下载慢的问题，可以采用类似于 ippicv 库的处理方式.

face_landmark_model.mat 下载路径：

https://github.com/opencv/opencv_3rdparty/tree/contrib_face_alignment_20170818

在opencv_contrib/modules/face/CMakeLists.txt 文件：
```
set(__commit_hash "8afa57abc8229d611c4937165d20e2a2d9fc5a12")
set(__file_hash "7505c44ca4eb54b4ab1e4777cb96ac05")
ocv_download(
    FILENAME face_landmark_model.dat
    HASH ${__file_hash}
    URL
      "${OPENCV_FACE_ALIGNMENT_URL}"
      "$ENV{OPENCV_FACE_ALIGNMENT_URL}"
      "https://raw.githubusercontent.com/opencv/opencv_3rdparty/${__commit_hash}/"
    DESTINATION_DIR "${CMAKE_BINARY_DIR}/${OPENCV_TEST_DATA_INSTALL_PATH}/cv/face/"
    ID "data"
    RELATIVE_URL
    STATUS res
)
if(NOT res)
  message(WARNING "Face: Can't get model file for face alignment.")
endif()
```
将离线下载的 face_landmark_model.dat 放到 /opt/opencv-4.0.1/build/share/opencv4/testdata/cv/face/ 路径中.
***

***
### 25% fatal error: Eigen/Core: No such file or directory
解决方法有很挺多的，具体可以看这里：
https://github.com/opencv/opencv/issues/14868
在我的机子上使用一下方式：
```
sudo ln -s /usr/include/eigen3/Eigen /usr/include/Eigen
```
将库链接设置一下
ok
***

***
### 在Raspberry上编译opencv4.1.1遇到的问题
ref:https://github.com/opencv/opencv/issues/13328
ref:https://github.com/opencv/opencv/pull/15225
ref:https://github.com/opencv/opencv/issues/15495
ref:https://github.com/opencv/opencv/issues/15278
ref:https://github.com/opencv/opencv/issues/15192

加上-DOPENCV_EXTRA_EXE_LINKER_FLAGS=-latomic解决atomic不能找到问题
加上-DENABLE_PRECOMPILED_HEADERS=OFF 能解决大部分问题

### issues Undefined reference to __atomic_xxx #15278
ref:https://github.com/opencv/opencv/issues/15278
-DCMAKE_CXX_FLAGS=-latomic -DOPENCV_EXTRA_EXE_LINKER_FLAGS=-latomic

***
