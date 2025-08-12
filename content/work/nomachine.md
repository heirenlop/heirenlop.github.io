+++
authors = ["李佳潞"]
title = "nomachine"
url = "/work/nomachine/"
date = "2025-08-12"
categories = [
    "内网穿透"
]
series = [""]
tags = [
   "nomachine"
]
+++

## 1. 下载链接

- [nomachine](https://download.nomachine.com/download/?id=1&platform=linux)

## 2. 安装

```bash
README-NOMACHINE
----------------

Welcome to the NoMachine.

This file comes with the compressed TAR file installation package.

To install NoMachine please follow instructions below. Commands use
the sudo utility. If you don't have sudo installed, log on as the
superuser ("root") with:

$ su -

And insert the root password.

If you want to install NoMachine to the default /usr/NX location, do
the following from a terminal.

- Copy the tar.gz package to the /usr directory

  $ sudo cp -p nomachine_9.1.24_6_x86_64.tar.gz /usr

- Change directory to /usr and extract the archive.

  $ cd /usr
  $ sudo tar zxf nomachine_9.1.24_6_x86_64.tar.gz

- Run the setup script.

  $ sudo /usr/NX/nxserver --install

Alternatively, if you want to install NoMachine in a different location
to where you extracted the tar package, from this directory run the
setup by specifying where you want to install. For example, to install
to /usr run:

$ sudo NX_INSTALL_PREFIX=/usr  NX/nxserver --install

Enjoy!

The NoMachine Support Staff.
```

## 3. 配置脚本
- <a href="/file/nomachine.sh" download style="padding: 8px 16px; background: #007BFF; color: white; border-radius: 5px; text-decoration: none;">📎 下载脚本</a>

## 4. 脚本用法

- <a href="/file/readme.md" download style="padding: 8px 16px; background: #007BFF; color: white; border-radius: 5px; text-decoration: none;">📎 下载用法</a>