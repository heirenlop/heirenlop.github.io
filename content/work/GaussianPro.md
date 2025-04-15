+++
authors = ["李佳潞"]
title = "GaussianPro"
date = "2025-04-15"
categories = [
    "三维重建"
]
series = [""]
tags = [
   "机器学习"
]
+++

- [1. 程序](#1-程序)
- [2. 问题](#2-问题)
- [3. 测试](#3-测试)

---

# 1. 程序

源码：<https://github.com/kcheng1021/GaussianPro>

---

# 2. 问题

train过程显存溢出
```bash
RuntimeError: CUDA out of memory. Tried to allocate 80.00 MiB (GPU 0; 7.75 GiB total capacity; 4.57 GiB already allocated; 65.31 MiB free; 4.76 GiB reserved in total by PyTorch) If reserved memory is >> allocated memory try setting max_split_size_mb to avoid fragmentation.  See documentation for Memory Management and PYTORCH_CUDA_ALLOC_CONF
```

---

# 3. 测试
