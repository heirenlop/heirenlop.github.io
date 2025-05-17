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
+++

## 1. 参考

[参考链接](https://akearer.top/post/how-to-setup-a-blog-with-hugo-and-cfpages/)

## 2. 当前博客配置思路

本地 Hugo 写
      ↓ GitHub 托管源代码
      ↓ Cloudflare Pages 自动构建 + 部署
      ↓ 自定义域名 heirenlop.com（自动 HTTPS）
      ↓ 视频等大文件通过 Cloudflare R2 存储分离
      ↓ 全站由 Cloudflare CDN 加速（包括中国大陆）
