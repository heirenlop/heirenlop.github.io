+++
authors = ["Li Jialu"]
title = "Proxy"
url = "/work/en/proxy/"
date = "2025-02-11"
categories = [
    "Software"
]
series = [""]
tags = [
   "v2rayn"
]
+++

- [1. Ubuntu Proxy](#1-ubuntu-proxy)
- [2. Windows Proxy](#2-windows-proxy)

# 1. Ubuntu Proxy

1. **v2rayn**

    Open v2rayn, set up the proxy, and get the proxy port.
    ```bash
    [socks:: 10808] | [http:: 10809] # Local ports
    127.0.0.1 # Remote port
    ```

2. **UI Proxy (excluding terminal)**  
    This is not very useful and can be left off, but if you need to enable it, follow these steps:  
    Go to Settings -> Network -> Proxy -> Manual -> Set proxy port.
    
    <section>
        <div class="container">
            <div class="image">
                <figure>
                    <img src="https://cdn.heirenlop.com/work-record/proxy.png",alt="proxy",loading="lazy">
                    <figcaption>Ubuntu Proxy Setup</figcaption>
                </figure>
            </div>
        </div>
    </section>

3. **Host Machine Terminal + Conda + Pip + Git + Apt Proxy Settings**  
   You can remove the unnecessary parts of the script if you don't need them for certain tools.  
   <a href="https://heirenlop.github.io/%E5%B7%A5%E4%BD%9C%E8%AE%B0%E5%BD%95/shell/#sections4">Click here for the script🔗</a>

4. **Docker Development Container Inherits Proxy**  
   This step only inherits the host machine’s proxy settings to ensure the proxy works inside the container. Environment variables for tools like Conda still need to be set (see step 5).

   a. Modify the `devcontainer.json` file:

    ```json
    {
      // (1) Inherit environment variables from the host machine. If the host has ALL_PROXY set, the container will use the proxy. If the host doesn't have ALL_PROXY, the container won't use a proxy. This is the typical setup.
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
    // (2) Directly set the proxy
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

   b. Host machine terminal setup:
    ```bash
    export ALL_PROXY="socks5://127.0.0.1:10808" # Set proxy
    export HTTP_PROXY="http://127.0.0.1:10809"
    export HTTPS_PROXY="http://127.0.0.1:10809"
    code . # Open VSCode
    ```
   c. Restart the container:

    ```bash
    Ctrl + Shift + P -> Select "Remote-Containers: Rebuild and Reopen in Container"

    echo $HTTP_PROXY # Verify proxy settings
    echo $HTTPS_PROXY
    echo $ALL_PROXY 
    curl -I https://www.google.com # Check proxy status
    ```

5. **Set Proxy for Conda/Pip/Git/Apt Inside Docker Container**  
   You can remove any parts of the script that are unnecessary for your setup.  
   <a href="https://heirenlop.github.io/%E5%B7%A5%E4%BD%9C%E8%AE%B0%E5%BD%95/shell/#sections4">Click here for the script🔗</a>

# 2. Windows Proxy

todo
