---
title: "Ubuntu"
date: 2024-10-24
draft: false
---

# 一. 烧录镜像

1. U盘烧录软件：rufus
https://en.softonic.com/download/rufus/windows/post-download

2. 双系统烧录流程
https://blog.csdn.net/Flag_ing/article/details/121908340

3. 单系统烧录流程
https://blog.csdn.net/qq_41833455/article/details/117882535

# 二. 常用指令

1. 查看通信以及丢包率
    ```bash
    ping #ip地址
    ```

2. 查看磁盘空间
    ```bash
    df -h #目录
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
7. 查看文件大小
   ```bash
   ls -lh filename
   ```

8. 查看GPU占用率
   ```bash
   watch -n 1 nvidia-smi #每隔一秒刷新
   ```
9. 流编辑器
   ```bash
   sed -i 's/<old>/<new>/g' filename #修改filename文件内old为new
   
# 三. terminator
1. history显示指令时间
```bash
echo "export HISTTIMEFORMAT='%F %T '" >> ~/.bashrc
source ~/.bashrc
```

1. 快捷键
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

# 四. USB设备挂载

一般来讲USB设备挂在到USB2.0的接口，不要挂载到USB3.0接口。USB 2.0端口的兼容性通常更好，电力需求更稳定，因此可能会提供更好的连接稳定性。比如随身wifi需要挂载到USB2.0接口。

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

# 六. 取消升级提示
```bash
sudo vim /etc/update-manager/release-upgrades
```
修改为：
```bash
Prompt=never
```

# 七. 网速测试
安装speedtest
```bash
sudo apt update
sudo apt install speedtest-cli
```
```bash
speedtest-cli --secure
```

