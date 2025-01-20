---
title: "NeRF"
date: 2025-01-20
draft: false
---

# *实验测试为pytorch版本*

# *代码部分*

# 一. 程序

源码：<https://github.com/yenchenlin/nerf-pytorch>

# 二. 说明

1. nerf_synthetic文件
   
概念：用blender软件渲染的合成数据集，为了训练 NeRF，创建的 3D 模型、设置虚拟相机视角并渲染多个视角下的图像。

目的：用于训练和验证。

文件夹内容：
test内包含了测试数据集，深度图/伪rgb/rgb
train内包含了训练数据集
val 内包含验证数据集
*.json文件包含了相机的位姿信息
   
2. nerf_llff_data
   
概念：真实场景数据集，这个数据集来自于 LLFF (Light Field Photography) 方法，通过真实相机拍摄得到的场景数据。LLFF 是通过多个不同视角相机拍摄的图像来获取场景的光场信息，每张图像有对应的心相机参数。

目的：用于验证和测试。

文件夹内容：
images 内包含了真实场景的图像
sparse 内包含了真实场景的稀疏点云数据
pose_bounds.npy 文件包含了相机的位姿信息
simplices.npy 文件包含了场景的简单面信息

# 三. 问题

无

# 四. 测试


# *论文部分*


# 一. 

   
