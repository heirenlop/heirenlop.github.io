+++
authors = ["李佳潞"]
title = "proxy"
date = "2025-02-11"
categories = [
    "软件"
]
series = [""]
tags = [
   "v2rayn"
]
+++

- [一. ubuntu代理](#一-ubuntu代理)
- [二. windows代理](#二-windows代理)

# 一. ubuntu代理

1. v2rayn

    打开v2rayn，设置代理，获得代理端口。
    ```bash
    [socks:: 10808]|[http:: 10809] #为本地端口
    127.0.0.1 #为远程端口
    ```

2. UI代理(不包括终端)
  这个没太大用，可以不开，如果要开的话，方法如下：
  设置->网络->代理->手动->设置代理端口
  <div class="container">
      <div class="image">
          <figure>
            <a data-fancybox="gallery" href="/images/work-record/proxy.png" >
              <img src="/images/work-record/proxy.png" loading="lazy">
          </a>
              <figcaption>ubuntu设置代理</figcaption>
          </figure>
      </div>
  </div>
1. 宿主机设置终端+conda+pip+git+apt代理
   按需要可删除脚本中不需要代理的部分
<a href="https://heirenlop.github.io/%E5%B7%A5%E4%BD%9C%E8%AE%B0%E5%BD%95/shell/#sections4">点击跳转到脚本🔗</a>


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
    curl -I https://www.google.com # 验证代理设置

    ```

5. docker容器内conda/pip/git /apt设置代理

   按需要可删除脚本中不需要代理的部分
<a href="https://heirenlop.github.io/%E5%B7%A5%E4%BD%9C%E8%AE%B0%E5%BD%95/shell/#sections4">点击跳转到脚本🔗</a>


# 二. windows代理

todo