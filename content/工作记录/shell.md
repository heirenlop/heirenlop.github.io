---
title: "Shell"
date: 2025-01-23
draft: false
---
**常用脚本**

# 一. download
以下载cuda12.2toolkit为例
```shell
#!/bin/bash

# 下载地址
URL="https://developer.download.nvidia.cn/compute/cuda/12.2.2/local_installers/cuda_12.2.2_535.104.05_linux.run"
# 文件名
FILENAME=$(basename "$URL")

# 无限重试下载
while true; do
    echo "Starting download (or resuming if interrupted): $FILENAME"
    
    # 使用 wget -c 启用断点续传
    wget -c "$URL"
    
    # 检查是否下载成功
    if [ $? -eq 0 ]; then
        echo "Download completed successfully: $FILENAME"
        break
    else
        echo "Download interrupted. Retrying in 5 seconds..."
        # sleep 5: 等待 5 秒后重试，避免频繁请求导致网络问题。
        sleep 5
    fi
done

```