+++
authors = ["Jialu Li"]
title = "Cloudflare Deployment"
date = "2025-05-17"
categories = [
    "Blog"
]
series = [""]
tags = [
    "cloudflare"
]
url = "/other/en/cloudflare/"
+++
- [1. Reference](#1-reference)
- [2. My Blog Deployment Setup](#2-my-blog-deployment-setup)
- [3. Configuration Rules](#3-configuration-rules)
  - [3.1 Caching Rules for Images \& Videos](#31-caching-rules-for-images--videos)
  - [3.2 Redirect Rules](#32-redirect-rules)

---

## 1. Reference

[Original guide (in Chinese)](https://akearer.top/post/how-to-setup-a-blog-with-hugo-and-cfpages/)

## 2. My Blog Deployment Setup

- Write content locally using **Hugo**
      ↓  
- Push the source code to **GitHub**
      ↓  
- Use **Cloudflare Pages** for automatic build and deployment
      ↓  
- Set up **custom domain**: heirenlop.com (with auto HTTPS)
      ↓  
- Store **large files (videos, images)** separately using **Cloudflare R2**
      ↓  
- **Accelerate the entire site** (including access from mainland China) via **Cloudflare CDN**

## 3. Configuration Rules

### 3.1 Caching Rules for Images & Videos

I set a custom TTL and raised the cache level to speed up access for media files.

<div class="image">
  <figure>
    <a data-fancybox="gallery" href="https://cdn.heirenlop.com/other/cloudflare1.png">
      <img src="https://cdn.heirenlop.com/other/cloudflare1.png" loading="lazy">
    </a>
  </figure>
</div>

---

### 3.2 Redirect Rules

All visits to `www.heirenlop.com/*` are automatically redirected to `https://heirenlop.com/*`.

<div class="image">
  <figure>
    <a data-fancybox="gallery" href="https://cdn.heirenlop.com/other/cloudflare2.png">
      <img src="https://cdn.heirenlop.com/other/cloudflare2.png" loading="lazy">
    </a>
  </figure>
</div>
