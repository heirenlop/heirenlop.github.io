+++
authors = ["Li Jialu"]
title = "3D Gaussian Splatting"
date = "2025-01-20"
categories = [
    "Computer Vision"
]
series = [""]
tags = [
     "Machine Learning"
]
+++

- [_Code Section_](#code-section)
  - [1. Program](#1-program)
  - [2. Issues](#2-issues)
  - [3. Notes](#3-notes)
  - [4. Local Reproduction](#4-local-reproduction)
- [_Paper Section_](#paper-section)
  - [1. Preliminaries](#1-preliminaries)
  - [2. Paper Logic](#2-paper-logic)

# _Code Section_

## 1. Program

[GitHub Source](https://github.com/graphdeco-inria/gaussian-splatting)

## 2. Issues

Conda installation process:

1. Downloading the CUDA version of PyTorch results in the CPU version.
   
    [Reference Link](https://blog.csdn.net/u013468614/article/details/125910538)

2. Undefined symbol: iJIT_NotifyEvent
    Cause: Likely due to incompatibility between Docker container and conda environment.
    Error: libtorch_cpu.so: undefined symbol: iJIT_NotifyEvent, Solution: Try running `pip install mkl==2024.0`

## 3. Notes

[Official Link](https://www.youtube.com/watch?v=UXtuigy_wYc)

[Reference Link](https://blog.csdn.net/Mekjeri/article/details/135716907?utm_source=chatgpt.com)

## 4. Local Reproduction

1. Create your own dataset:

   Requirements: colmap and ffmpeg

2. Conda run:

   If Conda lacks libgl (due to running in Docker container), install libgl:

   ```bash
   conda install -c conda-forge libgl


3. Visualize with SIBR_viewers

   ```bash
    # Dependencies
    sudo apt install -y libglew-dev libassimp-dev libboost-all-dev libgtk-3-dev libopencv-dev libglfw3-dev libavdevice-dev libavcodec-dev libeigen3-dev libxxf86vm-dev libembree-dev

    # Project setup
    cd SIBR_viewers
    git checkout fossa_compatibility # Only needed for Ubuntu 22.04
    cmake -Bbuild . -DCMAKE_BUILD_TYPE=Release # Add -G Ninja to build faster
    cmake --build build -j24 --target install

    # Run
    ./install/bin/SIBR_gaussianViewer_app -m ../output/water_bottle/
    ```

   For visualization inside Conda, there may be an x11 error:

   ```bash
   [SIBR] ##  ERROR  ##:   FILE /workspace/gaussian-splatting/SIBR_viewers/src/core/graphics/Window.cpp
                           LINE 30, FUNC glfwErrorCallback
                           GLX: Failed to create context: GLXBadFBConfig
   ```

   Solution: 
   a. On host machine

   ```bash
   glxinfo| grep OpenGL #Check OpenGL core profile version string' = 4.6
   ```

   b. Inside Docker container:

   ```bash
   export MESA_GL_VERSION_OVERRIDE=4.6
   ```

   c. Run again inside Docker:

   ```bash
   ./install/bin/SIBR_gaussianViewer_app -m ../output/water_bottle/
   ```

   [Reference Link](https://github.com/graphdeco-inria/gaussian-splatting/issues/267#issuecomment-1840760152)

4. Local Data Test

   Original data video captured on phone:

   <div class="container" style="display: flex; justify-content: center;">
       <video controls style="max-width:100%; height:auto;">
           <source src="https://cdn-v.heirenlop.com/ori_water_bottle.mp4" type="video/mp4">
           Your browser does not support HTML5 video playback.
       </video>
   </div>

   SIBR：

   <div class="container" style="display: flex; justify-content: center;">
  <video controls style="max-width:100%; height:auto;">
           <source src="https://cdn-v.heirenlop.com/SIBR_water_bottle.mp4" type="video/mp4">
           Your browser does not support HTML5 video playback.
       </video>
   </div>

   Gaussian distribution visualization:
<!-- 放在页面任意位置都可以（支持 PC + 手机滑动） -->
<div class="twenty-container">
  <img class="twenty-before" 
       src="https://cdn.heirenlop.com/work-record/ori_water_bottle.png" 
       alt="Original Image">
  <img class="twenty-after" 
       src="https://cdn.heirenlop.com/work-record/sbir_water_bottle.png" 
       alt="SBIR Image">
  <div class="twenty-handle"></div>
</div>

<style>
  .twenty-container {
    position: relative;
    width: 80%;
    max-width: 500px;
    height: 700px;
    overflow: hidden;
    border-radius: 10px;
    margin: 0 auto;
    touch-action: none; /* ✅ 阻止移动端页面跟随滑动 */
  }

  .twenty-before,
  .twenty-after {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
  }

  .twenty-handle {
    position: absolute;
    top: 0;
    left: 50%;
    width: 20px;
    height: 100%;
    background-color: rgba(255, 255, 255, 0.7);
    cursor: ew-resize;
    z-index: 10;
    border-radius: 50%;
  }
</style>

<script>
  const handle = document.querySelector('.twenty-handle');
  const beforeImg = document.querySelector('.twenty-before');
  const afterImg = document.querySelector('.twenty-after');
  const container = handle.parentElement;

  let handlePosition = handle.offsetLeft;

  function updateClipPosition() {
    beforeImg.style.clip = `rect(0px, ${handlePosition}px, 700px, 0px)`;
    afterImg.style.clip = `rect(0px, 500px, 700px, ${handlePosition}px)`;
  }

  updateClipPosition();

  // PC 鼠标事件
  handle.addEventListener('mousedown', (e) => {
    const startX = e.clientX;
    const initialLeft = handlePosition;

    const onMouseMove = (moveEvent) => {
      const diffX = moveEvent.clientX - startX;
      let newLeft = initialLeft + diffX;
      newLeft = Math.max(0, Math.min(newLeft, container.offsetWidth));
      handlePosition = newLeft;
      handle.style.left = `${handlePosition}px`;
      updateClipPosition();
    };

    const onMouseUp = () => {
      document.removeEventListener('mousemove', onMouseMove);
      document.removeEventListener('mouseup', onMouseUp);
    };

    document.addEventListener('mousemove', onMouseMove);
    document.addEventListener('mouseup', onMouseUp);
  });

  // ✅ 手机触摸事件
  handle.addEventListener('touchstart', (e) => {
    const startX = e.touches[0].clientX;
    const initialLeft = handlePosition;

    const onTouchMove = (moveEvent) => {
      moveEvent.preventDefault(); // ✅ 阻止页面跟着滑
      const diffX = moveEvent.touches[0].clientX - startX;
      let newLeft = initialLeft + diffX;
      newLeft = Math.max(0, Math.min(newLeft, container.offsetWidth));
      handlePosition = newLeft;
      handle.style.left = `${handlePosition}px`;
      updateClipPosition();
    };

    const onTouchEnd = () => {
      document.removeEventListener('touchmove', onTouchMove);
      document.removeEventListener('touchend', onTouchEnd);
    };

    document.addEventListener('touchmove', onTouchMove, { passive: false });
    document.addEventListener('touchend', onTouchEnd);
  });
</script>

# _Paper Section_

## 1. Preliminaries

1. **Sparse/ Semi-Dense/ Dense SLAM**
    Sparse SLAM: Traditional visual SLAM, such as vins-mono, tracks feature points in images to estimate the camera's trajectory. It only provides limited information and cannot fully describe the scene.
    Semi-Dense SLAM: LiDAR-based SLAM, like LIO-SAM, scans the environment, generating more map data but still not fully describing the scene.
    Dense SLAM: Generates a mesh, point cloud, or Gaussian splatting (3DGS), providing a detailed global structure. This can assist downstream systems in recognizing obstacles, pedestrians, and objects for better path planning and decision-making in autonomous driving.

2. **Structure-from-Motion sfm**
    Concept: The technique of inferring 3D structure from images taken from multiple perspectives. Using this method, geometric information of a 3D scene can be extracted from a set of 2D images, generating a sparse point cloud.

    Process:
    (1) Input Images: The SFM (Structure from Motion) method typically relies on at least two or more camera views from which image feature points are extracted.
    (2) Feature Matching: Features are extracted from these images, and image matching techniques (such as SIFT, SURF, etc.) are used to find correspondences of these features across different images.
    (SIFT and SURF are common feature extraction algorithms, both based on image texture information. They can extract key points from an image, and matching algorithms are used to determine the correspondences between these key points.)
    (3) Camera Position and Orientation Calculation: The SFM method can also estimate the camera's motion trajectory (i.e., the position and orientation of the camera), which helps to determine the position of feature points in 3D space.
    (4) 3D Reconstruction: Using geometric methods like triangulation, the matching feature points from the images are converted into points in 3D space, generating a sparse point cloud.

3. **Sparse Point Cloud**
    Characteristics:
    (1) Sparsity: Since the SFM method typically relies on identifiable features in the image (such as corners or edges), these feature points do not cover the entire scene. As a result, the number of points in a sparse point cloud is relatively small and scattered throughout the scene.
    (2) Incompleteness: These points only represent specific parts of the scene, such as important corner points or boundaries. They cannot fully describe the geometric shape of the entire scene. To fill in the gaps and generate a dense point cloud, additional techniques (such as traditional MVS or the popular 3DGS) are typically needed.

4. **colmap**
    Concept:
     COLMAP is an open-source 3D reconstruction software that combines Structure from Motion (SfM) and Multi-View Stereo (MVS) technologies, offering both graphical and command-line interfaces. It can automatically extract features, match feature points, estimate camera poses, and generate both sparse and dense 3D point clouds from ordered or unordered image sets. COLMAP is widely used in fields such as computer vision, 3D modeling, and augmented reality.

5. **Fast Rasterization**
    Concept:
     A rendering technique that converts the geometric shapes in a 3D scene (such as lines and polygons) into a 2D pixel grid for display on a screen. It is a step in the graphics rendering process. Fast Rasterization accelerates the process of converting 3D models into 2D image pixels through optimization algorithms.

6. **Volumetric Rendering**
    Concept: 
    A rendering technique that not only considers the surface of the scene but also focuses on the volumetric data within it. By simulating the propagation of light through different mediums (such as smoke, clouds, fog, etc.), volume rendering creates more realistic and detailed visual effects. It is commonly used to optimize 3D data, particularly in rendering translucent objects or scenes with complex light propagation. However, in 3D Gaussian Splatting (3DGS), the application of volume rendering is more focused on optimizing 2D images.

7. **blender**
    Concept: 
    An open-source 3D rendering software. Once the 3D point cloud data is imported into Blender, it can be visualized and rendered. In Blender, techniques such as Volumetric Rendering and Fast Rasterization can be used to optimize the rendering effects.

## 2. Paper Logic

| **Step**                                                  | **Description**                                                                                                                                                                                                                                      | **Technology Used**                                |
| --------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------- |
| **1. Input Images**                            | Collect a set of 2D images from different viewpoints.                                                                                                                                                                |                                                    |
| **2. Feature Point Extraction**              | Apply feature extraction algorithms like SIFT (Scale-Invariant Feature Transform).                                                                                                                                     | **SIFT**, **SURF**, **ORB**                        |
| **3. Sparse Point Cloud Generation**       | Use Structure-from-Motion (SfM) or similar techniques to generate a sparse point cloud and estimate camera poses.                                                                               | **Structure-from-Motion (SfM)**                    |
| **4. Gaussian Point Cloud Representation** | Convert the sparse point cloud into 3D Gaussian point cloud, where each point represents a Gaussian distribution with position, opacity, and color information.  | **3D Gaussian Splatting**                          |
| **5. Optimization**                                | Optimize the Gaussian points by adjusting their positions, opacities, and colors based on new images.                                                                      | **Bundle Adjustment**, **Optimization Algorithms** |
| **6. Rendering**                                   | Render the Gaussian point cloud into a 2D image using fast rasterization techniques.                                                                                                                   | **Fast Rasterization**, **Volumetric Rendering**   |
| **7. Output**                                      | Output the optimized 2D image and the optimized Gaussian point cloud for further applications, such as rendering or localization.                                               |                                                    |
