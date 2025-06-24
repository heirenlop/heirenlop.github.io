+++
authors = ["李佳潞"]
title = "Neural Radiance Fields"
date = "2025-01-20"
categories = [
    "三维重建"
]
series = [""]
tags = [
   "深度学习", "机器学习"
]
+++

- [*实验测试为pytorch版本*](#实验测试为pytorch版本)
- [*代码部分*](#代码部分)
- [一. 程序](#一-程序)
- [二. 说明](#二-说明)
- [三. 问题](#三-问题)
- [四. 本地复现](#四-本地复现)
- [*论文部分*](#论文部分)
- [一. 官网](#一-官网)
- [二. 论文逻辑](#二-论文逻辑)

# *实验测试为pytorch版本*

# *代码部分*

# 一. 程序

[源码](https://github.com/yenchenlin/nerf-pytorch)

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

# 四. 本地复现

1. lego_synthetic数据集
   PSNR=32 | Iter=150000 | LOSS= 0.0012
   <div class="container" style="display: flex; justify-content: center;">
     <video controls style="max-width:100%; height:auto;">
       <source src="https://pub-5b6dc435fbf3499ca474b4b6941cb647.r2.dev/blender_paper_lego_spiral_200000_rgb.mp4" type="video/mp4">
       您的浏览器不支持 HTML5 视频播放。
     </video>
   </div>

2. fern_llff数据集
    PSNR=29 | Iter=200000 | LOSS= 0.0032
   <div class="container" style="display: flex; justify-content: center;">
     <video controls style="max-width:100%; height:auto;">
       <source src="https://pub-5b6dc435fbf3499ca474b4b6941cb647.r2.dev/fern_test_spiral_200000_rgb.mp4" type="video/mp4">
       您的浏览器不支持 HTML5 视频播放。
     </video>
   </div>

# *论文部分*


# 一. 官网

https://www.matthewtancik.com/nerf

# 二. 论文逻辑

<div class="container">
    <div class="image">
        <figure>
            <img src="https://cdn.heirenlop.com/work-record/nerf_logic.png" alt="" loading="lazy">
            <figcaption>Nerf逻辑图</figcaption>
        </figure>
    </div>
</div>


   
