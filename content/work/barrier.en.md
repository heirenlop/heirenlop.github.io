+++
authors = ["Li Jialu"]
title = "Barrier"
url = "/work/en/barrier/"
date = "2024-12-02"
categories = [
    "Software"
]
series = [""]
tags = [
    ""
]
+++

- [1. Usage](#1-usage)
- [2. Issues](#2-issues)
  - [2.1 Windows Firewall Settings](#21-windows-firewall-settings)
  - [2.2 Windows Port Settings](#22-windows-port-settings)

# 1. Usage
[Reference 1](https://blog.csdn.net/guojingyue123/article/details/135066151)

[Reference 2](https://juejin.cn/post/7163950376079753252)

# 2. Issues

## 2.1 Windows Firewall Settings

1. Open Windows Firewall Settings  
Press Win + R to open the Run window, type `control`, and press Enter to open the Control Panel.  
In the Control Panel, select **System and Security**, then choose **Windows Defender Firewall**.

2. Allow Apps Through the Firewall  
In the Windows Defender Firewall window, click on **Allow an app or feature through Windows Defender Firewall** on the left.  
In the pop-up window, click on **Change settings** at the bottom right and find **Barrier** or **Barrier Server** (if already listed). Ensure both "Private" and "Public" network checkboxes are selected to allow the program's communication.

## 2.2 Windows Port Settings

If you can't find Barrier or need to manually configure the port, follow these steps to open port 24800:

1. Go back to the Windows Defender Firewall settings.  
2. Click on **Advanced settings** on the left to open the Windows Firewall with Advanced Security.  
3. Select **Inbound Rules** on the left.  
4. Choose **Port** and check the port number.
