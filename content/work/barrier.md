+++
authors = ["李佳潞"]
title = "Barrier"
date = "2024-12-02"
categories = [
    "软件"
]
series = [""]
tags = [
    ""
]
+++

- [用法](#用法)
- [问题](#问题)
  - [Windows防火墙设置](#windows防火墙设置)
  - [Windows端口设置](#windows端口设置)

# 用法
[参考1](https://blog.csdn.net/guojingyue123/article/details/135066151)

[参考2](https://juejin.cn/post/7163950376079753252)

# 问题

## Windows防火墙设置

1. 打开 Windows 防火墙设置
按 Win + R 打开运行窗口，输入 control 并按下 Enter，进入 控制面板。
在控制面板中选择 系统和安全（System and Security），然后选择 Windows Defender 防火墙。

2. 允许应用通过防火墙
在 Windows Defender 防火墙窗口，左侧点击 允许应用通过 Windows 防火墙（Allow an app or feature through Windows Defender Firewall）。
在弹出的窗口中，点击右下角的 更改设置（Change settings），并找到 Barrier 或 Barrier Server（如果已经列出）。确保选中“专用”和“公用”网络旁边的复选框，以便允许该程序的通信。

## Windows端口设置

如果没有找到 Barrier 或需要手动配置端口，可以通过以下步骤打开 24800 端口：

1. 返回到 Windows Defender 防火墙 设置界面。
2. 在左侧栏点击 高级设置（Advanced settings），这将打开 Windows 防火墙 高级安全性。
3. 在左侧选择 入站规则（Inbound Rules）。
4. 选择 端口（Port），查看端口号。
