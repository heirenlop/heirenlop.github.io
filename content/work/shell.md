+++
authors = ["李佳潞"]
title = "Shell"
url = "/work/shell/"
date = "2025-06-23"
categories = [
    "脚本"
]
series = [""]
tags = [
   
]
+++

- [1. 通用下载脚本](#1-通用下载脚本)
- [2. 下载VOC2007  ](#2-下载voc2007--)
- [3. 下载COCO  ](#3-下载coco--)
- [4. 代理设置脚本  ](#4-代理设置脚本--)
- [5. 容器内代理设置脚本  ](#5-容器内代理设置脚本--)
- [6. MonoGS和3DGS的conda 环境配置](#6-monogs和3dgs的conda-环境配置)
- [7. 替换图片路径](#7-替换图片路径)
- [8. 替换视频路径](#8-替换视频路径)
- [9. 配置 nvm + Node.js 20](#9-配置-nvm--nodejs-20)
- [10. 修改pdf尺寸为标准A4(需要 ghostscript)](#10-修改pdf尺寸为标准a4需要-ghostscript)


---

## 1. 通用下载脚本

以下载cuda12.2toolkit为例

```shell

#!/bin/bash
# 🎯 目标下载地址
URL="https://developer.download.nvidia.cn/compute/cuda/12.2.2/local_installers/cuda_12.2.2_535.104.05_linux.run"
# 📂 文件名
FILENAME=$(basename "$URL")

# 🔁 无限重试下载（支持断点续传）
while true; do
    echo "🚀 开始下载（如果中断将自动续传）：$FILENAME"

    # 使用 wget -c 启用断点续传
    wget -c "$URL"
    
    # ✅ 检查是否下载成功
    if [ $? -eq 0 ]; then
        echo "✅ 下载成功: $FILENAME"
        break
    else
        echo "⏳ 下载中断，5 秒后重试..."
        sleep 5  # ⏳ 等待 5 秒后重试，避免频繁请求导致网络问题
    fi
done

```


---

## 2. 下载VOC2007 <h2 id="section2"> </h2>

```shell
#!/bin/bash
# 📂 获取脚本所在目录
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

# 📁 创建保存数据的目录
TARGET_DIR="$SCRIPT_DIR/VOC2007"
mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"

# 🌐 定义下载 URL
VOC_TRAINVAL_URL="http://host.robots.ox.ac.uk/pascal/VOC/voc2007/VOCtrainval_06-Nov-2007.tar"
VOC_TEST_URL="http://host.robots.ox.ac.uk/pascal/VOC/voc2007/VOCtest_06-Nov-2007.tar"
VOC_DEVKIT_URL="http://host.robots.ox.ac.uk/pascal/VOC/voc2007/VOCdevkit_08-Jun-2007.tar"

# ⬇️ 下载文件（带断点续传）
echo "🚀 下载 VOCtrainval_06-Nov-2007.tar..."
wget -c "$VOC_TRAINVAL_URL"

echo "🚀 下载 VOCtest_06-Nov-2007.tar..."
wget -c "$VOC_TEST_URL"

echo "🚀 下载 VOCdevkit_08-Jun-2007.tar..."
wget -c "$VOC_DEVKIT_URL"

# 📦 解压文件
echo "📂 解压 VOCtrainval_06-Nov-2007.tar..."
tar -xvf VOCtrainval_06-Nov-2007.tar
rm VOCtrainval_06-Nov-2007.tar  # 🗑️ 解压后删除 tar 文件

echo "📂 解压 VOCtest_06-Nov-2007.tar..."
tar -xvf VOCtest_06-Nov-2007.tar
rm VOCtest_06-Nov-2007.tar  # 🗑️ 解压后删除 tar 文件

echo "📂 解压 VOCdevkit_08-Jun-2007.tar..."
tar -xvf VOCdevkit_08-Jun-2007.tar
rm VOCdevkit_08-Jun-2007.tar  # 🗑️ 解压后删除 tar 文件

# 🎉 打印完成消息
echo "✅ VOC 2007 数据集下载、解压、清理完成！"

```
<a href="https://heirenlop.github.io/%E5%B7%A5%E4%BD%9C%E8%AE%B0%E5%BD%95/%E6%95%B0%E6%8D%AE%E9%9B%86/">⬅返回数据集页面🔗</a>

--- 

## 3. 下载COCO <h2 id="section3"> </h2>

```shell
#!/bin/bash
# 📂 创建图像数据目录
mkdir -p images
cd images
# ⬇️ 下载 COCO 图像数据
echo "🚀 下载 COCO 训练集数据集 (train2017.zip)..."
wget -c http://images.cocodataset.org/zips/train2017.zip

echo "🚀 下载 COCO 验证集数据集 (val2017.zip)..."
wget -c http://images.cocodataset.org/zips/val2017.zip

echo "🚀 下载 COCO 测试集数据集 (test2017.zip)..."
wget -c http://images.cocodataset.org/zips/test2017.zip

# 📦 解压 COCO 图像数据
echo "📂 解压 train2017.zip..."
unzip train2017.zip && rm -f train2017.zip

echo "📂 解压 val2017.zip..."
unzip val2017.zip && rm -f val2017.zip

echo "📂 解压 test2017.zip..."
unzip test2017.zip && rm -f test2017.zip

# 🔖 下载 COCO 注释数据
cd ..
mkdir -p annotations
cd annotations

echo "🚀 下载 COCO 注释数据 (annotations_trainval2017.zip)..."
wget -c http://images.cocodataset.org/annotations/annotations_trainval2017.zip

# 📂 解压 COCO 注释数据
echo "📂 解压 annotations_trainval2017.zip..."
unzip annotations_trainval2017.zip && rm -f annotations_trainval2017.zip

# ✅ 任务完成
echo "🎉 COCO2017 数据集下载、解压和清理完成！"
```

<a href="https://heirenlop.github.io/%E5%B7%A5%E4%BD%9C%E8%AE%B0%E5%BD%95/%E6%95%B0%E6%8D%AE%E9%9B%86/">⬅返回数据集页面🔗</a>


---

## 4. 代理设置脚本 <h2 id="section4"> </h2>

```shell
#!/bin/bash

# 设置代理地址
SOCKS5_PROXY="socks5://127.0.0.1:10808"
HTTP_PROXY="http://127.0.0.1:10809"
HTTPS_PROXY="http://127.0.0.1:10809"

# 设置环境变量，使所有工具（curl、wget、apt、docker）都能使用代理
export HTTP_PROXY=$HTTP_PROXY
export HTTPS_PROXY=$HTTPS_PROXY
export ALL_PROXY=$SOCKS5_PROXY
export http_proxy=$HTTP_PROXY
export https_proxy=$HTTPS_PROXY
export all_proxy=$SOCKS5_PROXY

echo "✅ 环境变量代理已设置"

# 配置 Conda 代理
echo "🔧 配置 Conda 代理..."
conda config --set proxy_servers.http $HTTP_PROXY
conda config --set proxy_servers.https $HTTPS_PROXY
echo "✅ Conda 代理已配置"

# 配置 Pip 代理
echo "🔧 配置 Pip 代理..."
pip config set global.proxy $HTTP_PROXY
echo "✅ Pip 代理已配置"

# 配置 Git 代理
echo "🔧 配置 Git 代理..."
git config --global http.proxy $HTTP_PROXY
git config --global https.proxy $HTTPS_PROXY
echo "✅ Git 代理已配置"

# 配置 APT 代理
echo "🔧 配置 APT 代理..."
cat <<EOF | tee /etc/apt/apt.conf.d/proxy.conf
Acquire::http::Proxy "$HTTP_PROXY";
Acquire::https::Proxy "$HTTPS_PROXY";
EOF
echo "✅ APT 代理已配置"

# 检查代理设置
echo "🔍 验证代理配置..."
echo "🔹 Conda proxy: $(conda config --show proxy_servers | grep proxy)"
echo "🔹 Pip proxy: $(pip config list | grep proxy)"
echo "🔹 Git proxy (HTTP): $(git config --global --get http.proxy)"
echo "🔹 Git proxy (HTTPS): $(git config --global --get https.proxy)"
echo "🔹 APT proxy: $(cat /etc/apt/apt.conf.d/proxy.conf)"

# 测试代理是否生效
echo "🌐 测试代理访问 Google..."
curl_test=$(curl -I https://www.google.com 2>/dev/null | head -n 1)

if [[ "$curl_test" =~ "200 OK" || "$curl_test" =~ "200 Connection established" ]]; then
    echo "✅ 代理设置成功，网络连接正常！"
    exit 0
else
    echo "❌ 代理设置失败，请检查网络或代理服务器！"
    exit 1
fi
```

<a href="https://heirenlop.github.io/%E5%B7%A5%E4%BD%9C%E8%AE%B0%E5%BD%95/proxy/">⬅返回proxy页面🔗</a>


---

## 5. 容器内代理设置脚本 <h2 id="section5"> </h2>

```shell
#!/bin/bash

# 设置代理地址
SOCKS5_PROXY="socks5://127.0.0.1:10808"
HTTP_PROXY="http://127.0.0.1:10809"
HTTPS_PROXY="http://127.0.0.1:10809"

echo "✅ 环境变量代理已设置"

# 配置 Conda 代理
echo "🔧 配置 Conda 代理..."
conda config --set proxy_servers.http $HTTP_PROXY
conda config --set proxy_servers.https $HTTPS_PROXY
echo "✅ Conda 代理已配置"

# 配置 Pip 代理
echo "🔧 配置 Pip 代理..."
pip config set global.proxy $HTTP_PROXY
echo "✅ Pip 代理已配置"

# 配置 Git 代理
echo "🔧 配置 Git 代理..."
git config --global http.proxy $HTTP_PROXY
git config --global https.proxy $HTTPS_PROXY
echo "✅ Git 代理已配置"

# 配置 APT 代理
echo "🔧 配置 APT 代理..."
cat <<EOF | tee /etc/apt/apt.conf.d/proxy.conf
Acquire::http::Proxy "$HTTP_PROXY";
Acquire::https::Proxy "$HTTPS_PROXY";
EOF
echo "✅ APT 代理已配置"

# 检查代理设置
echo "🔍 验证代理配置..."
echo "🔹 Conda proxy: $(conda config --show proxy_servers | grep proxy)"
echo "🔹 Pip proxy: $(pip config list | grep proxy)"
echo "🔹 Git proxy (HTTP): $(git config --global --get http.proxy)"
echo "🔹 Git proxy (HTTPS): $(git config --global --get https.proxy)"
echo "🔹 APT proxy: $(cat /etc/apt/apt.conf.d/proxy.conf)"

# 测试代理是否生效
echo "🌐 测试代理访问 Google..."
curl_test=$(curl -I https://www.google.com 2>/dev/null | head -n 1)

if [[ "$curl_test" =~ "200 OK" || "$curl_test" =~ "200 Connection established" ]]; then
    echo "✅ 代理设置成功，网络连接正常！"
    exit 0
else
    echo "❌ 代理设置失败，请检查网络或代理服务器！"
    exit 1
fi
```

<a href="https://heirenlop.github.io/%E5%B7%A5%E4%BD%9C%E8%AE%B0%E5%BD%95/proxy/">⬅返回proxy页面🔗</a>

## 6. MonoGS和3DGS的conda 环境配置
```shell
#!/bin/bash

# 获取当前激活的 conda 环境名称
CONDA_ENV_NAME=$(basename "$CONDA_PREFIX")

# 根据当前的 conda 环境设置不同的 OpenGL 配置
export DISPLAY=:1
echo "✅DISPLAY set to :1."
if [[ "$CONDA_ENV_NAME" == "gaussian_splatting" ]]; then
    export MESA_GL_VERSION_OVERRIDE=4.6
    echo "✅ Environment is 'gaussian_splatting'. OpenGL version set to 4.6."

elif [[ "$CONDA_ENV_NAME" == "MonoGS" ]]; then
    export MESA_GL_VERSION_OVERRIDE=4.3
    echo "✅ Environment is 'MonoGS'. OpenGL version set to 4.3."

else
    echo "❌No matching environment found. Current environment: $CONDA_ENV_NAME"
fi


```

## 7. 替换图片路径

```bash
#!/bin/bash

# 设置要替换的路径
LOCAL_PATH="/images/work-record"
CDN_PREFIX="https://cdn.heirenlop.com/work-record"

# 设置搜索目录
TARGET_DIR="/home/heirenlop/workspace/heirenlop.github.io/content/work"

# 查找并替换
find "$TARGET_DIR" -type f \( -name "*.html" -o -name "*.md" \) | while read -r file; do
  echo "🛠️  处理文件: $file"

  # 使用 sed 替换 href 和 src 两个位置的路径
  sed -i "s|href=\"$LOCAL_PATH|href=\"$CDN_PREFIX|g" "$file"
  sed -i "s|src=\"$LOCAL_PATH|src=\"$CDN_PREFIX|g" "$file"
done

echo "✅ 全部替换完成。"

```

## 8. 替换视频路径

```bash

!/bin/bash

# 要替换的旧 URL 和新 URL
OLD_URL="https://pub-5b6dc435fbf3499ca474b4b6941cb647.r2.dev/"
NEW_URL="https://cdn-v.heirenlop.com/"

# 设置搜索目录
TARGET_DIR="/home/heirenlop/workspace/heirenlop.github.io/content"  # 请修改为你
的实际目录

# 遍历所有 .html 和 .md 文件
find "$TARGET_DIR" -type f \( -name "*.html" -o -name "*.md" \) | while read -r file; do
  echo "🔁 替换文件: $file"
  sed -i "s|$OLD_URL|$NEW_URL|g" "$file"
done

echo "✅ 全部替换完成。"

```

## 9. 配置 nvm + Node.js 20 
```bash
!/bin/bash

# 设置清华源
export NVM_NODEJS_ORG_MIRROR=https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/
export NVM_DIR="$HOME/.nvm"

# 克隆 nvm 仓库
git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
cd "$NVM_DIR" || exit

# 切换到稳定版本
git checkout v0.39.7

# 加载 nvm
. "$NVM_DIR/nvm.sh"

# 写入 bashrc 自动加载
if ! grep -q 'nvm.sh' ~/.bashrc; then
  echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
  echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc
fi

# 重新加载 bashrc
source ~/.bashrc

# 安装 Node.js 20 并设为默认
nvm install 20
nvm use 20
nvm alias default 20

# 输出版本确认
echo "✅ nvm 版本: $(nvm --version)"
echo "✅ node 版本: $(node -v)"
echo "✅ npm 版本: $(npm -v)"
```

## 10. 修改pdf尺寸为标准A4(需要 ghostscript)

```bash
#!/bin/bash

# 📁 要处理的目录（当前目录）
TARGET_DIR="./"

# 📂 输出目录（可选）
OUTPUT_DIR="./a4_output"
mkdir -p "$OUTPUT_DIR"

# 📐 A4尺寸（单位：points）
# A4 = 595pt x 842pt（210mm x 297mm）
A4_WIDTH=595
A4_HEIGHT=842

# 🔁 遍历所有 PDF 文件
find "$TARGET_DIR" -maxdepth 1 -type f -name "*.pdf" | while read -r file; do
  filename=$(basename "$file")
  output_file="$OUTPUT_DIR/${filename%.pdf}_A4.pdf"
  echo "🛠️   正在处理: $filename"

  gs -o "$output_file" \
     -sDEVICE=pdfwrite \
     -dCompatibilityLevel=1.4 \
     -dPDFFitPage \
     -dFIXEDMEDIA \
     -dDEVICEWIDTHPOINTS=$A4_WIDTH \
     -dDEVICEHEIGHTPOINTS=$A4_HEIGHT \
     "$file"
done

echo "✅ 所有文件已缩放并保存至: $OUTPUT_DIR"

```
