+++
authors = ["李佳潞"]
title = "Tailscale + RustDesk"
date = "2025-08-13"
categories = ["软件工具"]
tags = ["Tailscale", "RustDesk", "远程桌面", "内网穿透"]
description = "使用 Tailscale 与 RustDesk，在不同网络环境下实现稳定的远程桌面控制，支持 Linux 系统跨公网访问。"
url = "/work/Tailscale-RustDesk/"
+++



## 1. 工具介绍

### Tailscale
- 基于 WireGuard 的零配置 VPN。
- 为设备分配 `100.x.x.x` 段的虚拟内网 IP。
- 无需公网 IP 和端口映射，即可实现跨公网互通。

### RustDesk
- 开源免费。
- 跨平台远程桌面软件，支持文件传输。
- 可以自托管中继/直连，也可直接走 Tailscale 内网通道。

---

## 2. 环境说明

- 主控端：Ubuntu 20.04 笔记本
- 被控端：Ubuntu 20.04 台式机
- 两台设备处于不同网络
- 目标：主控端可远程看到并操作被控端完整桌面

---

## 3. 配置

### 3.1 安装并登录 Tailscale
```bash
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up
tailscale ip -4 # 获取虚拟内网 IP
```
- 登录同一 Tailscale 账号。
- 记下分配的虚拟内网 IP（如 `100.96.31.25`）。
- 可在 tailscale 官网登录帐号，会显示两台设备以及虚拟内网 IP
- 可从主控端ssh到被控端做测试
```bash
ssh 用户名@虚拟内网 IP 
```

### 3.2 安装 RustDesk

- [RustDesk链接](https://rustdesk.com/zh-cn/)
- 如果官网的deb无法安装，尝试使用snap安装：
```bash
sudo apt update
sudo apt install -y snapd
sudo snap install rustdesk

```


## 4. 测试连接

1. 主控端 RustDesk → 输入被控端的 Tailscale IP。
2. 输入访问密码。
3. 成功后即可看到被控端桌面并进行操作。


## 5. 总结

Tailscale + RustDesk 的组合，为远程桌面加了一层内网穿透能力，配置无脑。  


