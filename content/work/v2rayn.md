+++
authors = ["李佳潞"]
title = "v2rayn"
url = "/work/v2rayn/"
date = "2025-08-11"
categories = [
    "软件"
]
series = [""]
tags = [
   "v2rayn"
]
+++



## 1. ubuntu主机代理

- 打开v2rayn，设置代理，获得代理端口。
```bash
[socks:: 10808]|[http:: 10809] #为本地端口
```
- 确认v2rayn代理的主机IP
```bash
ip addr show #不会的话直接复制到gpt，让gpt给出具体哪个是局域网的IP
#      inet 127.0.0.1/8 scope host lo
```
- 主机代理git + pip + conda 脚本：setup_proxy.sh
- 用法
```bash
./setup_proxy.sh 127.0.0.1 10809 http
# or
./setup_proxy.sh 127.0.0.1 10808 socks5
```

- 冒烟测试脚本：proxy_smoke_test.sh
- 取消代理git + pip + conda 脚本：unset_proxy.sh

## 2. Docker内代理 
- v2rayn 设置
设置->参数设置->打开允许来自局域网的链接 / 打开为局域网开启新的端口

- 确认v2rayn代理的局域网端口
```bash
[socks:: 10810]|[http:: 10811] #局域网端口
```
- 确认v2rayn代理的局域网IP
```bash
ip addr show #不会的话直接复制到gpt，让gpt给出具体哪个是局域网的IP
#  inet 192.168.0.242/24 brd 192.168.0.255 scope global dynamic noprefixroute enxb8d4bcb89062
```
- docker内代理git + pip + conda 脚本：setup_proxy.sh
- 用法
```bash
./setup_proxy.sh 192.168.0.242 10811 http
# or
./setup_proxy.sh 192.168.0.242 10810 socks5
```
- 冒烟测试脚本：proxy_smoke_test.sh

- docker内取消代理git + pip + conda 脚本：unset_proxy.sh
---
### 3. 脚本下载
<a href="/file/unset_proxy.sh" download style="padding: 8px 16px; background: #007BFF; color: white; border-radius: 5px; text-decoration: none;">📎 setup_proxy.sh</a>
<a href="/file/setup_proxy.sh" download style="padding: 8px 16px; background: #007BFF; color: white; border-radius: 5px; text-decoration: none;">📎 proxy_smoke_test</a>
<a href="/file/proxy_smoke_test.sh" download style="padding: 8px 16px; background: #007BFF; color: white; border-radius: 5px; text-decoration: none;">📎 unset_proxy.sh</a>