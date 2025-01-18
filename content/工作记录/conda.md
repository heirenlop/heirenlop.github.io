---
title: "conda"
date: 2025-01-18
draft: false
---
# 一. 环境管理

1. 创建虚拟环境
    ```bash
    conda create -n <env_name> python=<version> # -n 创建虚拟环境名称，python=指定python版本
    ```
2. 删除虚拟环境
   ```bash
   conda remove -n <env_name> --all # -n 删除虚拟环境名称
   ```
3. 激活/切换虚拟环境
   ```bash
   conda activate <env_name> # 激活虚拟环境名称
   ```
4. 退出当前虚拟环境
   ```bash
   conda deactivate
   ```
5. 列出所有虚拟环境
   ```bash
   conda env list
   ```
6. 查看当前虚拟环境信息
   ```bash
   conda info
   ```
# 二. 环境配置
1. 导出虚拟环境配置文件.yaml
   ```bash
   conda env export > environment.yaml
   ```
2. 使用.yaml文件创建虚拟环境
   ```bash
   conda env create -f environment.yaml
   ```
3. 使用.yaml文件更新虚拟环境
   ```bash
   conda env update -f environment.yaml
   ```
# 三. 包管理
1. 安装包
   ```bash
   conda install package_name # conda install numpy
   conda install package_name=version # conda install numpy=1.16.0
   ```
2. 升级包
   ```
   conda update package_name # conda update numpy
   ```
    