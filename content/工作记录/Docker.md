---
title: "Docker"
date: 2024-12-03
draft: false
---
# 一. Docker APT安装

1. 更新 APT 包索引
首先，确保系统的软件包索引是最新的：

```bash
sudo apt update
```

2. 安装依赖包
Docker 需要一些依赖包来确保能够通过 HTTPS 安全地下载软件包。运行以下命令安装这些依赖：

```bash
sudo apt install apt-transport-https ca-certificates curl software-properties-common
```

3. 添加 Docker 的官方 GPG 密钥
Docker 使用 GPG 密钥来确保安装包的安全性。运行以下命令添加 Docker 的官方 GPG 密钥：

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

4. 添加 Docker APT 仓库
将 Docker 的官方 APT 仓库添加到系统中：

```bash
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

这将确保你从 Docker 的官方仓库安装软件包。

5. 更新 APT 包索引
添加完 Docker 仓库后，再次更新包索引以确保 APT 获取到最新的 Docker 包：

```bash
sudo apt update
```

6. 安装 Docker
现在，你可以安装 Docker 社区版（docker-ce）了：

```bash
sudo apt install docker-ce
```

7. 启动 Docker 服务并设置开机自启
安装完成后，启动 Docker 服务并设置它在系统启动时自动启动：

```bash
sudo systemctl start docker
sudo systemctl enable docker
```

8. 验证 Docker 是否安装成功
安装完成后，验证 Docker 是否安装成功，可以查看 Docker 版本：

```bash
docker --version
```

如果安装成功，你会看到类似如下的输出：

```bash
Docker version 20.10.x, build xxxx
```

9. 检查 Docker 服务状态

你还可以检查 Docker 服务的状态，确保它正在运行：

```bash
sudo systemctl status docker
```

如果 Docker 正常运行，输出将类似于：

```yaml
● docker.service - Docker Application Container Engine
     Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: enabled)
     Active: active (running) since Mon 2024-12-03 10:52:03 UTC; 3h 27min ago
```

10. 运行 Docker 测试容器
验证 Docker 是否能够正常工作，运行一个简单的测试容器：

```bash
sudo docker run hello-world
```

如果 Docker 工作正常，你将看到以下消息：

```bash
Hello from Docker!
This message shows that your installation appears to be working correctly.
```

11. （可选）将当前用户添加到 Docker 组
默认情况下，使用 Docker 命令需要加 sudo。如果你希望不使用 sudo 来运行 Docker，可以将当前用户添加到 Docker 组：

```bash
sudo usermod -aG docker $USER
```

然后，你需要注销并重新登录，或者运行以下命令以立即生效：

```bash
newgrp docker
```

12. 检查 Docker 版本和信息
如果你已经将用户添加到 Docker 组，可以直接运行以下命令来验证 Docker 信息：

```bash
docker info
```

这将显示有关 Docker 系统的详细信息，包括存储驱动、网络设置等。

# 二. 下载镜像加速

因为墙的原因，在docker pull镜像的时候会很慢，或者说根本pull不下来，我ping的结果是丢包率100%。

![ping](/images/work-record/ping.png "丢包率")

## 方法1. 科学上网

挂梯子+开tun模式。

## 方法2. 使用国内docker的镜像

(1) 创建或修改 /etc/docker/daemon.json：

```bash

sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
    "registry-mirrors": [
        "https://dockerproxy.com",
        "https://docker.mirrors.ustc.edu.cn",
        "https://docker.nju.edu.cn"
    ]
}
EOF
```

----------------
2024-12-03更新
可用镜像源：

```bash
"https://hub.geekery.cn",
"https://hub.littlediary.cn",
"https://docker.rainbond.cc",
"https://docker.unsee.tech",
"https://docker.m.daocloud.io",
"https://hub.crdz.gq",
"https://docker.nastool.de"
```

-----------------

(2) 重启 Docker 服务

```bash
sudo systemctl daemon-reload
sudo systemctl restart docker
```

(3) 重新运行 Docker 测试容器

```bash
sudo docker run hello-world
```

(4) 参考
<https://www.coderjia.cn/archives/dba3f94c-a021-468a-8ac6-e840f85867ea>

# 三. 修改镜像存储路径

(1) 查看当前存储路径以及存储空间

```bash
sudo docker info   # 查看docker数据存储路径，默认为Docker Root Dir:/var/lib/docker
sudo docker system df # 查看docker数据占用的存储空间，-v参数是详细列出
```

(2) 修改/etc/docker/daemon.json 文件

```bash
sudo vim /etc/docker/daemon.json  # 新建配置文件，在其中输入以下信息
 
{
"data-root": "/data/docker",  # 配置docker数据路径
"registry-mirrors": ["http://hub-mirror.c.163.com"]  # 配置国内源[可选]
}
```

(3) 将原文件拷贝到新目录下

```bash
# 将原来docker中存储的数据copy到新的存储目录下
sudo cp -r /var/lib/docker /data/docker
```

(4) 重启docker服务

```bash
sudo systemctl daemon-reload
sudo systemctl restart docker
 
# 查看image信息
docker images
 
# 可以将之前的目录中数据删除
rm -rf /var/lib/docker
```

(5) 参考
<https://blog.csdn.net/weixin_43145427/article/details/123770971>

# 四. Docker build/run/compose

1. 根据dockerfile构建镜像

   ```bash
   docker build -t 镜像名:版本号 
   ```

2. 构建并运行单个容器

   ```bash
   docker run 参数 镜像名 命令
   ```

    **docker run的部分参数一览**
----------------------------------------------------------------------------------------------------------------------
| **命令/选项**               | **说明**                                                                                 |
|-----------------------------|-----------------------------------------------------------------------------------------|
| `-it`            | 以交互模式运行容器。                                                                      |
| `--name <container-name>`       | 为容器设置的名称                                      |
| `-p <host-port>:<container-port>` | 将主机端口映射到容器端口，以支持远程连接。也可以进行容器间通讯。                              |
| `--rm`                      | 容器退出时自动删除。                                                                      |
| `--gpus all`                | 启用容器内的 GPU 支持（需要 NVIDIA 驱动和容器工具）。                                        |
| `-e DISPLAY=$DISPLAY`       | 将宿主机的 `DISPLAY` 环境变量传递给容器，以支持 GUI 显示。                                    |
| `-v /tmp/.X11-unix:/tmp/.X11-unix` | 将主机的 X11 套接字挂载到容器内，以支持远程显示。                                      |
| `-v $(pwd):/workspace`      | 将当前工作目录挂载到容器内的 `/workspace`，便于访问代码和数据。                                |
| `-v /host/path:/container/path` | 将宿主机目录挂载到容器内。                          |
| `--name pytorch-container`  | 为容器指定名称为 `pytorch-container`，方便后续管理。                                         |
| `xhost +local:root`         | 允许本地的 root 用户访问宿主机的显示环境，支持容器图像输出。                                   |
| `xhost -local:root`         | 取消 root 用户对宿主机显示环境的访问权限（安全关闭后设置）。                                   |
| `plt.show()`                | 使用 `matplotlib` 在宿主机上显示图像（需要确保正确配置 `DISPLAY` 和 X11 访问）。               |
| `-e DISPLAY=:0`             | 如果 `DISPLAY` 未正确传递，可以显式指定为 `:0`（宿主机的显示编号）。                           |
----------------------------------------------------------------------------------------------------------------------


3. 构建并运行多个容器(需要docker compose.yaml)

   ```bash
   docker-compose up -d
   ```

# 五. 镜像操作

1. 删除镜像：

   ```bash
   docker rmi 镜像名/镜像号 # -f强制删除
   ```

2. 查看镜像详细信息

   ```bash
   docker inspect 镜像号
   ```

3. 修改镜像名称

   ```bash
   docker tag 镜像名:镜像版本号 新镜像名:新镜像版本号
   删除原镜像
   docker rmi 镜像名:镜像版本号  # -f强制删除
   ```

4. 迁移镜像
    ```bash
   docker save -o /path/to/your/destination/your_image.tar your_image:latest #镜像保存到一个tar文件

   mv /path/to/your/destination/your_image.tar /other/your_image.tar #移动到其他目录

   docker rmi your_image:latest #删除镜像

   docker load -i /other/your_image.tar #从tar文件加载镜像

   rm /other/your_image.tar #删除tar文件
    ```

# 六. 容器操作

1. 启动容器：

   ```bash
   docker start 容器名/容器号
   ```

   进入容器终端

   ```bash
   docker exec -it 容器名/容器号 bash
   ```

1. 停止容器：

   ```bash
   docker stop 容器名/容器号  # -f强制停止
   ```

2. 删除容器：

   ```bash
   docker rm 容器名/容器号 # -f强制删除
   ```

3. 修改容器名称

```bash
docker rename 旧容器名 新容器名
```

4. 复制
复制宿主机文件到容器中
```bash
docker cp 宿主机文件路径 容器id:容器内路径 # docker cp /home/heirenlop/workspace/Dataset 356d3fe40061:/workspace/
```
复制容器文件到宿主机
```bash
docker cp 容器id:容器内文件路径 宿主机文件路径 #docker cp 18f7b9c8b3ab:/root/park_dataset_ros2 ./
```


# 七. Dockerfile写法

以SUMA++中dockerfile为例
```bash
# CUDA 10.1.243, cuDNN 7.6.2, TensorRT 5.1.5
# FROM nvcr.io/nvidia/tensorrt:19.08-py3

# CUDA 11.3、cuDNN 8.2.1 和 TensorRT 8.2.1。
FROM nvcr.io/nvidia/tensorrt:21.11-py3 

ARG DEBIAN_FRONTEND=noninteractive

ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics
    
# Dependencies
RUN apt-get -y update &&\
    apt-get -y upgrade &&\
    apt-get install -y apt-utils build-essential cmake curl libgtest-dev libeigen3-dev libboost-all-dev qtbase5-dev libglew-dev qt5-default git libyaml-cpp-dev libopencv-dev vim

RUN apt-get -y install software-properties-common &&\
    add-apt-repository ppa:borglab/gtsam-release-4.0 &&\
    apt-get -y update &&\
    apt-get install -y libgtsam-dev libgtsam-unstable-dev

# ROS melodic        
RUN apt-get install -y lsb-release &&\
    sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' &&\
    curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - &&\
    apt-get update -y &&\
    apt install -y ros-melodic-desktop-full
RUN apt-get install -y python3-catkin-pkg python3-wstool python3-rosdep ninja-build stow python3-rosinstall python3-rosinstall-generator
RUN rosdep init && rosdep update
    
RUN python3 -m pip install --upgrade pip
RUN pip install catkin_tools catkin_tools_fetch empy trollius numpy rosinstall_generator

# RangeNetLib & Suma++
RUN mkdir -p /catkin_ws/src
WORKDIR /catkin_ws/src
RUN git clone https://github.com/ros/catkin.git &&\
    git clone https://github.com/PRBonn/rangenet_lib.git
RUN sed -i 's/builder->setFp16Mode(true)/builder->setFp16Mode(false)/g' /catkin_ws/src/rangenet_lib/src/netTensorRT.cpp
RUN cd ../ && catkin init &&\
    catkin build rangenet_lib
RUN git clone https://github.com/PRBonn/semantic_suma.git &&\
    sed -i 's/find_package(Boost REQUIRED COMPONENTS filesystem system)/find_package(Boost 1.65.1 REQUIRED COMPONENTS filesystem system serialization thread date_time regex timer chrono)/g' /catkin_ws/src/semantic_suma/CMakeLists.txt &&\
    catkin init &&\
    catkin deps fetch &&\
    cd glow && git checkout e66d7f855514baed8dca0d1b82d7a51151c9eef3 && cd ../ &&\
    catkin build --save-config -i --cmake-args -DCMAKE_BUILD_TYPE=Release -DOPENGL_VERSION=430 -DENABLE_NVIDIA_EXT=YES
    
# Download model
WORKDIR /catkin_ws/src/semantic_suma
RUN wget https://www.ipb.uni-bonn.de/html/projects/semantic_suma/darknet53.tar.gz &&\
    tar -xvf darknet53.tar.gz
    
WORKDIR /catkin_ws/src
```

# 八. Docker访问X11服务器

主机上显示图形界面，如rviz/rviz2的图形界面。

1. 编辑 ~/.xprofile 文件：

```bash
vim ~/.xprofile
```

如果该文件不存在，系统会自动创建一个新的。

2. 在文件中添加以下内容：

```bash
xhost +local:docker # 允许本地 Docker 容器访问 X11 服务器
```

保存退出使更改生效。重新登录用户账户，xhost +local:docker 命令将在登录时自动执行。

# 九. Docker资源空间管理

```bash
docker system df # 显示docker占用的磁盘空间

docker system prune # 清理停止的容器、未使用的网络、悬空的镜像和构建缓存

docker system prune -a # 清理所有未使用的镜像和容器

```

