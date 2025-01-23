---
title: "Nvidia"
date: 2025-01-23
draft: false
---
# 一. cuda toolkit安装

    cuda toolkit内包含：驱动、cuda、cudnn、tensorrt等。安装了cuda toolkit后，无需单独安装驱动。

1. 下载安装cuda toolkit
    下载链接：https://developer.nvidia.com/cuda-toolkit-archive

2. 配置环境变量
    ```bash
    export PATH=/usr/local/cuda-12.2/bin:$PATH
    export LD_LIBRARY_PATH=/usr/local/cuda-12.2/lib64:$LD_LIBRARY_PATH
    ```

3. 测试
    ```bash
    nvcc --version # 显示cuda版本

    Thu Jan 23 19:03:24 2025       
    +---------------------------------------------------------------------------------------+
    | NVIDIA-SMI 535.183.01             Driver Version: 535.183.01   CUDA Version: 12.2     |
    |-----------------------------------------+----------------------+----------------------+
    | GPU  Name                 Persistence-M | Bus-Id        Disp.A | Volatile Uncorr. ECC |
    | Fan  Temp   Perf          Pwr:Usage/Cap |         Memory-Usage | GPU-Util  Compute M. |
    |                                         |                      |               MIG M. |
    |=========================================+======================+======================|
    |   0  NVIDIA GeForce RTX 4060 Ti     Off | 00000000:01:00.0  On |                  N/A |
    | 33%   27C    P8               5W / 160W |    476MiB /  8188MiB |      2%      Default |
    |                                         |                      |                  N/A |
    +-----------------------------------------+----------------------+----------------------+
                                                                                            
    +---------------------------------------------------------------------------------------+
    | Processes:                                                                            |
    |  GPU   GI   CI        PID   Type   Process name                            GPU Memory |
    |        ID   ID                                                             Usage      |
    |=======================================================================================|
    |    0   N/A  N/A      1307      G   /usr/lib/xorg/Xorg                           89MiB |
    |    0   N/A  N/A      2105      G   /usr/lib/xorg/Xorg                          205MiB |
    |    0   N/A  N/A      2260      G   /usr/bin/gnome-shell                         36MiB |
    |    0   N/A  N/A      8936      G   ...an,WebOTP --variations-seed-version       16MiB |
    |    0   N/A  N/A     21421      G   ...51,262144 --variations-seed-version       59MiB |
    |    0   N/A  N/A    336154      G   ...erProcess --variations-seed-version       47MiB |
    +---------------------------------------------------------------------------------------+
    ```

    ```bash
    nvidia-smi #显示驱动版本
    
    heirenlop@REN:~$ nvcc --version
    nvcc: NVIDIA (R) Cuda compiler driver
    Copyright (c) 2005-2023 NVIDIA Corporation
    Built on Tue_Aug_15_22:02:13_PDT_2023
    Cuda compilation tools, release 12.2, V12.2.140
    Build cuda_12.2.r12.2/compiler.33191640_0
    ```

# 二. 单独安装驱动
1. 查看系统中是否识别到 NVIDIA 显卡：

```bash
lspci | grep -i nvidia
```
2. 用 ubuntu-drivers 查看系统推荐的 NVIDIA 驱动版本：

```bash
ubuntu-drivers devices
```
3. 安装推荐驱动
让系统自动安装推荐的 NVIDIA 驱动：

```bash
sudo ubuntu-drivers autoinstall
```
如果需要手动安装特定版本的驱动：

```bash
sudo apt install nvidia-driver-535（本人系统推荐535）
```
4. 安装完成后，重启系统：

```bash
sudo reboot
```
5.检查 NVIDIA 驱动是否加载：

```bash
nvidia-smi
```

输出示例：
```diff
+---------------------------------------------------------------------------------------+
| NVIDIA-SMI 535.183.01             Driver Version: 535.183.01   CUDA Version: 12.2     |
|-----------------------------------------+----------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |         Memory-Usage | GPU-Util  Compute M. |
|                                         |                      |               MIG M. |
|=========================================+======================+======================|
|   0  NVIDIA GeForce RTX 4060 Ti     Off | 00000000:01:00.0  On |                  N/A |
| 33%   28C    P8               5W / 160W |    361MiB /  8188MiB |      9%      Default |
|                                         |                      |                  N/A |
+-----------------------------------------+----------------------+----------------------+
                                                                                         
+---------------------------------------------------------------------------------------+
| Processes:                                                                            |
|  GPU   GI   CI        PID   Type   Process name                            GPU Memory |
|        ID   ID                                                             Usage      |
|=======================================================================================|
|    0   N/A  N/A      1328      G   /usr/lib/xorg/Xorg                           53MiB |
|    0   N/A  N/A      2050      G   /usr/lib/xorg/Xorg                          147MiB |
|    0   N/A  N/A      2185      G   /usr/bin/gnome-shell                         89MiB |
|    0   N/A  N/A      3280      G   ...52,262144 --variations-seed-version       52MiB |
+---------------------------------------------------------------------------------------+
```
正常情况到此结束

6. 如果上述没有输出或显示错误
如：
```bash
NVIDIA-SMI has failed because it couldn't communicate with the NVIDIA driver. Make sure that the latest NVIDIA driver is installed and running.
```
7. 运行以下命令查看驱动是否正确安装：

```bash
dpkg -l | grep nvidia
```
确认是否有类似 nvidia-driver-535 的条目。

8. 检查 NVIDIA 模块是否加载：

```bash
lsmod | grep nvidia
```
8. 如果没有输出，可以尝试手动加载：

```bash
sudo modprobe nvidia
```
如果出现如下错误：modprobe: ERROR: could not insert 'nvidia': Operation not permitted
大概率是Secure Boot 启用问题

9. 运行以下命令检查 Secure Boot 是否启用：

```bash
mokutil --sb-state
```
如果显示 SecureBoot enabled，需要禁用它，因为 Secure Boot 会阻止未签名的驱动加载。


10. 禁用Secure Boot 方法
方法一：BIOS设置
（1）重启电脑，进入 BIOS/UEFI 设置界面。
（2）找到 Secure Boot 选项并将其设置为 Disabled。
（3）保存更改并退出 BIOS。

方法二：MOK设置
（1）运行以下命令禁用 Secure Boot 或注册密钥：

```bash
sudo mokutil --disable-validation
```
（2）设置密码
系统会提示你设置一个密码，用于稍后在 MOK 管理界面中确认操作。
（3） 重启
```bash
sudo reboot
```
（4）进入 MOK 管理界面： 
在重启后，系统会自动进入蓝色的 MOK 管理界面。界面选项包括：
Continue Boot：继续正常启动。
Enroll MOK：注册密钥（如你选择了导入密钥）。
Disable Secure Boot：禁用 Secure Boot（如果你运行了 mokutil --disable-validation）。
Change Password：更改密码。

11.检查 NVIDIA 驱动是否加载：

```bash
nvidia-smi
```


# 三. Nvidia-container-toolkit安装

帮助用户在容器环境(Docker)中构建和运行 GPU 加速的应用程序。它包含一个容器运行时库和相关实用程序，能够自动配置容器以利用 NVIDIA GPU，从而在容器化应用中实现高效的 GPU 加速。

1. 检查是否安装nvidia-container-toolkit：

```bash
dpkg -l | grep nvidia-container-toolkit
```

2. 安装
```bash
sudo apt-get install -y nvidia-container-toolkit
```

如果出现如下问题：
E: 无法定位软件包 nvidia-container-toolkit
请往下继续

3. 添加 NVIDIA GPG 密钥：

```bash
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
```

4. 添加 NVIDIA 容器工具包的仓库：
```bash
distribution=$(. /etc/os-release; echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list |
sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' |
sudo tee /etc/apt/sources.list.d/nvidia-docker.list
```

5. 更新软件包列表：
```bash
sudo apt-get update
```
6. 安装 nvidia-container-toolkit：
```bash
sudo apt-get install -y nvidia-container-toolkit
```
7. 重启 Docker 服务：
```bash
sudo systemctl restart docker
```

# 三. GPU功率设置

限制功率
```bash
nvidia-smi -i 0 -pl 100 #-i 0表示第0块gpu，-pl 150表示功耗限制在150W
```

恢复功率
```bash
nvidia-smi -i 0 -pl 160
```
