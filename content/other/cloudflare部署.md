+++
authors = ["李佳潞"]
title = "cloudflare部署"
date = "2025-05-17"
categories = [
    "博客"
]
series = [""]
tags = [
    "cloudflare"
]
url = "/other/cloudflare/"

+++

## 1. 参考

[参考链接](https://akearer.top/post/how-to-setup-a-blog-with-hugo-and-cfpages/)

## 2. 当前博客配置思路

本地 Hugo 写
      ↓ GitHub 托管源代码
      ↓ Cloudflare Pages 自动构建 + 部署
      ↓ 自定义域名 heirenlop.com（自动 HTTPS）
      ↓ 视频, 图片等大文件通过 Cloudflare R2 存储分离
      ↓ 全站由 Cloudflare CDN 加速（包括中国大陆）

## 3. 配置规则
### 3.1 配置图片 / 视频缓存规则
配置TTL / 缓存级别提升访问速度
<div class="image">
            <figure>
                <a data-fancybox="gallery" href="https://cdn.heirenlop.com/other/cloudflare1.png">
<img src="https://cdn.heirenlop.com/other/cloudflare1.png" loading="lazy">
</a>
            </figure>
        </div>

### 3.2 配置重定向规则

把所有访问 www.heirenlop.com/* 都自动跳转到 https://heirenlop.com/* 。
<div class="image">
            <figure>
                <a data-fancybox="gallery" href="https://cdn.heirenlop.com/other/cloudflare2.png">
<img src="https://cdn.heirenlop.com/other/cloudflare2.png" loading="lazy">
</a>
            </figure>
        </div>