+++
authors = ["Li Jialu"]
title = "LIO-SAM"
url = "/work/en/lio-sam/"
date = "2024-12-12"
categories = [
    "SLAM"
]
series = [""]
tags = [
   "LiDAR", "IMU", "ROS2"
]
+++

- [1. Program](#1-program)
- [2. Workflow](#2-workflow)
- [3. Issues](#3-issues)
- [4. Testing](#4-testing)

# 1. Program

[Source Code](https://github.com/TixiaoShan/LIO-SAM/tree/master?tab=readme-ov-file#sample-datasets)

Branch: ros2

# 2. Workflow

1. The official bag file uses Velodyne LiDAR. Modify the `sensor settings` in the `/config/params.yaml` file in the ros2 branch.

    ```yaml
    # Sensor Settings
        sensor: velodyne                               # lidar sensor type, can be 'velodyne', 'ouster', or 'livox'
        N_SCAN: 16                                   # number of lidar channels (e.g., Velodyne/Ouster: 16, 32, 64, 128, Livox Horizon: 6)
        Horizon_SCAN: 1800                            # lidar horizontal resolution (Velodyne: 1800, Ouster: 512, 1024, 2048, Livox Horizon: 4000)
        downsampleRate: 1                            # default: 1. Downsample your data if it’s too large
    ```

2. The official bag files come in different formats. I’ve downloaded the `campus` and `park` datasets. Depending on which bag file you are running, modify the `topics` and `IMU Settings` in the `/config/params.yaml` file in the ros2 branch.

    (1) **park_dataset**

    ```yaml
    # Topics
    pointCloudTopic: "/points_raw"                   # Point cloud data
    imuTopic: "imu_raw"                              # IMU data
    # IMU Settings
    extrinsicRot:    [-1.0,  0.0,  0.0,
                        0.0,  1.0,  0.0,
                        0.0,  0.0, -1.0 ]
    extrinsicRPY: [ 0.0,  1.0,  0.0,
                        -1.0,  0.0,  0.0,
                        0.0,  0.0,  1.0 ]
    ```

    (2) **campus_dataset**

    ```yaml
    # Topics
    pointCloudTopic: "/points_raw"                   # Point cloud data
    imuTopic: "/imu_correct"                         # IMU data
    # IMU Settings
    extrinsicRot:    [1.0,  0.0,  0.0,
                        0.0,  1.0,  0.0,
                        0.0,  0.0, 1.0 ]
    extrinsicRPY: [ 1.0,  0.0,  0.0,
                    0.0,  1.0,  0.0,
                    0.0,  0.0,  1.0 ]
    ```

# 3. Issues

The official bag files are only available for ROS1, and testing on ROS2 requires converting the bags. The following two methods were tested for conversion:

1. **rosbags**

    Install and test:
    ```bash
    apt-get update
    apt-get install python3-pip
    pip install rosbags
    rosbags-convert --src <path_to_rosbag1_filename> --dst <path_to_ros2bag_filename>  # Convert the bag file
    ```

    Result: After converting with rosbags, the IMU frequency dropped from 500Hz to 250Hz, making it unusable.

2. **ros1_bridge**

    Install and test: I created a Docker image, [link](https://github.com/heirenlop/ros1_bridge_docker)

    Result: No frequency drop, works fine.

# 4. Testing

The process is reproducible.
