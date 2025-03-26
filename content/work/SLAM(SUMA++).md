+++
authors = ["李佳潞"]
title = "SUMA++"
date = "2024-12-11"
categories = [
    "SLAM"
]
series = [""]
tags = [
   "视觉","语义"
]
+++

- [一. 程序](#一-程序)
- [二. 流程](#二-流程)
- [三. 问题](#三-问题)
- [四. 本地复现](#四-本地复现)
- [五. tips](#五-tips)

# 一. 程序

源码：<https://github.com/PRBonn/semantic_suma>

# 二. 流程

(1) 容器构建好之后
(2) 修改config/default.xml中model_path为darknet53的路径
```xml
<param name="model_path" type="string">/catkin_ws/src/semantic_suma/darknet53</param>
```
(3) ./semantic_suma/bin/visualizer
(4) 第一次运行，选择给的例子
```yaml
rangenet_lib_forTensorRT8XX/example #例子路径
```
来构建.trt 文件
# 三. 问题

1. tensorRT解析ONNX超时

(1) 问题输出

```bash
WARNING: ONNX model has a newer ir_version (0.0.4) than this parser was built against (0.0.3).
 ----- Parsing of ONNX model src/rangenet_lib/model/darknet53//model.onnx is Done ---- 
Success picking up ONNX model
Failure creating engine from ONNX model
Current trial size is 8589934592
Failure creating engine from ONNX model
Current trial size is 4294967296
Failure creating engine from ONNX model
Current trial size is 2147483648
Failure creating engine from ONNX model
Current trial size is 1073741824
Failure creating engine from ONNX model
Current trial size is 536870912
Failure creating engine from ONNX model
Current trial size is 268435456
Failure creating engine from ONNX model
Current trial size is 134217728
Failure creating engine from ONNX model
Current trial size is 67108864
Failure creating engine from ONNX model
Current trial size is 33554432
Failure creating engine from ONNX model
Current trial size is 16777216
Failure creating engine from ONNX model
Current trial size is 8388608
Failure creating engine from ONNX model
Current trial size is 4194304
Failure creating engine from ONNX model
Current trial size is 2097152
Failure creating engine from ONNX model
Current trial size is 1048576
terminate called after throwing an instance of 'std::runtime_error'
  what():  ERROR: could not create engine from ONNX.
Aborted (core dumped)
```

(2) 问题详细链接

<https://github.com/PRBonn/rangenet_lib/issues/15>

(3) 解决方案

a. 修改tensorrt镜像以及默认的对应版本的驱动和模型，因为我的显卡是4060Ti，与 TensorRT 5.1.5不兼容

b. 修改rangenet版本

c. 修改ubuntu版本

d. 修改opencv路径

e. 以上内容修改后dockerfile如下：
```yaml
FROM nvcr.io/nvidia/tensorrt:22.12-py3

ARG DEBIAN_FRONTEND=noninteractive

ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics
    
RUN apt-get -y update &&\
    apt-get -y upgrade &&\
    apt-get install -y apt-utils build-essential cmake curl libgtest-dev libeigen3-dev libboost-all-dev qtbase5-dev libglew-dev qt5-default git libyaml-cpp-dev libopencv-dev vim

RUN apt-get -y install software-properties-common &&\
    add-apt-repository ppa:borglab/gtsam-release-4.0 &&\
    apt-get -y update &&\
    apt-get install -y libgtsam-dev libgtsam-unstable-dev

RUN apt-get install -y lsb-release &&\
    sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' &&\
    curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - &&\
    apt-get update -y &&\
    apt-get install -y ros-noetic-desktop-full
RUN apt-get install -y python3-catkin-pkg python3-wstool python3-rosdep ninja-build stow python3-rosinstall python3-rosinstall-generator

RUN rosdep init &&\
    sudo rosdep fix-permissions &&\
    rosdep update

RUN python3 -m pip install --upgrade pip
RUN pip install catkin_tools catkin_tools_fetch empy trollius numpy rosinstall_generator

RUN mkdir -p /catkin_ws/src
WORKDIR /catkin_ws/src
RUN git clone http://github.com/ros/catkin.git &&\
    git clone https://github.com/vincenzo0603/rangenet_lib_forTensorRT8XX
RUN cd ../ && catkin init &&\
    catkin build rangenet_lib
    RUN pkg-config --cflags opencv4 &&\
    ln -s /usr/include/opencv4/opencv2 /usr/include/opencv2

    RUN git clone http://github.com/PRBonn/semantic_suma.git &&\
    sed -i 's|#include <opencv2/core/core.hpp>|#include <opencv2/core.hpp>|g' /catkin_ws/src/semantic_suma/src/rv/Laserscan.h &&\
    sed -n '17p' /catkin_ws/src/semantic_suma/src/rv/Laserscan.h &&\
    sed -i 's/find_package(Boost REQUIRED COMPONENTS filesystem system)/find_package(Boost 1.65.1 REQUIRED COMPONENTS filesystem system serialization thread date_time regex timer chrono)/g' /catkin_ws/src/semantic_suma/CMakeLists.txt &&\
    catkin init &&\
    catkin deps fetch &&\
    cd glow && git checkout e66d7f855514baed8dca0d1b82d7a51151c9eef3 && cd ../ &&\
    catkin build --save-config -i --cmake-args -DCMAKE_BUILD_TYPE=Release -DOPENGL_VERSION=430 -DENABLE_NVIDIA_EXT=YES
    
WORKDIR /catkin_ws/src/semantic_suma
RUN wget https://www.ipb.uni-bonn.de/html/projects/semantic_suma/darknet53.tar.gz &&\
    tar -xvf darknet53.tar.gz
    
WORKDIR /catkin_ws/src

```

链接： <https://github.com/heirenlop/semantic_suma_docker_ternsorRT8x>

# 四. 本地复现

可复现，测试KITTI数据集结果：

<div class="container" style="display: flex; justify-content: center;">
       <video controls width="640" height="360">
           <source src="/videos/work-record/suma++1080p.mp4" type="video/mp4">
       </video>
</div>


# 五. tips

play按钮的位置实在是太小


<div class="container">
                <div class="image">
                    <figure>
                    <a data-fancybox="gallery" href="/images/work-record/suma++.png">
                        <img src="/images/work-record/suma++.png">
                        </a>
                        <figcaption>抽象play按钮</figcaption>
                    </figure>
                </div>