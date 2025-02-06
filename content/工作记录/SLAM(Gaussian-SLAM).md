---
title: "SLAM(Gaussian-SLAM)"
date: 2025-01-19
draft: false
---

# *代码部分*

# 一. 程序

# 二. 问题

1. 构建
   通过docker内的conda构建，构建过程中，无法clone三个子模块
```bash
   git+https://github.com/eriksandstroem/evaluate_3d_reconstruction_lib.git@9b3cc08be5440db9c375cc21e3bd65bb4a337db7
   git+https://github.com/VladimirYugay/simple-knn.git@c7e51a06a4cd84c25e769fee29ab391fe5d5ff8d
   git+https://github.com/VladimirYugay/gaussian_rasterizer.git@9c40173fcc8d9b16778a1a8040295bc2f9ebf129
```
   解决方法：由于 Git 2.16+ 默认使用 HTTP/2，而报错 curl 16 Error in the HTTP2 framing layer 是因为 HTTP/2 连接问题。可以强制 Git 退回到 HTTP/1.1：
```bash
   git config --global http.version HTTP/1.1
```   
# 三. 说明

# 四. 本地复现


# *论文部分*

# 一. 前置内容

1. RGBD图像
   概念：
   RGBD 图像提供了每个像素的 颜色信息 和 深度信息，这使得每个像素不仅能反映物体的颜色，还能指示物体在三维空间中的位置。通过将 深度图 中的每个像素与其对应的 颜色图像 数据结合，系统能够获得每个图像像素的三维空间坐标，通过特征提取（如SIFT、SURF等）生成 稀疏点云。每个点代表了场景中一个特定的三维位置。换句话说,束调整的目标是通过 联合优化，同时调整相机的 位姿 和 三维点的坐标，来减少图像间的误差，使得相机的轨迹和三维场景的重建都更加准确。
2. 视觉BA
   概念：
   通过最小化误差函数，使得多个图像帧之间的 相机参数 和 三维场景点位置 更加精确。
   作用：
   (1)相机位姿优化：调整每个相机的 位置 和 朝向，以最小化它们之间的 重投影误差。重投影误差是指通过相机内外参数（相机的 位置 和 旋转角度）计算出的 三维点投影位置 和实际图像中匹配到的特征点之间的差异。
   (2)三维点云优化：除了相机位姿，束调整还会优化 三维点云的坐标，即优化这些三维点在空间中的位置，使得在不同视角下的图像重建更加准确。
# 二. 论文逻辑

