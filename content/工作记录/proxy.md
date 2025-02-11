---
title: "proxy"
date: 2025-02-11
draft: false
---

# 一. ubuntu代理

1. v2rayn

打开v2rayn，设置代理，获得代理端口。
```bash
[socks:: 10808]|[http:: 10809] #为本地端口
127.0.0.1 #为远程端口
```

2. UI代理(不包括终端)
设置->网络->代理->手动->设置代理端口
<section>
            <div class="container">
                <div class="image">
                    <figure>
                        <img src="/images/work-record/proxy.png",alt="proxy",loading="lazy">
                        <figcaption>ubuntu设置代理</figcaption>
                    </figure>
                </div>
            </div>
        </section>

1. 终端代理
```bash
curl https://www.google.com # 1. 测试代理是否生效，未设置时无输出
export ALL_PROXY="socks5://127.0.0.1:10808" # 2. 设置代理
curl https://www.google.com # 3. 测试代理是否生效，设置有输出
unset ALL_PROXY # 4.取消代理

curl --proxy 127.0.0.1:10809 https://www.google.com # 5. 也可直接用命令行设置代理并测试
```

4. docker开发容器继承代理
   这一步只是继承宿主机的代理，保证在容器内的代理生效，conda等环境变量还需要设置，见5。
a. 修改devcontainer.json

```json
{
//（1）继承宿主机的环境变量，如果宿主机有 ALL_PROXY，则容器也使用代理；如果宿主机没设置 ALL_PROXY，则容器不会使用代理。一般用这种方法就行。
  "name": "My DevContainer",
  "build": {
    "dockerfile": "Dockerfile"
  },
  "runArgs": [
    "--network=host"
  ],
  "remoteEnv": {
    "ALL_PROXY": "${localEnv:ALL_PROXY}",
    "HTTP_PROXY": "${localEnv:HTTP_PROXY}",
    "HTTPS_PROXY": "${localEnv:HTTPS_PROXY}"
  }
}
//（2）直接设置代理
{
  "name": "My DevContainer",
  "build": {
    "dockerfile": "Dockerfile"
  },
  "runArgs": [
    "--network=host"
  ],
  "remoteEnv": {
    "ALL_PROXY": "socks5://127.0.0.1:10808",
    "HTTP_PROXY": "http://127.0.0.1:10809",
    "HTTPS_PROXY": "http://127.0.0.1:10809"
  }
}
```

b. 宿主机终端

```bash
export ALL_PROXY="socks5://127.0.0.1:10808" # 设置代理
export HTTP_PROXY="http://127.0.0.1:10809"
export HTTPS_PROXY="http://127.0.0.1:10809"
code . #打开VSCode
```
c. 重启容器

```bash
Ctrl + Shift + P -> 选择 "Remote-Containers: Rebuild and Reopen in Container"

echo $HTTP_PROXY # 验证代理设置
echo $HTTPS_PROXY
echo $ALL_PROXY 
curl https://www.google.com # 验证代理设置

```

5. docker容器内conda/pip/git /apt设置代理
自动化脚本配置conda+pip+git+apt代理
```bash
#!/bin/bash

# 设置代理
PROXY="socks5://127.0.0.1:10808"
HTTP_PROXY="http://127.0.0.1:10809"
HTTPS_PROXY="http://127.0.0.1:10809"

# 配置 Conda 走代理
conda config --set proxy_servers.http $PROXY
conda config --set proxy_servers.https $PROXY

# 配置 Pip 走代理
pip config set global.proxy $PROXY

# 配置 Git 走代理
git config --global http.proxy $PROXY
git config --global https.proxy $PROXY

# 配置 APT 走代理
echo "Acquire::http::Proxy \"$HTTP_PROXY\";" | tee /etc/apt/apt.conf.d/proxy.conf
echo "Acquire::https::Proxy \"$HTTPS_PROXY\";" | tee -a /etc/apt/apt.conf.d/proxy.conf

# 验证代理是否成功
echo "Checking if proxies are set correctly..."

# 检查 Conda 配置
conda_config_check=$(conda config --show proxy_servers)
echo "Conda proxy config: $conda_config_check"

# 检查 Pip 配置
pip_config_check=$(pip config list | grep proxy)
echo "Pip proxy config: $pip_config_check"

# 检查 Git 配置
git_config_http=$(git config --global --get http.proxy)
git_config_https=$(git config --global --get https.proxy)
echo "Git proxy config HTTP: $git_config_http"
echo "Git proxy config HTTPS: $git_config_https"

# 检查 APT 配置
apt_config_check=$(cat /etc/apt/apt.conf.d/proxy.conf)
echo "APT proxy config: $apt_config_check"

# 测试代理是否有效（curl 测试）
curl_test=$(curl -I https://www.google.com 2>/dev/null | head -n 1)
echo "Curl test result: $curl_test"

# 判断是否成功
if [[ "$curl_test" =~ "200 Connection established" ]]; then
    echo "success"
else
    echo "Proxy setup failed!"
fi

```