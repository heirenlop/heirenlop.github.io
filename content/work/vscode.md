+++
authors = ["李佳潞"]
title = "Vscode"
date = "2024-10-24"
categories = [
    "软件"
]
series = [""]
tags = [
   "vscode","IDE"
]
+++
- [1 设置相关](#1-设置相关)
  - [1.1 vscode同步多电脑](#11-vscode同步多电脑)
  - [1.2 Auto save](#12-auto-save)
- [2 插件相关](#2-插件相关)
  - [2.1 ssh](#21-ssh)
  - [2.2 Git(Windiows)](#22-gitwindiows)
  - [2.3 Git(Linux)](#23-gitlinux)
  - [2.4 配置Git忽略submodule更改](#24-配置git忽略submodule更改)
  - [2.5 dev container](#25-dev-container)
- [3 快捷键](#3-快捷键)
- [4 无法输入中文问题](#4-无法输入中文问题)
- [5. 调试](#5-调试)

# 1 设置相关

## 1.1 vscode同步多电脑

    (1) 页面左下角设置同步打开

    (2) 选择需要同步的内容

    (3) 登录github

    (4) 同步

## 1.2 Auto save

    <div class="container">
                    <div class="image">
                        <figure>
                            <img src="/images/work-record/vscode1.png",alt="设置1",loading="lazy">
                            <figcaption>步骤1</figcaption>
                        </figure>
                    </div>
    </div>
    <div class="container">
                    <div class="image">
                        <figure>
                            <img src="/images/work-record/vscode2.png",alt="设置2",loading="lazy">
                            <figcaption>步骤2</figcaption>
                        </figure>
                    </div>
    </div>

# 2 插件相关 

## 2.1 ssh

(1) ssh到ubuntu，以及ubuntu需要的设置
[参考链接](https://blog.csdn.net/zsyyugong/article/details/134438071)

## 2.2 Git(Windiows)

[参考链接](https://blog.csdn.net/czjl6886/article/details/122129576)

## 2.3 Git(Linux)

- 安装git

    ```bash
    sudo apt update
    sudo apt install git
    ```

- 验证

    ```bash
    git --version
    ```

- 配置github账户

    ```bash
    git config --global user.name "Your Name"
    git config --global user.email "youremail@example.com"
    ```

- 生成SSH密钥，如果有密钥直接复制过来就行，没有的话如下生成

    ```bash
    ssh-keygen -t rsa -b 4096 -C "youremail@example.com"
    ```

- 查看密钥内容

    ```bash
    cat ~/.ssh/id_rsa.pub
    ```

- github网页设置密钥
    登录到 GitHub，然后进入 Settings > SSH and GPG keys 页面，点击 New SSH key。
    粘贴复制的公钥，并为它取个名字，然后保存。
    (7) 测试SSH链接

    ```bash
    ssh -T git@github.com
    ```

- 如果成功，会显示类似于 Hi username! You've successfully authenticated, but GitHub does not provide shell access. 的消息。

## 2.4 配置Git忽略submodule更改

- 打开设置：ctrl + ,
- 搜索git ignore submodules
- 勾选git ignore submodules

## 2.5 dev container
    构建dev容器流程
    (1) 程序内新建.devcontainer/devcontainer.json;
    (2) ctrl+shift+p，选择dev container: open folder in container构建dev容器（如果有dockerfile直接根据dockerfile生成）;
    (3) 配置完成后，点击rebuild container，构建开发容器;

# 3 快捷键

- 显示右侧边栏

   ```bash
   ctrl+alt+b
   ```

- 显示左侧边栏

   ```bash
   ctrl+b
   ```

- 显示底部边栏

   ```bash
   ctrl+j
   ```
# 4 无法输入中文问题

- 卸载 Snap 版本的 VS Code
    ```bash
    sudo snap remove code
    ```
- 添加微软的 GPG 密钥和软件源
    ```bash
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg

    sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/

    sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

    rm -f packages.microsoft.gpg
    ```

- 更新apt缓存并安装
    ```bash
    sudo apt-get update
    sudo apt-get install code
    ```


# 5. 调试
- 继续 (Continue)
   直到程序结束或下一个断点。
- 逐过程 (Step Over)
   执行当前行并跳过函数调用。
- 单步调试 (Step Into)
   执行当前行并进入函数内部进行逐步调试。
- 单步跳出 (Step Out) 
   已经进入一个函数并且想跳出这个函数，回到调用该函数的地方继续调试的操作。
- 调试控制台
   好用的一批

 