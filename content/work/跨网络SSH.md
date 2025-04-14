+++
authors = ["李佳潞"]
title = "跨网ssh"
date = "2025-04-09"
categories = [
    "软件"
]
series = [""]
tags = [
    "通讯"
]
+++
- [0. 说明](#0-说明)
- [1. 安装](#1-安装)
  - [1.1 openssh](#11-openssh)
  - [1.2 tailscale](#12-tailscale)
  - [1.3 termius](#13-termius)
- [2. 配置](#2-配置)
  - [2.1 openssh \& tailscale](#21-openssh--tailscale)
  - [2.2 termius](#22-termius)
- [3. 参考](#3-参考)

# 0. 说明
- openssh：在 Ubuntu 上开启 SSH 服务，让别人可以远程连接
- Tailscale：创建一个虚拟局域网，让不同网络下的设备“像在同一局域网中一样”通信
- tetermius：SSH 客户端，让你在一台电脑上通过 SSH 登录另一台电脑

---

# 1. 安装

## 1.1 openssh

- 安装 openssh
```bash
sudo apt update
sudo apt install openssh-server
```
- 启动服务
```bash
sudo systemctl enable ssh #可选开机启动
sudo systemctl start ssh #打开
```
- 查看服务状态
```bash
sudo systemctl status ssh #查询
```
- 关闭服务
```bash
sudo systemctl stop ssh #关闭
```

---

## 1.2 tailscale

- 安装 tailscale
```bash
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up
# 会打开网页让你登录（用 GitHub、Google 登录都行）
```
- 查看分配的 Tailscale IP 地址：
```bash
tailscale ip -4
```
- 查看联网状态
```bash
tailscale status
```
- 退出虚拟局域网
```bash
tailscale down
```

## 1.3 termius

[termius下载](https://termius.com/download/linux
)

# 2. 配置
## 2.1 openssh & tailscale
两台电脑都打开ssh。两台电脑都打开tailscale 并登录到虚拟局域网
## 2.2 termius

- 密码登录

| 字段     | 内容说明                                       |
|----------|------------------------------------------------|
| **Label**    | 自定义名称，如 `Ubuntu @ Tailscale`           |
| **Address**  | 填入你的 Tailscale IP，比如：`100.96.31.25`   |
| **Port**     | `22`（默认 SSH 端口）                        |
| **Username** | `xxx`（你在 Ubuntu 上的用户名）         |
| **Password** | 你的 Ubuntu 登录密码，或使用 SSH 私钥         |

- 密钥登录(麻烦点)
(1). 打开左侧的 **Keys** 面板
(2). 点击 **Generate Key**（或导入已有私钥）
(3). 把生成的公钥复制出来（以 `ssh-rsa` 或 `ssh-ed25519` 开头）




# 3. 参考

[termius用法](https://www.bilibili.com/video/BV15b4y1G7CY/?spm_id_from=333.337.search-card.all.click&vd_source=34566f6bf61eef87a4c23e5b6880d7a6)

