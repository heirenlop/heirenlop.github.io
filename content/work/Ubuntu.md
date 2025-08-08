+++
authors = ["李佳潞"]
title = "Ubuntu"
url = "/work/ubuntu/"
date = "2024-10-24"
categories = [
    "系统"
]
series = [""]
tags = [
   "ubuntu"
]
+++

- [一. 烧录镜像](#一-烧录镜像)
- [二. 常用指令](#二-常用指令)
- [七. 网速测试](#七-网速测试)
- [九. 关闭升级提示](#九-关闭升级提示)
- [十. 备份系统rsync](#十-备份系统rsync)
- [十一. 创建桌面快捷方式](#十一-创建桌面快捷方式)
- [十二. 修改fcitx输入法候选框大小](#十二-修改fcitx输入法候选框大小)


---

# 一. 烧录镜像

1. U盘烧录软件：rufus
    [rufus](https://en.softonic.com/download/rufus/windows/post-download)

2. 双系统烧录流程
    [流程1](https://blog.csdn.net/Flag_ing/article/details/121908340)

3. 单系统烧录流程
    [流程2](https://blog.csdn.net/qq_41833455/article/details/117882535)


---

# 二. 常用指令

1. 查看通信以及丢包率
    ```bash
    ping #ip地址
    ```

2. 查看空间大小
    ```bash
    df -h # 总览盘大小
    du -sh /path/to/file # 文件夹大小
    ```

3. 文件夹赋权限
    ```bash
    sudo chmod -R 777 #文件夹路径
    ```
    修改文件夹的拥有者
    ```bash
    sudo chown -R <user>:<user> #文件路径,如sudo chown -R heirenlop:heirenlop ./workspace
    ```

4. 查看usb信息
   (1) 查看usb设备
   ```bash
   lsusb
   ```
   (2) 查看usb设备详细信息
   ```bash
   lsusb -v
   ```
   (3) 查看硬件设备内核信息，用来调试
   ```bash
   dmesg | grep -i usb
   ```

5. 查找历史指令并高亮显示
   ```bash
   history | grep -i <keyword>
   ```

6. 查找文件
   ```bash
   locate filename
   ```
   忽略filename大小写
   ```bash
   locate -i filename
   ```

7. 查看GPU占用率
   ```bash
   watch -n 1 nvidia-smi #每隔一秒刷新
   ```
8. 流编辑器
   ```bash
   sed -i 's/<old>/<new>/g' filename #修改filename文件内old为new
9.  安装程序
    ```bash
    sudo apt install -y <package> # -y 自动确认所有提示
    ``` 
10. 查看图片分辨率
    ```bash
    file image.jpg 
    ```
11. 查看共享内存shm大小
    ```bash
    df -h /dev/shm 
    # docker内输入
    shm              64M  412K   64M   1% /dev/shm
    # 宿主机内输入
    tmpfs           7.7G  532M  7.2G    7% /dev/shm
    ```
12. 查看系统日志
    ```bash
    dmesg | tail -n 50
    ```
13. 解压.tar.gz文件
    ```bash
    tar -zxvf file.tar.gz -C /path/to/directory # -C 指定解压路径
    ```
14. 删除apt-get安装的软件
    ```bash
    # 以删除vlc为例
    sudo apt-get remove vlc
    sudo apt-get purge vlc
    sudo apt-get autoremove 
    ```
15. 查看主机序列号
    ```bash
    sudo dmidecode -s system-serial-number
    ```
16. 查看系统安装了哪些字体
    ```bash
    fc-list :lang=zh
    ```
17. passwd命令设置密码
    ```bash
    sudo passwd -d <username> # 设置空密码
    sudo passwd <username> # 输入并确认新的密码
    ```

18. 压缩zip文件
    ```bash
    zip -r my_project.zip my_project/
    ```
19. 强制刷新页面
    ```bash
    ctrl + shift + r
    ```
---

# 三. 常用软件
1. terminator
    (1) history显示指令时间
    ```bash
    echo "export HISTTIMEFORMAT='%F %T '" >> ~/.bashrc
    source ~/.bashrc
    ```
    (2) 颜色显示

    蓝色：目录
    绿色：可执行文件
    浅蓝色：符号链接
    红色：压缩文件（如 .tar、.zip 等）
    黄色：设备文件（如块设备、字符设备）
    紫色：图像文件
    灰色：其他文件


    (3) 快捷键
    ```bash
    //第一部份：关于在同一个标签内的操作
    Alt+Up                          //移动到上面的终端
    Alt+Down                        //移动到下面的终端
    Alt+Left                        //移动到左边的终端
    Alt+Right                       //移动到右边的终端
    Ctrl+Shift+O                    //水平分割终端
    Ctrl+Shift+E                    //垂直分割终端
    Ctrl+Shift+Right                //在垂直分割的终端中将分割条向右移动
    Ctrl+Shift+Left                 //在垂直分割的终端中将分割条向左移动
    Ctrl+Shift+Up                   //在水平分割的终端中将分割条向上移动
    Ctrl+Shift+Down                 //在水平分割的终端中将分割条向下移动
    Ctrl+Shift+S                    //隐藏/显示滚动条
    Ctrl+Shift+F                    //搜索
    Ctrl+Shift+C                    //复制选中的内容到剪贴板
    Ctrl+Shift+V                    //粘贴剪贴板的内容到此处
    Ctrl+Shift+W                    //关闭当前终端
    Ctrl+Shift+Q                    //退出当前窗口，当前窗口的所有终端都将被关闭
    Ctrl+Shift+X                    //最大化显示当前终端
    Ctrl+Shift+Z                    //最大化显示当前终端并使字体放大
    Ctrl+Shift+N or Ctrl+Tab        //移动到下一个终端
    Ctrl+Shift+P or Ctrl+Shift+Tab  //Crtl+Shift+Tab 移动到之前的一个终端
    
    //第二部份：有关各个标签之间的操作
    F11                             //全屏开关
    Ctrl+Shift+T                    //打开一个新的标签
    Ctrl+PageDown                   //移动到下一个标签
    Ctrl+PageUp                     //移动到上一个标签
    Ctrl+Shift+PageDown             //将当前标签与其后一个标签交换位置
    Ctrl+Shift+PageUp               //将当前标签与其前一个标签交换位置
    Ctrl+Plus (+)                   //增大字体
    Ctrl+Minus (-)                  //减小字体
    Ctrl+Zero (0)                   //恢复字体到原始大小
    Ctrl+Shift+R                    //重置终端状态
    Ctrl+Shift+G                    //重置终端状态并clear屏幕
    Super+g                         //绑定所有的终端，以便向一个输入能够输入到所有的终端
    Super+Shift+G                   //解除绑定
    Super+t                         //绑定当前标签的所有终端，向一个终端输入的内容会自动输入到其他终端
    Super+Shift+T                   //解除绑定
    Ctrl+Shift+I                    //打开一个窗口，新窗口与原来的窗口使用同一个进程
    Super+i                         //打开一个新窗口，新窗口与原来的窗口使用不同的进程
    ```

2. snap

    ```bash
    snap list # 查看已安装的snap包
    snap remove <snap包名> # 删除snap包
    snap refresh <snap包名> # 更新snap包
    snap install <snap包名> # 安装snap包
    ```

3. nvitop

    ```bash
    pip3 install --upgrade nvitop # 安装
    nvitop --monitor #打开监控
    ```


4. AppImageLauncher
   一个工具，用于将AppImage文件自动安装到系统，并显示图标。

---

# 四. USB设备挂载问题

    一般来讲USB设备挂在到USB2.0的接口，不要挂载到USB3.0接口。USB 2.0端口的兼容性通常更好，电力需求更稳定，因此可能会提供更好的连接稳定性。比如随身wifi需要挂载到USB2.0接口。


---

# 五. Docker自动补全

1. 安装 bash-completion

    ```bash
    sudo apt update
    sudo apt install bash-completion
    ```
2. 添加脚本
    执行以下命令将 Docker 的自动补全脚本添加到你的 shell 配置文件中（例如 .bashrc）：
    ```bash
    echo 'source /usr/share/bash-completion/completions/docker' >> ~/.bashrc
    source ~/.bashrc
    ```


---

# 六. 取消升级提示
```bash
sudo vim /etc/update-manager/release-upgrades
```
修改为：
```bash
Prompt=never
```


---

# 七. 网速测试
安装speedtest
```bash
sudo apt update
sudo apt install speedtest-cli
```
```bash
speedtest-cli --secure
```



---

# 九. 关闭升级提示

1. /etc/apt/apt.conf.d/10periodic
    禁止自动下载更新文件，（0 是关闭，1 是开启，将所有值改为 0）
    做以下修改：
    ```bash
    APT::Periodic::Update-Package-Lists "0";
    APT::Periodic::Download-Upgradeable-Packages "0";
    APT::Periodic::AutocleanInterval "0";
    ```

2. /etc/apt/apt.conf.d/20auto-upgrades
    禁用安全更新功能，（0 是关闭，1 是开启，将所有值改为 0）
    做以下修改：
    ```bash
    APT::Periodic::Update-Package-Lists "0";
    APT::Periodic::Unattended-Upgrade "0";
    ```

3. 重启：sudo reboot


---

# 十. 备份系统rsync

1. rsync指令
   
    [参考链接](https://www.ruanyifeng.com/blog/2020/08/rsync.html)

2. 需要备份的文件

   - /etc：包含系统的配置文件。
   - /home：包含用户的个人数据和配置。
   - /var：包含可变数据，如日志、邮件和数据库等。
   - /usr：包含用户安装的程序和库。
   - /opt：包含可选的应用程序软件包。
   - /boot：包含启动加载器和内核相关文件。
   - /lib：包含系统库文件。
   - /root：包含管理员的个人数据。
    等等

3. 不需要备份的文件
   - /dev：包含设备文件，如 /dev/sda1。
   - /proc：包含进程信息。
   - /sys：包含系统信息。
   - /tmp：包含临时文件。
   - /run：包含运行时数据。
   - /mnt：包含挂载的目录。
   - /media：包含挂载的目录。
   - /var/log：包含日志文件。
   - /var/cache/apt/archives：包含软件包缓存。

4. 备份指令
    (1) 测试备份
    ```bash
    sudo rsync -avh --info=progress2 --dry-run --delete \
        --exclude=/proc \
        --exclude=/sys \
        --exclude=/dev \
        --exclude=/run \
        --exclude=/tmp \
        --exclude=/mnt \
        --exclude=/media \
        --exclude=/var/cache/apt/archives \
        --exclude=/var/log \
        --exclude=/Dataset \
        --exclude=/home/heirenlop/docker \
        / /home/heirenlop/mount/2T/backup_ubuntu/20250117


---

    # --dry-run：测试备份，不会实际进行备份。

---

    # --delete：删除目标目录中不存在于源目录中的文件。

---

    # --exclude：排除指定目录和文件。

---

    # -avz：备份文件时使用压缩和校验,且显示详细信息。

---

    # --info=progress2：显示备份的进度。
    ```
    显示信息一般如下：
    ```bash
    sent 106,950,204 bytes  received 10,927,096 bytes  2,381,359.60 bytes/sec
    total size is 473,654,672,042  speedup is 4,018.20 (DRY RUN)
    ```
    (2) 正常备份
    ```bash
    sudo rsync -avz --info=progress2 --delete \
        --exclude=/proc \
        --exclude=/sys \
        --exclude=/dev \
        --exclude=/run \
        --exclude=/tmp \
        --exclude=/mnt \
        --exclude=/media \
        --exclude=/var/cache/apt/archives \
        --exclude=/var/log \
        --exclude=/Dataset \
        --exclude=/home/heirenlop/docker \
        / /home/heirenlop/mount/2T/backup_ubuntu/20250117
    ```

---

# 十一. 创建桌面快捷方式

以colmap为例

1. 进入应用文件夹
    ```bash
    /usr/share/applications
    ```
2. 创建并编写colmap.desktop
    ```bash
    [Desktop Entry]
    Name=COLMAP
    Comment=Structure-from-Motion and Multi-View Stereo
    Exec=/usr/local/bin/colmap
    Icon=/usr/local/share/icons/colmap.svg
    Terminal=false
    Type=Application
    Categories=Graphics;3DGraphics;
    ```

3. 设置权限
    ```bash
    sudo chmod +x /usr/local/bin/colmap
    ```


---

# 十二. 修改fcitx输入法候选框大小
1. 进入fcitx配置界面
    ```bash

---

    # 启动fcitx配置界面
    fcitx-configtool

---

    # 外观-> 字体大小修改
    ```
2. 重启fcitx
   ```bash
   fcitx -r
   ```


