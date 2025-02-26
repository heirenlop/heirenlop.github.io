+++
authors = ["李佳潞"]
title = "LIO-SAM"
date = "2024-12-12"
categories = [
    "SLAM"
]
series = [""]
tags = [
   "激光雷达","融合","惯导","ros2"
]
+++

- [一. 程序](#一-程序)
- [二. 流程](#二-流程)
- [三. 问题](#三-问题)
- [四. 测试](#四-测试)

# 一. 程序

[源码](https://github.com/TixiaoShan/LIO-SAM/tree/master?tab=readme-ov-file#sample-datasets>)

分支：ros2

# 二. 流程

1. 官方bag为velody雷达，修改ros2分支中/config/params.yaml中sensor settings
    ```yaml
    # Sensor Settings
        sensor: velodyne                               # lidar sensor type, either 'velodyne', 'ouster' or 'livox'
        N_SCAN: 16                                   # number of lidar channels (i.e., Velodyne/Ouster: 16, 32, 64, 128, Livox Horizon: 6)
        Horizon_SCAN: 1800                            # lidar horizontal resolution (Velodyne:1800, Ouster:512,1024,2048, Livox Horizon: 4000)
        downsampleRate: 1                            # default: 1. Downsample your data if too many
    ```

2. 官方bag分多种，目前我只下载了campus和park,根据运行的bag不同，，修改ros2分支中/config/params.yaml中topics和IMU Settings

    (1) park_dataset

    ```yaml
    #Topics
    pointCloudTopic: "/points_raw"                   # Point cloud data
    imuTopic: "imu_raw"                # IMU data
    #IMU Settings
    extrinsicRot:    [-1.0,  0.0,  0.0,
                        0.0,  1.0,  0.0,
                            0.0,  0.0, -1.0 ]
    extrinsicRPY: [ 0.0,  1.0,  0.0,
                        -1.0,  0.0,  0.0,
                        0.0,  0.0,  1.0 ]
    ```

    (2) campus_dataset

    ```yaml
    #Topics
    pointCloudTopic: "/points_raw"                   # Point cloud data
    imuTopic: "/imu_correct"                        # IMU data
    #IMU Settings
    extrinsicRot:    [1.0,  0.0,  0.0,
                        0.0,  1.0,  0.0,
                        0.0,  0.0, 1.0 ]
    extrinsicRPY: [ 1.0,  0.0,  0.0,
                    0.0,  1.0,  0.0,
                        0.0,  0.0,  1.0 ]
    ```

# 三. 问题

官方只有ros1的bag，测试ros2需要自己转换，测试了如下两仓的转换效果

1. rosbags

    安装并测试：
    ```bash
    apt-get update
    apt-get install python3-pip
    pip install rosbags
    rosbags-convert --src <path_to_rosbag1_filename> --dst <path_to_ros2bag_filename> #转换bag
    ```
    结果：rosbags转bag后，imu频率从500hz降到250hz，不可用。

2. ros1_bridge

    安装并测试：写了一个docker镜像，[地址](https://github.com/heirenlop/ros1_bridge_docker>)

    结果：无降频问题，可用。

# 四. 测试

可复现