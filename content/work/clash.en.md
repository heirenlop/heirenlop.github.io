+++
authors = ["Li Jialu"]
title = "Clash for Linux"
date = "2025-02-06"
categories = [
    "Software"
]
series = [""]
tags = [
    "clash"
]
+++

- [1. Source Code](#1-source-code)
- [2. Usage](#2-usage)
- [3. Proxy Verification in Terminal](#3-proxy-verification-in-terminal)


## 1. Source Code
[Source Code](https://github.com/zhaoweih/Clash-Copy)

## 2. Usage
- Navigate to the project directory

```bash
$ cd clash-for-linux
```

- Run the startup script

```bash
$ sudo bash start.sh

Checking subscription URL...
Clash subscription URL is accessible!                          [  OK  ]

Downloading Clash configuration file...
Configuration file config.yaml downloaded successfully!         [  OK  ]

Starting Clash service...
Service started successfully!                                   [  OK  ]

Clash Dashboard URL: http://<ip>:9090/ui
Secret: xxxxxxxxxxxxx
```
- Load environment variables
```bash  
source /etc/profile.d/clash.sh
```

- Enable system proxy
```bash
proxy_on
```

- To temporarily disable the system proxy
```bash
proxy_off
```

- For details, refer to the "start" section in the readme. This Clash setup will configure the proxy in the terminal. When proxy_on is activated in the terminal, only that terminal uses the proxy, not the system-wide proxy.
   
## 3. Proxy Verification in Terminal
```bash
Method 1. env | grep -E 'http_proxy|https_proxy|ALL_PROXY' # If the following is returned, the proxy is working

http_proxy=http://127.0.0.1:7890
https_proxy=http://127.0.0.1:7890

Method 2. wget -qO- ipinfo.io # If the returned IP is the proxy server's IP, rather than your local IP, it means wget is using the proxy.
```


