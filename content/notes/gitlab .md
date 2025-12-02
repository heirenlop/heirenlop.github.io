+++
authors = ["李佳潞"]
title = "Gitlab"
url = "/work/gitlab/"
date = "2025-11-09"
categories = [
    "开发工具"
]
series = [""]
tags = [
   "版本控制"
]
+++


- [1. 给github仓同步添加gitlab的remote](#1-给github仓同步添加gitlab的remote)


---

# 1. 给github仓同步添加gitlab的remote
```shell
# 查看当前remote
git remote -v

# （可选）改名origin为github
git remote rename origin github 

# 改名前
# origin	https://github.com/heirenlop/TartanIMU.git (fetch)
# origin	https://github.com/heirenlop/TartanIMU.git (push)
# 改名后
# github	https://github.com/heirenlop/TartanIMU.git (fetch)
# github	https://github.com/heirenlop/TartanIMU.git (push)

# 添加gitlab的remote
git remote add gitlab http://172.16.26.202/heirenlop/e2e-imu.git
git remote -v
# gitlab	http://172.16.26.202/heirenlop/e2e-imu.git (fetch)
# gitlab	http://172.16.26.202/heirenlop/e2e-imu.git (push)
# origin	https://github.com/heirenlop/TartanIMU.git (fetch)
# origin	https://github.com/heirenlop/TartanIMU.git (push)

# 推送到gitlab
git push -u gitlab branch_name

```
