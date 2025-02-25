+++
authors = ["李佳潞"]
title = "Gparted"
date = "2025-01-19"
categories = [
    "软件"
]
series = [""]
tags = [
   "内存管理","ubuntu"
]
+++

# Gparted分配磁盘空间

删除windows磁盘，多余空间分配给Ubuntu

1. 进入TRY UBUNTU模式
   (1) 插入 U盘 启动Ubuntu,F12进入U盘启动界面
   (2) 选择U盘启动，进入ubuntu，进入try ubunut模式
    <div class="container">
        <div class="image">
            <figure>
                    <img src="/images/work-record/gparted.png">
                    <figcaption>选地一个进入ubunut</figcaption>
            </figure>
        </div>
    </div>
2. 启动Gparted
   (1) 删除需要删除的磁盘
   (2) 扩展磁盘：扩展的磁盘必须往左右两侧扩展
        free space preceding 为左侧预留多少空间
        new size 为扩展的该磁盘大小
        free space following 为右侧预留多少空紧挨
   (3) 扩展后点击对号保存

3. 退出try ubuntu，重启进入正常系统