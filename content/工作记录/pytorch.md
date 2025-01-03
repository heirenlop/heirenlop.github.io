---
title: "Pytorch"
date: 2025-01-03
draft: false
---

# 一. 测试容器搭建

```bash
docker run -it --gpus all --name pytorch -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix pytorch/pytorch #构建容器

apt-get update #更新

apt-get install -y vim #安装vim

pip install matplotlib #安装matplotlib

pip install wandb #安装wandb

apt-get install -y x11-apps #安装x11
```

# 二. 开发容器搭建

devcontainer.yaml如下：
```yaml
{
    "name": "PyTorch Container",
    "image": "pytorch/pytorch",  // 使用 pytorch/pytorch 镜像
    "runArgs": [
      "--gpus", "all",  // 使用 GPU
      "-e", "DISPLAY=$DISPLAY",  // 传递显示设置
      "-v", "/tmp/.X11-unix:/tmp/.X11-unix"  // 映射 X11 socket，支持 GUI
    ],
    "workspaceFolder": "/workspace",  // 容器内的工作目录
    "mounts": [
      "source=/home/heirenlop/workspace/DEV-pytorch,target=/workspace,type=bind"  // 本地路径挂载到容器内
    ],
    "customizations": {
      "vscode": {
        "extensions": [
          "ms-python.python"  // 安装 Python 扩展
        ]
      }
    },
    "postCreateCommand": "apt-get update && apt-get install -y vim x11-apps && pip install matplotlib wandb"  // 容器创建后执行的命令
  }
```