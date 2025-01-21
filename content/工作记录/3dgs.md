---
title: "3dgs"
date: 2025-01-20
draft: false
---

# *代码部分*

# 一. 程序


# 二. 说明

# 三. 问题

无

# 四. 本地复现




# *论文部分*

# 一. 前置内容

1. **结构光束法(Structure-from-Motion sfm)**
    概念：
    通过从多个视角拍摄的图片中推断出3D结构的技术。通过该方法，能从一组2D图像中提取出3D场景的几何信息，生成稀疏点云。
    过程：
    (1) 输入图像：SFM方法通常依赖于至少两张或更多的相机视角，从中提取出图像特征点。
    (2) 特征匹配：从这些图像中提取特征点，并通过图像匹配技术（例如，SIFT、SURF等）来找到这些特征在不同图像中的对应关系。
        (SIFT和SURF是两种常见的特征提取算法，它们都基于图像的纹理信息，可以提取出图像中的关键点，并通过匹配算法来确定关键点的对应关系。)
    (3) 计算相机位置和方向：SFM方法还可以估计相机的运动轨迹（即相机的位置和朝向），这些信息有助于推算出特征点在三维空间中的位置。
    (4) 三维重建：通过三角测量等几何方法，将图像中匹配的特征点转换成三维空间中的点，生成稀疏点云。

2. **稀疏点云**
    特性：
    (1) 稀疏：由于SFM方法通常依赖于图像中可识别的特征（如角点或边缘），而这些特征点并不能覆盖整个场景。因此，稀疏点云的点数相对较少，且分布在场景中较为分散。
    (2) 不完整：这些点仅代表场景中的特定部分，如重要的角点或边界，无法完全描述整个场景的几何形状，通常需要通过其他技术（如传统MVS / 流行的3dgs）来填补空缺并生成稠密点云。

3. **colmap**
    概念：
    开源的三维重建软件，结合了**结构光束法（SfM）和多视图立体（MVS）**技术，提供图形和命令行界面。 它能够从有序或无序的图像集合中，自动提取特征、匹配特征点、估计相机位姿，并生成稀疏和稠密的三维点云。 COLMAP广泛应用于计算机视觉、三维建模、增强现实等领域。

4. **快速光栅化 (Fast Rasterization)**
    概念：
    渲染技术一种。将三维场景中的几何图形（如线条、多边形）转换为二维像素网格，以便在显示设备上呈现图像。 是图形渲染中的一个步骤。快速光栅化（Fast Rasterization）是通过优化算法加速将3D模型转换为2D图像的像素的过程。

5. **体积渲染 (Volumetric Rendering)**
    概念：
    渲染技术一种。它不仅考虑场景的表面，还关注场景中的体积数据。通过模拟光在不同介质（如烟雾、云朵、雾霾等）中的传播，体积渲染能够生成更加真实和细致的视觉效果。通常用于优化 3D 数据，尤其是在 半透明物体 或 复杂光传播 场景的渲染中。然而，在 3D Gaussian Splatting (3DGS) 中，体积渲染的应用更侧重于优化 2D 图像。

6. **blender**
    概念：
    开源的三维渲染软件。一旦三维点云数据导入到 Blender 中，就可以对这些点云进行可视化和渲染。在 Blender 中，可以使用包括 **体积渲染 (Volumetric Rendering)和快速光栅化 (Fast Rasterization)** 等技术来优化渲染效果。


# 一. 官网


# 二. 论文逻辑

| **Step**                                | **Description**                                                                                       | **Technology Used**                       |
|-----------------------------------------|-------------------------------------------------------------------------------------------------------|------------------------------------------|
| **1. Input Images / 输入图像**          | Collect a set of 2D images from different viewpoints. / 从不同视角获取一组2D图像。                       |                                          |
| **2. Feature Point Extraction / 特征点提取** | Apply feature extraction algorithms like SIFT (Scale-Invariant Feature Transform). / 使用SIFT等特征提取算法。 | **SIFT**, **SURF**, **ORB**              |
| **3. Sparse Point Cloud Generation / 稀疏点云生成** | Use Structure-from-Motion (SfM) or similar techniques to generate a sparse point cloud and estimate camera poses. / 使用SfM或类似技术生成稀疏点云并估计相机位姿。 | **Structure-from-Motion (SfM)**          |
| **4. Gaussian Point Cloud Representation / 高斯点云表示** | Convert the sparse point cloud into 3D Gaussian point cloud, where each point represents a Gaussian distribution with position, opacity, and color information. / 将稀疏点云转换为3D高斯点云，每个点表示一个包含位置、透明度和颜色信息的高斯分布。 | **3D Gaussian Splatting**               |
| **5. Optimization / 优化**             | Optimize the Gaussian points by adjusting their positions, opacities, and colors based on new images. / 根据新图像数据调整高斯点的位置、透明度和颜色等属性进行优化。 | **Bundle Adjustment**, **Optimization Algorithms** |
| **6. Rendering / 渲染**                | Render the Gaussian point cloud into a 2D image using fast rasterization techniques. / 使用快速光栅化技术将高斯点云渲染为2D图像。 | **Fast Rasterization**, **Volumetric Rendering** |
| **7. Output / 输出**                   | Output the optimized 2D image and the optimized Gaussian point cloud for further applications, such as rendering or localization. / 输出优化后的2D图像和优化后的高斯点云，供后续应用，如渲染或定位。 |                                          |

