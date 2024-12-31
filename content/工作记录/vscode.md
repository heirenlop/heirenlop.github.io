---
title: "Vscode"
date: 2024-10-24
draft: false
---
# 一：设置相关

1. vscode同步多电脑

(1) 页面左下角设置同步打开

(2) 选择需要同步的内容

(3) 登录github

(4) 同步

# 二：插件相关 #

1. ssh

(1) ssh到ubuntu，以及ubuntu需要的设置
<https://blog.csdn.net/zsyyugong/article/details/134438071>

2. Git->Windiows

<https://blog.csdn.net/czjl6886/article/details/122129576>

3. Git->Linux

(1) 安装git

```bash
sudo apt update
sudo apt install git
```

(2) 验证

```bash
git --version
```

(3) 配置github账户

```bash
git config --global user.name "Your Name"
git config --global user.email "youremail@example.com"
```

(4) 生成SSH密钥，如果有密钥直接复制过来就行，没有的话如下生成

```bash
ssh-keygen -t rsa -b 4096 -C "youremail@example.com"
```

(5) 查看密钥内容

```bash
cat ~/.ssh/id_rsa.pub
```

(6) github网页设置密钥
登录到 GitHub，然后进入 Settings > SSH and GPG keys 页面，点击 New SSH key。
粘贴复制的公钥，并为它取个名字，然后保存。
(7) 测试SSH链接

```bash
ssh -T git@github.com
```

如果成功，会显示类似于 Hi username! You've successfully authenticated, but GitHub does not provide shell access. 的消息。

4. Docker-> dev container
    (1) 作用

    在容器化环境中构建、配置和管理开发环境。

    (2) docker内构建按vscode环境流程
    a. ctrl+shift+p，选择dev container: open folder in container;
    b. 选择对应文件夹;
    c. 配置dev container，有dockerfile直接根据dockerfile，没有则根据vscode配置文件生成;
    以下为devconatainer.json文件例子

    ```yaml
      {
    "name": "SEMENTIC_SUMA",
    "build": {
        "context": "..",
        "dockerfile": "../Dockerfile"
    },
    "image": "semantic_suma:latest",
    "containerName": "semantic_suma_dev_container",
    "runArgs": [
        "--env", "DISPLAY=${env:DISPLAY}",
        "--env", "QT_X11_NO_MITSHM=1",
        "--env", "XAUTHORITY=${env:XAUTHORITY}",
        "--volume", "/tmp/.X11-unix:/tmp/.X11-unix:rw",
        "--volume", "/kitti:/data",
        "--gpus", "all"
        "--network=host",
        "--ipc=host",
        "--privileged"
    ],
    "workspaceMount": "source=${localWorkspaceFolder},target=/workspace,type=bind",
    "workspaceFolder": "/workspace",
    "mounts": [ "source=/home/heirenlop/workspace/Dataset/,target=/root/Dataset/,type=bind" ]}
    ```

    d. 配置完成后，点击rebuild container，构建开发容器;
    e. 构建完成，进入新开发容器的vscode界面。

    (3) 问题：
    a. 主机内新增某文件，vscode的界面内同步了，但vscode的终端内未同步，则Ctrl+Shift+P后rebuild容器。但是rebuild后之前容器内所有安装的软件都没了？

# 三：快捷键

1. 显示右侧边栏

   ```bash
   ctrl+alt+b
   ```

2. 显示左侧边栏

   ```bash
   ctrl+b
   ```

3. 显示底部边栏

   ```bash
   ctrl+j
   ```
# 四：无法输入中文问题

1. 卸载 Snap 版本的 VS Code
```bash
sudo snap remove code
```
2. 添加微软的 GPG 密钥和软件源
```bash
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg

sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/

sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

rm -f packages.microsoft.gpg
```

3. 更新apt缓存并安装
```bash
sudo apt-get update
sudo apt-get install code
```
