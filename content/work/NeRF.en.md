+++
authors = ["Li Jialu"]
title = "Neural Radiance Fields"
date = "2025-01-20"
categories = [
    "Computer Vision"
]
series = [""]
tags = [
   "NeRF", "CUDA", "Deep Learning"
]
+++

- [*Experiment Test for PyTorch Version*](#experiment-test-for-pytorch-version)
- [*Code Section*](#code-section)
  - [1. Program](#1-program)
  - [2. Description](#2-description)
  - [3. Issues](#3-issues)
  - [4. Local Reproduction](#4-local-reproduction)
- [*Paper Section*](#paper-section)
  - [1. Official Website](#1-official-website)
  - [2. Paper Logic](#2-paper-logic)

# *Experiment Test for PyTorch Version*

# *Code Section*

## 1. Program

[Source Code](https://github.com/yenchenlin/nerf-pytorch)

## 2. Description

1. **nerf_synthetic Folder**

   - **Concept**: A synthetic dataset rendered using Blender software. To train NeRF, 3D models are created, virtual camera angles are set, and images are rendered from multiple perspectives.
   - **Purpose**: Used for training and validation.
   
   Folder contents:
   - The `test` folder contains test datasets: depth maps, pseudo-rgb, and rgb images.
   - The `train` folder contains training datasets.
   - The `val` folder contains validation datasets.
   - `*.json` files contain camera pose information.

2. **nerf_llff_data Folder**

   - **Concept**: A real-world scene dataset, obtained using the LLFF (Light Field Photography) method. This data comes from real cameras capturing scenes. LLFF collects light field information through images captured from various camera angles, each image having corresponding camera parameters.
   - **Purpose**: Used for validation and testing.
   
   Folder contents:
   - The `images` folder contains images of real-world scenes.
   - The `sparse` folder contains sparse point cloud data of the real-world scenes.
   - `pose_bounds.npy` contains camera pose information.
   - `simplices.npy` contains information about the simplicial complex of the scene.

## 3. Issues

None.

## 4. Local Reproduction

1. **lego_synthetic Dataset**  
   PSNR = 32 | Iterations = 150,000 | LOSS = 0.0012  
   <div class="container">
                <video controls>
                    <source src="/videos/work-record/blender_paper_lego_spiral_200000_rgb.mp4" type="video/mp4">
                </video>
            </div>

2. **fern_llff Dataset**  
   PSNR = 29 | Iterations = 200,000 | LOSS = 0.0032  
   <div class="container">
                <video controls>
                    <source src="/videos/work-record/fern_test_spiral_200000_rgb.mp4" type="video/mp4">
                </video>
            </div>

# *Paper Section*

## 1. Official Website

[NeRF Official Website](https://www.matthewtancik.com/nerf)

## 2. Paper Logic

+------------------------------+       +---------------------+       +-------------------------+       +----------------------+
| Input Images (Multiple Views)|  ---> | Neural Network Module (MLP) |  ---> | Volume Rendering (Volume Ray |  ---> | Generate New View Image  |
| Camera Pose Information      |       | Input: Position (x, y, z)    |       | Marching)               |       | Output: New View Image   |
|                              |       | and View Direction (θ, φ)    |       | Output: Color (c) and Volume Density |       |                      |
+----------------------------+ | Output: Color (c) and   |       | (σ)                       |       +----------------------+
                               | Volume Density (σ)      |       +-------------------------+
                               +---------------------+
                                        |
                                        V
                             +-----------------------------+
                             | Neural Network Training (Optimizing Network Parameters) |
                             | Input: Images, Camera Poses, Initial Network           |
                             | Output: Optimal Network Parameters                      |
                             +-----------------------------+
