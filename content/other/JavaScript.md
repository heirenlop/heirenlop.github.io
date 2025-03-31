+++
authors = ["李佳潞"]
title = "JavaScript"
date = "2024-10-25"
categories = [
    "博客"
]
series = [""]
tags = [
    
]
+++



两个示例
```html
<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/assets/css/styles.css">
</head>

<body>
    <h1>动态内容更新示例</h1>
    <button id="load-more">加载更多内容</button>
    <div id="content"></div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const button = document.getElementById('load-more');
            const contentContainer = document.getElementById('content');

            let count = 1;

            button.addEventListener('click', function () {
                const newContent = `
                    <div class="new-content">
                        这是第 ${count} 条新加载的内容。
                    </div>
                `;
                contentContainer.insertAdjacentHTML('beforeend', newContent);
                count++;
            });
        });
    </script>
</body>

```


```html
<script>
    // 等待页面加载完成
    document.addEventListener('DOMContentLoaded', function () {
        // 显示欢迎消息
        alert('欢迎阅读我的旅行日记！');

        // 获取所有图片元素
        const images = document.querySelectorAll('img');

        // 为每个图片添加点击事件
        images.forEach(function (img) {
            img.addEventListener('click', function () {
                // 获取图片的描述
                const figcaption = img.nextElementSibling;
                if (figcaption && figcaption.tagName.toLowerCase() === 'figcaption') {
                    console.log(figcaption.textContent);
                }
            });
        });
    });
</script>

```