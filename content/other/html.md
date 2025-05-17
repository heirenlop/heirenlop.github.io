+++
authors = ["李佳潞"]
title = "Html"
date = "2024-10-22"
categories = [
    "博客"
]
series = [""]
tags = [
    
]
+++


## 1.1 注释

```html
<!-- xxx -->
```

## 1.2 标签
```html
(1) 基本结构标签
<!DOCTYPE html>：声明文档类型，告诉浏览器这是一个HTML5文档。
<html>：根元素，包含整个HTML文档的内容。
<head>：包含文档的元数据，如标题、字符集、链接到外部资源等。
<title>：定义文档的标题，显示在浏览器的标签页上。
<body>：包含文档的所有可见内容。
(2) 文本内容标签
<h1> 到 <h6>：标题标签，从最重要的 <h1> 到最不重要的 <h6>。
<p>：段落标签。
<br>：换行标签，不需闭合。
<strong>：加粗文本。
<em>：斜体文本，表示强调。
<span>：用于对文本进行内联样式的容器。
(3) 链接和图像
<a>：超链接标签，用于创建链接。
属性：href（目标URL）、target（目标窗口，如 _blank）。
<img>：图像标签，用于插入图片。
属性：src（图片路径）、alt（替代文本）。

示例：
    <img src="/images/daily-travel/chongqing1.jpg" alt="重庆旅行照片">

(4) 列表
<ul>：无序列表。
<ol>：有序列表。
<li>：列表项。
(5) 表格
<table>：表格标签。
<tr>：表格行。
<th>：表格头部单元格。
<td>：表格数据单元格。
(6) 表单
<form>：表单标签，用于收集用户输入。
属性：action（提交表单的URL）、method（提交方法，如 get 或 post）。
<input>：输入字段。
类型：text（文本输入）、password（密码输入）、submit（提交按钮）、checkbox（复选框）、radio（单选按钮）等。
<textarea>：多行文本输入。
<label>：标签，用于关联表单控件。
<select>：下拉列表。
<option>：下拉列表中的选项。
(7) 多媒体
<video>：视频标签。
属性：src（视频路径）、controls（显示播放控件）。

示例：
<div class="container" style="display: flex; justify-content: center;">
  <video controls style="max-width:100%; height:auto;">
    <source src="https://pub-5b6dc435fbf3499ca474b4b6941cb647.r2.dev/huache.mp4" type="video/mp4">
    您的浏览器不支持 HTML5 视频播放。
  </video>
</div>

<audio>：音频标签。
属性：src（音频路径）、controls（显示播放控件）。
(8) 其他常用标签
<div>：块级容器，用于分组和布局。
<header>：页面或区域的头部。
<footer>：页面或区域的底部。
<nav>：导航链接的集合。
<section>：文档或应用程序中的独立部分。
<article>：独立的内容，如博客文章或新闻。
<aside>：侧栏或辅助内容。
<main>：文档的主要内容。
```

## 1.3 html示例

可参考哈尔滨.md、宁波.md等中html部分：[完整示例](../生活日常/旅行/哈尔滨.md)