---
title: "NTFS与EXT4互转"
date: 2025-01-15
draft: false
---

# 一. NTFS->EXT4
1. 查看磁盘信息
```bash
sudo fdisk -l # 确认U盘设备（通常是 /dev/sdb 或 /dev/sdc 等）。
```
2. 卸载U盘
以下以/dev/sdb1为例，其他设备名请根据实际情况修改。
```bash
sudo umount /dev/sdb1
```
3. 删除现有分区
```bash
sudo fdisk /dev/sdb # 进入分区管理工具，输入d进入删除分区模式，然后输入w保存修改。
```

4. 创建新分区
```bash
sudo fdisk /dev/sdb # 进入分区管理工具，输入n创建新分区，其他默认回车,然后输入w保存修改。
```

5. 格式化分区为NTFS
```bash
sudo mkfs.ntfs /dev/sdb1
```

6. 挂载U盘
```bash
sudo mkdir /mnt/usb
sudo mount /dev/sdb1 /mnt/usb
```

7. 验证格式
```bash
df -hT /mnt/usb #输出应为ext4
```

8. 卸载U盘
```bash
sudo umount /mnt/usb
```


# 二. EXT4->NTFS

链接：https://blog.csdn.net/weixin_43681705/article/details/125040908