---
title: "markdwon语法示例"
date: 2024-10-20
draft: false
public: true
categories: ["markdown"]
tags: ["语法"]
---

# 1. 插入

## (1). 插入图片

Markdown 的完整图片语法是 ![没图？](/images/ceshi.png "hugo为了测试")

没图？ 用于源码模式和图片未成功加载提示图片用途
/images/ceshi.png 是图片地址，可以是本地的也可以是网络图床
hugo 是图片标题，默认是鼠标悬浮显示

### 图片说明

这是示例图片的说明文字。

## (2). 插入视频

### 使用 HTML 插入视频

假设视频存储在 `static/videos` 目录下：

<video controls>
  <source src="/videos/example-video.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

### 视频说明

这是示例视频的说明文字。

## (3). 插入代码块

### Python 代码块

```python
def hello_world():
    print("Hello, world!")
```

# 2. 字体

示例：

```python
**这是加粗的文字**

*这是斜体的文字*`

***这是斜体加粗的文字***

~~这是加删除线的文字~~
```

效果：

**这是加粗的文字**

*这是斜体的文字*`

***这是斜体加粗的文字***

~~这是加删除线的文字~~

# 3. 引用

示例：

```python
>这是引用的内容

>>这是引用的内容

>>>>>>>>>>这是引用的内容
```

效果：

>这是引用的内容
测试
>>这是引用的内容
测试
>>>>>>>>>>这是引用的内容
测试

# 4. 列表

示例：

```python

| Left Aligned | Right Aligned | Center Aligned |
|:-------------|--------------:|:--------------:|
| Text | Text | Text |
| More Text | More Text| More Text |
```

效果：

| Left Aligned | Right Aligned | Center Aligned |
|:-------------|--------------:|:--------------:|
| Text | Text | Text |
| More Text | More Text| More Text |

# 5. 任务列表

示例：

```python

- [x] Write the press release
- [ ] Update the website
- [ ] Contact the media
```

效果：

- [x] Write the press release
- [ ] Update the website
- [ ] Contact the media

# 6. emoji

示例：

```python
:tent:
```

效果：
:tent:

emoji表格：https://gist.github.com/rxaviers/7360908