+++
authors = ["李佳潞"]
title = "syncthing"
url = "/work/syncthing/"
date = "2025-10-31"
categories = [
    "syncthing"
]
series = [""]
tags = [
]
+++

- [1. 开机自动启动，两台都设置](#1-开机自动启动两台都设置)
- [2. 手动启动，两台都设置](#2-手动启动两台都设置)
- [3. 网址](#3-网址)

## 1. 开机自动启动，两台都设置
```bash
# 1) Tailscale 自启（tailscaled 是 root 的 systemd 服务）
sudo systemctl enable --now tailscaled
# 首次/换网络需登录一次（之后会记住）
sudo tailscale up --ssh

# 2) Syncthing 自启（选其一）
# 若用“用户服务”（有桌面会话的常见做法）
loginctl enable-linger $USER
systemctl --user enable --now syncthing

# 若用“系统实例”（更稳，不依赖用户会话；二选一）
sudo systemctl enable --now syncthing@$USER

```

验证

```bash

# 看 Tailscale 是否在线
tailscale status   # 看到对端 100.x 在线即可
tailscale ping <对端100.x>    # 应该 pong

# 看 Syncthing 是否在跑、GUI 端口
journalctl --user -u syncthing -n 10 --no-pager 2>/dev/null \
 || sudo journalctl -u syncthing@$USER -n 10 --no-pager
# 打开浏览器 http://127.0.0.1:8384 看到界面即可

```

## 2. 手动启动，两台都设置

```bash
# 1) 让 Tailscale 在线
sudo systemctl start tailscaled
sudo tailscale up --ssh    # 若已登录过，基本瞬间就在线

# 2) 让 Syncthing 跑起来
systemctl --user start syncthing 2>/dev/null || sudo systemctl start syncthing@$USER

```
验证
```bash
tailscale ping <对端100.x>
# TCP 22000 联通性（可选）
nc -vz <对端100.x> 22000

```

## 3. 网址
```bash
127.0.0.1:8384
```