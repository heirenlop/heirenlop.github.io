+++
authors = ["Li Jialu"]
title = "Github"
url = "/work/en/github/"
date = "2024-10-28"
categories = [
    "Development Tools"
]
series = [""]
tags = [
   "Student Verification", "Github Container Registry", "Version Control"
]
+++

- [1. Student Verification](#1-student-verification)
- [2. Github Container Registry](#2-github-container-registry)

# 1. Student Verification

1. **Github Student Verification Guide**:

    [Guide Link](https://www.xiaohongshu.com/explore/669251ef0000000025000ced?xsec_token=ABe1fy8cP3Zyl7BAJQ8WFe9p4AKWaTtcd7h_FI0EyBq3k=&xsec_source=pc_user&m_source=mengfanwetab)

    The **Student Developer Pack** includes useful tools like: Github Copilot, JetBrains, Terminus.

2. **Github Copilot Verification Guide**:

    [Guide Link](https://www.xiaohongshu.com/explore/65d9412c000000000b023c34?xsec_token=ABM3dsrlfDQtTNYZ7iqRQF8iTWPGpCei8Q7mfw8ddTvuQ=&xsec_source=pc_user&m_source=mengfanwetab)

3. **JetBrains Verification Guide**:

    Note: Gmail cannot be used for verification.

4. **Terminus Verification Guide**:

    Simply log in with your Github account.

# 2. Github Container Registry

1. **Login Locally**:
    ```bash
    echo "your_token_here" | docker login ghcr.io -u your_username --password-stdin  # echo token | -u Github username
    ```

2. **Commit Container as an Image**:
    ```bash
    docker commit -m "commit message" -a "author" container_id image_name  # Save the container as an image
    ```

3. **Tag Docker Image**:
    ```bash
    docker tag your_image_name ghcr.io/your_username/your_image_name:latest
    ```

4. **Push Image**:
    ```bash
    docker push ghcr.io/your_username/your_image_name:latest
    ```

5. **Notes**:

    [Reference Link](https://laomeinote.com/posts/push-docker-images-to-github-registry/)
