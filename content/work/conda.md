+++
authors = ["李佳潞"]
title = "Conda"
url = "/work/conda/"
date = "2025-01-18"
categories = [
    "开发工具"
]
series = [""]
tags = [
    "虚拟环境"
]
+++
- [一. 安装](#一-安装)
- [二. 环境管理](#二-环境管理)
- [三. 环境配置](#三-环境配置)
- [四. 包管理](#四-包管理)
- [五. 换源](#五-换源)
# 一. 安装
```bash
# 下载 Miniconda 安装脚本
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
# or
curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

# 运行安装脚本
bash Miniconda3-latest-Linux-x86_64.sh

# 激活 Conda 环境
source ~/.bashrc

# 测试
conda --version
```

# 二. 环境管理

1. 创建虚拟环境
    ```bash
    conda create -n <env_name> python=<version> # -n 创建虚拟环境名称，python=指定python版本
    conda env create -f environment.yml # 根据environment.yml文件创建虚拟环境
    ```
2. 删除虚拟环境
   ```bash
   conda env remove -n <env_name>
   ```
3. 激活/切换虚拟环境
   ```bash
   conda activate <env_name> # 激活虚拟环境名称
   或者
   source activate <env_name> 
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
7. 根据 environment.yml 文件更新环境
   ```bash
   conda env update -f environment.yml
   ```

8. 显示镜像源列表
   ```bash
   conda config --show channels
   ```
   
# 三. 环境配置

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
   
# 四. 包管理

1. 安装包
   ```bash
   conda install package_name # conda install numpy
   conda install package_name=version # conda install numpy=1.16.0
   ```
2. 升级包
   ```
   conda update package_name # conda update numpy
   ```

# 五. 换源
```bash
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/
conda config --set show_channel_urls yes # 显示源

conda clean -i # 清理索引缓存
```
    