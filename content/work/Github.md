+++
authors = ["李佳潞"]
title = "Github"
date = "2024-10-28"
categories = [
    "开发工具","版本控制"
]
series = [""]
tags = [
   "学生认证","github container registry"
]
+++

- [一. 学生认证](#一-学生认证)
- [二. github container registry](#二-github-container-registry)

# 一. 学生认证

1. github学生认证攻略：

    [攻略链接](https://www.xiaohongshu.com/explore/669251ef0000000025000ced?xsec_token=ABe1fy8cP3Zyl7BAJQ8WFe9p4AKWaTtcd7h_FI0EyBq3k=&xsec_source=pc_user&m_source=mengfanwetab)

    Student Developer Pack包含的有用的：github copilot/jetbrains/teminus


2. github copilot认证攻略：

    [攻略链接](https://www.xiaohongshu.com/explore/65d9412c000000000b023c34?xsec_token=ABM3dsrlfDQtTNYZ7iqRQF8iTWPGpCei8Q7mfw8ddTvuQ=&xsec_source=pc_user&m_source=mengfanwetab)

3. jetbrasin认证攻略：

    hit邮箱无法认证

4. terminus认证攻略

    直接登录github账号即可

# 二. github container registry

1. 本地登录
    ```bash
    echo "your_token_here" | docker login ghcr.io -u your_username --password-stdin #echo token | -u github的username
    ```
2. 打包容器为镜像
    ```bash
    docker commit -m "commit message" -a "author" container_id image_name # 将容器保存为镜像
    ```
3. 标记docker镜像
    ```bash
    docker tag your_image_name ghcr.io/your_username/your_image_name:latest
    ```

4. 推送镜像
    ```bash
    docker push ghcr.io/your_username/your_image_name:latest
    ```
5. 备注

    [参考链接](https://laomeinote.com/posts/push-docker-images-to-github-registry/)

