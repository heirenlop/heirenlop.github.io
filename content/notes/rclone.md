+++
authors = ["李佳潞"]
title = "rclone"
date = "2026-04-12"
categories = [
    "同步工具"
]
series = [""]
tags = [
    "Cloudflare",
    "R2",
    "rclone"
]

+++

最近折腾博客视频上传，被 Cloudflare R2 的 Dashboard 手动上传速度搞得有点难受。后来换成 `rclone` 直传，又快又稳，而且适合传大文件和批量同步。

这篇文章把 **Cloudflare R2 + rclone** 的配置过程完整记下来。

## 第一步：安装 rclone

Linux 上最省事的方式，是直接安装 `rclone`。

```bash
sudo -v ; curl https://rclone.org/install.sh | sudo bash
rclone version
```

我这边装完后的版本是：

```bash
rclone v1.73.4
```

## 第二步：创建 Cloudflare R2 Token

这里是整个配置里最容易搞混的一步。

在 Cloudflare R2 后台里创建 token 时，你最终真正要记下来的，不是“令牌名称”，而是下面这两项：

* **访问密钥 ID**（Access Key ID）
* **机密访问密钥**（Secret Access Key）

这两个值才是后面 `rclone` 配置时真正要填的内容。Cloudflare 官方的 R2 S3 文档里明确说明，S3-compatible API 访问需要的就是这对凭证，再加上单独的 endpoint。

## 第三步：运行 rclone config

直接执行：

```bash
rclone config
```

几个关键输入是：

```text
access_key_id>
```

这里填 **访问密钥 ID**

```text
secret_access_key>
```

这里填 **机密访问密钥**

```text
region>
```

这里一般直接回车即可，Cloudflare R2 的 region 这一步是可选的。官方文档里也是按 optional 处理。

```text
endpoint>
```

这里填：

```bash
https://你的ACCOUNT_ID.r2.cloudflarestorage.com
```

## 第四步：先别急着用 `rclone lsd r2:`

测试:直接访问你明确有权限的 bucket：

```bash
rclone lsd r2:blog-photos
rclone lsd r2:blog-videos
```


## 第五步：正式上传视频

真正上传时，我现在最推荐的命令是：

```bash
rclone copy -P /本地视频路径/tianjin2.mp4 r2:blog-videos/
```

这里的 `-P` 很重要，它会显示进度。

不加 `-P` 的时候，`rclone copy` 在大文件上传时经常长时间没输出，看起来像卡住了，实际上可能正在正常上传。

我第一次就是这样，命令一敲下去终端安静了半天，还以为坏了。结果没多久文件已经传完了，速度比 Dashboard 手动上传爽太多。

上传完成后，可以检查：

```bash
rclone ls r2:blog-videos
```

或者只看文件名：

```bash
rclone lsf r2:blog-videos
```

## tips：后面最常用的几个命令

上传单个文件：

```bash
rclone copy -P /本地/文件.mp4 r2:blog-videos/
```

上传到子目录：

```bash
rclone copy -P /本地/文件.png r2:blog-photos/daily-record/
```

上传整个目录：

```bash
rclone copy -P /本地/视频目录 r2:blog-videos/
```

查看远端文件：

```bash
rclone ls r2:blog-videos
```

只看文件名：

```bash
rclone lsf r2:blog-videos
```

查看配置文件位置：

```bash
rclone config file
```


