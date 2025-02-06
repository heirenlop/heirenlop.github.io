---
title: "Clash for Linux"
date: 2025-02-06
draft: false
---

# 说明

1. 源码：<https://github.com/zhaoweih/Clash-Copy>

2. 用法：
- 进入项目目录

```bash
$ cd clash-for-linux
```

- 运行启动脚本

```bash
$ sudo bash start.sh

正在检测订阅地址...
Clash订阅地址可访问！                                      [  OK  ]

正在下载Clash配置文件...
配置文件config.yaml下载成功！                              [  OK  ]

正在启动Clash服务...
服务启动成功！                                             [  OK  ]

Clash Dashboard 访问地址：http://<ip>:9090/ui
Secret：xxxxxxxxxxxxx
```
- 加载环境变量
```bash  
source /etc/profile.d/clash.sh
```

- 开启系统代理:
```bash
proxy_on
```

- 若要临时关闭系统代理
```bash
proxy_off
```

- 详情见readme中启动程序部分，该clash会在终端设置代理，终端内打开proxy_on，则该终端走代理，并不是系统级代理。
   
3. 终端内代理验证：
```bash
方法1. env | grep -E 'http_proxy|https_proxy|ALL_PROXY' # 如果返回如下所示，则代理生效

http_proxy=http://127.0.0.1:7890
https_proxy=http://127.0.0.1:7890

方法2. wget -qO- ipinfo.io #如果返回的 IP 是代理服务器的 IP，而不是你的本地 IP，说明 wget 走了代理。
```


