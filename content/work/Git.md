+++
authors = ["李佳潞"]
title = "Git"
date = "2024-10-21"
categories = [
    "开发工具"
]
series = [""]
tags = [
   "版本控制"
]
+++


- [1. 新建分支](#1-新建分支)
- [2. 删除分支](#2-删除分支)
- [3. 回退版本](#3-回退版本)
  - [3.1 整个分支回退到指定版本](#31-整个分支回退到指定版本)
  - [3.2 回退后强制上传回退版本](#32-回退后强制上传回退版本)
  - [3.3 指定文件回退到某版本](#33-指定文件回退到某版本)
- [4. 清空本地修改](#4-清空本地修改)
  - [4.1 已跟踪文件](#41-已跟踪文件)
  - [4.2未跟踪文件](#42未跟踪文件)
- [5. 撤销与修改](#5-撤销与修改)
- [6. 基于所在分支的某个版本号拉新分支](#6-基于所在分支的某个版本号拉新分支)
- [7. 打包 bundle](#7-打包-bundle)
- [8. 切换到老版本号后再切换回最新版本号](#8-切换到老版本号后再切换回最新版本号)
- [9. 查看差异](#9-查看差异)
- [10. 强制重命名当前分支](#10-强制重命名当前分支)
- [11. 将远程仓库地址添加到本地仓库](#11-将远程仓库地址添加到本地仓库)
- [12. git fetch和git pull的区别](#12-git-fetch和git-pull的区别)
  - [12.1 功能](#121-功能)
  - [12.2 用法](#122-用法)
  - [12.3 功能](#123-功能)
  - [12.4 用法](#124-用法)
- [13. 新建仓](#13-新建仓)
- [14. 拉取submodule](#14-拉取submodule)
- [15. 修改仓的地址](#15-修改仓的地址)
- [16. 生成SSH密钥对](#16-生成ssh密钥对)
- [17. 设置git 用户名和邮箱](#17-设置git-用户名和邮箱)
- [tips](#tips)



---

# 1. 新建分支
基于所在本地分支创建新分支
```shell
git checkout -b xxx 
git switch-c xxx
```
推送到远程
```shell
git push origin xxx
```
建立本地分支和远程分支联系
```shell
git branch -u origin/xxx xxx
```


---

# 2. 删除分支
删除远程分支
```shell
git push origin --delete xxx
```
删除本地分支
```shell
git branch -D xxx
```


---

# 3. 回退版本
## 3.1 整个分支回退到指定版本 
```bash
git reset --hard 版本号
```
## 3.2 回退后强制上传回退版本
a. 命令行推送
```bash
git push origin xxx -force #xxx为分支名，如git push origin main -force
```
b. 界面推送
在vscode的git插件中直接点同步，即可推送到远程仓库


## 3.3 指定文件回退到某版本
```bash
git checkout 版本号 -- 文件路径 #git checkout abc1234 -- file.txt
```


---

# 4. 清空本地修改
## 4.1 已跟踪文件

清空所有已跟踪文件的修改
```shell
git checkout .
```
清空本地某个文件修改
```shell
git checkout xxx #xxx为某文件
```
## 4.2未跟踪文件

清空所有未跟踪文件/目录的修改
```bash
git clean -fd #f为未跟踪的文件，d为未跟踪的目录
```


---

# 5. 撤销与修改
add到暂存区后未commit，撤销 add
```shell
git restore -staged xxx #xxx为需要撤销的文件
```
commit到本地仓后未push，修改 commit
```shell
git commit --amend -m "xxx" #xxx为新的提交消息
```
commit 到地仓后未push，撤销 commit
```shell
git reset --soft 上一个版本号
```


---

# 6. 基于所在分支的某个版本号拉新分支
```shell
git checkout -b new branch name xxx 版本号
git switch -c new branch name xxx 版本号
```


---

# 7. 打包 bundle
常规流程
```shell
git status
git add xxx
git commit-m "xxx"
```
通过HEAD生成 bundle
```shell
git bundle create xxx.bundle HEAD HEAD
```
验证 bundle 是否正确
```shell
git bun
dle venfy xxx.bundle
```


---

# 8. 切换到老版本号后再切换回最新版本号
```shell
git checkout xxx 版本号
git pull 远程分支到本地
```


---

# 9. 查看差异
查看版本差异
```shell
git diff 版本号
```
查看版本某文件差异
```shell
git diff 版本号 -- 文件名 #文件的路径写全
```


---

# 10. 强制重命名当前分支
```shell
git branch -M xxx #xxx为新分支名
```


---

# 11. 将远程仓库地址添加到本地仓库
一般为新建仓后，把本地仓推到远程仓做准备用。
```shell
git remote add origin xxx #xxx为远程仓库地址
```
如
```shell
git remote add origin https://github.com/heirenlop/heirenlop.github.io.git
```


---

# 12. git fetch和git pull的区别
git fetch
## 12.1 功能
从远程仓库下载最新的提交和分支信息，但不会自动合并这些更改到当前的工作分支。不会影响当前的工作目录或分支。你需要手动检查和合并这些更改（例如使用 git merge 或 git rebase）。
## 12.2 用法
```shell
git fetch <remote>
```
例如
```shell
git fetch origin
```
git pull
## 12.3 功能
是 git fetch 和 git merge 的组合。它从远程仓库下载最新的提交，并立即将这些更改合并到当前的工作分支。

## 12.4 用法
```shell
git pull <remote> <branch>
```
例如 
```shell
git pull origin main
```


---

# 13. 新建仓

(1) 个人主页New repository
(2) 本地创建新仓，以abc为例
```bash
cd abc
git init
```
(3) 添加文件，以README为例
```bash 
git status #查看状态
git add README.md
git status #查看状态
```
(4) 提交
```bash
git commit -m "first commit"
```
(5) 推送
```bash
git remote add origin git@github.com:heirenlop/abc.git #链接远程仓
git remote -v #查看状态
git push -u origin main #推送

# tips：
# 如果没有main仓
git branch -M main # 修改默认分支为main
git push -u origin main
```
(6) 修改remote链接
```bash
git remote -v  #查看状态
git remote set-url origin git@github.com:heirenlop/abc.git  #x修改为新的链接
git remote -v  #查看状态
```

---

# 14. 拉取submodule
(1) 确认仓是否有submodule
```bash
cat .gitmodules
```
(2) clone时直接拉取submodule
```bash
git clone --recursive <repository_url>
```
(3) clone后拉取submodule
```bash
git submodule update --init --recursive
```


---

# 15. 修改仓的地址

在忘记fork且clone到本地的情况下，修改别人仓地址为自己仓
(1) 网页新建自己仓
(2) 修改远程地址步骤
```bash
# 检查当前远程仓地址
git remote -v

#output 
origin  https://github.com/original_owner/original_repo.git (fetch)
origin  https://github.com/original_owner/original_repo.git (push)

# 删除原始远程仓地址
git remote remove origin

# 添加新的远程仓地址
git remote add origin https://github.com/your_username/your_repo.git

# 检查是否修改成功
git remote -v

# output
origin  https://github.com/your_username/your_repo.git (fetch)
origin  https://github.com/your_username/your_repo.git (push)

# 推送到新的远程仓
git push -u origin main 

# tips： 如果main分支不存在，新建一个main分支，再推送
git branch -M main
git push -u origin main

```
(3) 修改完远程地址后，当前本地修改不会被推送到新的远程仓，需再次推送

```bash
git status 
git add xxx
git commit -m "xxx"
git push origin main
```

---
# 16. 生成SSH密钥对
(1) 打开终端并执行以下命令，生成新的SSH密钥对
```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```
(2) 添加SSH密钥到ssh-agent
```bash
eval "$(ssh-agent -s)"
```

(3) 将SSH密钥添加到ssh-agent
```bash
ssh-add ~/.ssh/id_rsa
```
(4) 将生成的SSH公钥添加到GitHub。首先，显示SSH公钥内容
```bash
cat ~/.ssh/id_rsa.pub
```

# 17. 设置git 用户名和邮箱
```bash
git config --global user.name "你的名字"
git config --global user.email "你的邮箱@example.com"
git config --global --list # 查看配置

```


---

# tips
![没图？](/images/work-record/github.png "github逻辑图")