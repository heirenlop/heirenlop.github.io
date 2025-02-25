---
title: "Css"
date: 2024-10-22
draft: false
public: true
categories: ["css"]
tags: ["语法"]
---

## 1.1 注释

```css
/* xxxx */
```

## 1.2 新建类选择器

(1) 如新建类选择器.third-class，可以在标签内选择class="third-class"

```css
.third-class {
  }
```
(2) 定义标签hr，定义页面内所有带有hr标签的内容
*tips:定义标签时，无"."*
```css
hr{
}
```

## 1.3 设置类选择器

(1) 以写过的类选择器为例

```css
.third-class {
    /* 设置字体大小 */
    font-size: 18px;
    /* 设置字体颜色 */
    color: darkblue;
    /* 设置字体斜体 */
    font-style: italic;
    /* 设置行缩进 */
    margin-left: 50px;
    /* 字体设置下划线 */
    text-decoration: underline;
    /* 设置字体格式 */
    font-family: '宋体', 'Microsoft YaHei',sans-serif;
}
```
```css
.summary icon {
  /* 调整图标与文本之间的间距 */
  margin-right: 8px; 
  /* 设置图标的颜色 */
  color: #ffdd00; 
}
```
```css
.underline {
    text-decoration: underline;
}

```
(2) 以写过的为例
```css
hr {
    border: none;
    /* 分割线粗细 */
    height: 1px;
    /* 分割线颜色 */
    background-color: #ccc;
    /* 分割线上下边距为20px */
    margin: 20px 0; 
  }
```
## 1.4 css样式配置

新增styles.css文件，路径一般为static/assets/css/路径下，可通过：
```html
<head>
    <link rel="stylesheet" href="/assets/css/styles.css">
</head>
```
引入后，在html中即可使用。

## 1.5 css示例

可参考styles.css文件：[完整示例](../../static/assets/css/styles.css)
