+++
authors = ["李佳潞"]
title = "ffmpeg"
url = "/work/ffmpeg/"
date = "2025-07-14"
categories = [
    "图像/视频处理"
]
series = [""]
tags = [
   ""
]
+++

## 1. 旋转视频 
- 逆时针旋转视频90度
```bash
ffmpeg -i input.mp4 -vf "transpose=2" -metadata:s:v rotate=0 -c:a copy output.mp4
```
- 顺时针旋转视频90度
```bash
ffmpeg -i input.mp4 -vf "transpose=1" -metadata:s:v rotate=0 -c:a copy output.mp4
```