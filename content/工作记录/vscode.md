---
title: "Vscode"
date: 2024-10-24
draft: false
---
# 一：设置相关

1. vscode同步多电脑

(1) 页面左下角设置同步打开

(2) 选择需要同步的内容

(3) 登录github

(4) 同步

2. Auto save

 <div class="container">
                <div class="image">
                    <figure>
                        <img src="/images/work-record/vscode1.png",alt="设置1",loading="lazy">
                        <figcaption>步骤1</figcaption>
                    </figure>
                </div>
</div>
 <div class="container">
                <div class="image">
                    <figure>
                        <img src="/images/work-record/vscode2.png",alt="设置2",loading="lazy">
                        <figcaption>步骤2</figcaption>
                    </figure>
                </div>
</div>

# 二：插件相关 

1. ssh

(1) ssh到ubuntu，以及ubuntu需要的设置
<https://blog.csdn.net/zsyyugong/article/details/134438071>

2. Git->Windiows

<https://blog.csdn.net/czjl6886/article/details/122129576>

3. Git->Linux

(1) 安装git

```bash
sudo apt update
sudo apt install git
```

(2) 验证

```bash
git --version
```

(3) 配置github账户

```bash
git config --global user.name "Your Name"
git config --global user.email "youremail@example.com"
```

(4) 生成SSH密钥，如果有密钥直接复制过来就行，没有的话如下生成

```bash
ssh-keygen -t rsa -b 4096 -C "youremail@example.com"
```

(5) 查看密钥内容

```bash
cat ~/.ssh/id_rsa.pub
```

(6) github网页设置密钥
登录到 GitHub，然后进入 Settings > SSH and GPG keys 页面，点击 New SSH key。
粘贴复制的公钥，并为它取个名字，然后保存。
(7) 测试SSH链接

```bash
ssh -T git@github.com
```

如果成功，会显示类似于 Hi username! You've successfully authenticated, but GitHub does not provide shell access. 的消息。

4. dev container
    构建dev容器流程
    (1) 程序内新建.devcontainer/devcontainer.json;
    (2) ctrl+shift+p，选择dev container: open folder in container构建dev容器（如果有dockerfile直接根据dockerfile生成）;
    (3) 配置完成后，点击rebuild container，构建开发容器;

# 三：快捷键

1. 显示右侧边栏

   ```bash
   ctrl+alt+b
   ```

2. 显示左侧边栏

   ```bash
   ctrl+b
   ```

3. 显示底部边栏

   ```bash
   ctrl+j
   ```
# 四：无法输入中文问题

1. 卸载 Snap 版本的 VS Code
```bash
sudo snap remove code
```
2. 添加微软的 GPG 密钥和软件源
```bash
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg

sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/

sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

rm -f packages.microsoft.gpg
```

3. 更新apt缓存并安装
```bash
sudo apt-get update
sudo apt-get install code
```
