+++
authors = ["Li Jialu"]
title = "NTFS<-->EXT4"
date = "2025-01-15"
categories = [
    "Format Conversion"
]
series = [""]
tags = [
   "NTFS", "EXT4"
]
+++

---
title: "NTFS<-->EXT4"
date: 2025-01-15
draft: false
---
- [1. NTFS-\>EXT4](#1-ntfs-ext4)
- [2. EXT4-\>NTFS](#2-ext4-ntfs)

# 1. NTFS->EXT4
1. Check Disk Information
    ```bash
    sudo fdisk -l # Confirm the USB device (usually /dev/sdb or /dev/sdc, etc.).
    ```
2. Unmount the USB drive
    The example uses /dev/sdb1; please adjust the device name based on your actual setup.
    ```bash
    sudo umount /dev/sdb1
    ```
3. Delete the existing partition
    ```bash
    sudo fdisk /dev/sdb # Enter partition management tool, type 'd' to delete the partition, then type 'w' to save changes.
    ```

4. Create a new partition
    ```bash
    sudo fdisk /dev/sdb # Enter partition management tool, type 'n' to create a new partition, press Enter for other defaults, then type 'w' to save changes.
    ```

5. Format the partition as NTFS
    ```bash
    sudo mkfs.ntfs /dev/sdb1
    ```

6. Mount the USB drive
    ```bash
    sudo mkdir /mnt/usb
    sudo mount /dev/sdb1 /mnt/usb
    ```

7. Verify the format
    ```bash
    df -hT /mnt/usb # The output should show ext4
    ```

8. Unmount the USB drive
    ```bash
    sudo umount /mnt/usb
    ```

# 2. EXT4->NTFS

[Reference Link](https://blog.csdn.net/weixin_43681705/article/details/125040908)
