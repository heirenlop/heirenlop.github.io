+++
authors = ["Li Jialu"]
title = "Shell"
url = "/work/en/shell/"
date = "2025-01-23"
categories = [
    "Scripting"
]
series = [""]
tags = [
   
]
+++

- [1. General Download Script](#1-general-download-script)
- [2. DownloadVOC2007  ](#2-downloadvoc2007--)
- [3. DownloadCOCO  ](#3-downloadcoco--)
- [4. Proxy Setup Script  ](#4-proxy-setup-script--)
- [5. Proxy Setup in Container  ](#5-proxy-setup-in-container--)
- [6. Conda Environment Setup for MonoGS and 3DGS](#6-conda-environment-setup-for-monogs-and-3dgs)

# 1. General Download Script  
Example for downloading CUDA 12.2 toolkit  
```shell
#!/bin/bash

# 🎯 Target download URL
URL="https://developer.download.nvidia.cn/compute/cuda/12.2.2/local_installers/cuda_12.2.2_535.104.05_linux.run"
# 📂 Filename
FILENAME=$(basename "$URL")

# 🔁 Infinite retry for download (supports resuming from interruption)
while true; do
    echo "🚀 Starting download (will auto-resume if interrupted): $FILENAME"
    
    # Use wget -c to enable resuming
    wget -c "$URL"
    
    # ✅ Check if download was successful
    if [ $? -eq 0 ]; then
        echo "✅ Download successful: $FILENAME"
        break
    else
        echo "⏳ Download interrupted, retrying in 5 seconds..."
        sleep 5  # ⏳ Wait for 5 seconds before retrying to avoid network issues
    fi
done
```

# 2. DownloadVOC2007 <h2 id="section2"> </h2>

```shell
#!/bin/bash

# 📂 Get the script's directory
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

# 📁 Create directory to save data
TARGET_DIR="$SCRIPT_DIR/VOC2007"
mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"

# 🌐 Define download URLs
VOC_TRAINVAL_URL="http://host.robots.ox.ac.uk/pascal/VOC/voc2007/VOCtrainval_06-Nov-2007.tar"
VOC_TEST_URL="http://host.robots.ox.ac.uk/pascal/VOC/voc2007/VOCtest_06-Nov-2007.tar"
VOC_DEVKIT_URL="http://host.robots.ox.ac.uk/pascal/VOC/voc2007/VOCdevkit_08-Jun-2007.tar"

# ⬇️ Download files (supports resuming)
echo "🚀 Downloading VOCtrainval_06-Nov-2007.tar..."
wget -c "$VOC_TRAINVAL_URL"

echo "🚀 Downloading VOCtest_06-Nov-2007.tar..."
wget -c "$VOC_TEST_URL"

echo "🚀 Downloading VOCdevkit_08-Jun-2007.tar..."
wget -c "$VOC_DEVKIT_URL"

# 📦 Extract files
echo "📂 Extracting VOCtrainval_06-Nov-2007.tar..."
tar -xvf VOCtrainval_06-Nov-2007.tar
rm VOCtrainval_06-Nov-2007.tar  # 🗑️ Delete the tar file after extracting

echo "📂 Extracting VOCtest_06-Nov-2007.tar..."
tar -xvf VOCtest_06-Nov-2007.tar
rm VOCtest_06-Nov-2007.tar  # 🗑️ Delete the tar file after extracting

echo "📂 Extracting VOCdevkit_08-Jun-2007.tar..."
tar -xvf VOCdevkit_08-Jun-2007.tar
rm VOCdevkit_08-Jun-2007.tar  # 🗑️ Delete the tar file after extracting

# 🎉 Print completion message
echo "✅ VOC 2007 dataset download, extraction, and cleanup completed!"

```
<a href="https://heirenlop.github.io/%E5%B7%A5%E4%BD%9C%E8%AE%B0%E5%BD%95/%E6%95%B0%E6%8D%AE%E9%9B%86/">⬅Return to Dataset Page🔗</a>

# 3. DownloadCOCO <h2 id="section3"> </h2>

```shell
#!/bin/bash

# 📂 Create image data directory
mkdir -p images
cd images

# ⬇️ Download COCO image data
echo "🚀 Downloading COCO training set (train2017.zip)..."
wget -c http://images.cocodataset.org/zips/train2017.zip

echo "🚀 Downloading COCO validation set (val2017.zip)..."
wget -c http://images.cocodataset.org/zips/val2017.zip

echo "🚀 Downloading COCO test set (test2017.zip)..."
wget -c http://images.cocodataset.org/zips/test2017.zip

# 📦 Extract COCO image data
echo "📂 Extracting train2017.zip..."
unzip train2017.zip && rm -f train2017.zip

echo "📂 Extracting val2017.zip..."
unzip val2017.zip && rm -f val2017.zip

echo "📂 Extracting test2017.zip..."
unzip test2017.zip && rm -f test2017.zip

# 🔖 Download COCO annotation data
cd ..
mkdir -p annotations
cd annotations

echo "🚀 Downloading COCO annotation data (annotations_trainval2017.zip)..."
wget -c http://images.cocodataset.org/annotations/annotations_trainval2017.zip

# 📂 Extract COCO annotation data
echo "📂 Extracting annotations_trainval2017.zip..."
unzip annotations_trainval2017.zip && rm -f annotations_trainval2017.zip

# ✅ Task completed
echo "🎉 COCO2017 dataset download, extraction, and cleanup completed!"

```

<a href="https://heirenlop.github.io/%E5%B7%A5%E4%BD%9C%E8%AE%B0%E5%BD%95/%E6%95%B0%E6%8D%AE%E9%9B%86/">⬅Return to Dataset Page🔗</a>

# 4. Proxy Setup Script <h2 id="section4"> </h2>

```shell
#!/bin/bash

# Set proxy address
SOCKS5_PROXY="socks5://127.0.0.1:10808"
HTTP_PROXY="http://127.0.0.1:10809"
HTTPS_PROXY="http://127.0.0.1:10809"

# Set environment variables so all tools (curl, wget, apt, docker) use the proxy
export HTTP_PROXY=$HTTP_PROXY
export HTTPS_PROXY=$HTTPS_PROXY
export ALL_PROXY=$SOCKS5_PROXY
export http_proxy=$HTTP_PROXY
export https_proxy=$HTTPS_PROXY
export all_proxy=$SOCKS5_PROXY

echo "✅ Proxy environment variables set"

# Configure Conda proxy
echo "🔧 Configuring Conda proxy..."
conda config --set proxy_servers.http $HTTP_PROXY
conda config --set proxy_servers.https $HTTPS_PROXY
echo "✅ Conda proxy configured"

# Configure Pip proxy
echo "🔧 Configuring Pip proxy..."
pip config set global.proxy $HTTP_PROXY
echo "✅ Pip proxy configured"

# Configure Git proxy
echo "🔧 Configuring Git proxy..."
git config --global http.proxy $HTTP_PROXY
git config --global https.proxy $HTTPS_PROXY
echo "✅ Git proxy configured"

# Configure APT proxy
echo "🔧 Configuring APT proxy..."
cat <<EOF | tee /etc/apt/apt.conf.d/proxy.conf
Acquire::http::Proxy "$HTTP_PROXY";
Acquire::https::Proxy "$HTTPS_PROXY";
EOF
echo "✅ APT proxy configured"

# Check proxy settings
echo "🔍 Verifying proxy settings..."
echo "🔹 Conda proxy: $(conda config --show proxy_servers | grep proxy)"
echo "🔹 Pip proxy: $(pip config list | grep proxy)"
echo "🔹 Git proxy (HTTP): $(git config --global --get http.proxy)"
echo "🔹 Git proxy (HTTPS): $(git config --global --get https.proxy)"
echo "🔹 APT proxy: $(cat /etc/apt/apt.conf.d/proxy.conf)"

# Test proxy functionality
echo "🌐 Testing proxy access to Google..."
curl_test=$(curl -I https://www.google.com 2>/dev/null | head -n 1)

if [[ "$curl_test" =~ "200 OK" || "$curl_test" =~ "200 Connection established" ]]; then
    echo "✅ Proxy set up successfully, network is working!"
    exit 0
else
    echo "❌ Proxy setup failed, please check network or proxy server!"
    exit 1
fi
```

<a href="https://heirenlop.github.io/%E5%B7%A5%E4%BD%9C%E8%AE%B0%E5%BD%95/proxy/">⬅Return to Proxy Page🔗</a>

# 5. Proxy Setup in Container <h2 id="section5"> </h2>

```shell
#!/bin/bash

# Set proxy addresses
SOCKS5_PROXY="socks5://127.0.0.1:10808"
HTTP_PROXY="http://127.0.0.1:10809"
HTTPS_PROXY="http://127.0.0.1:10809"

echo "✅ Proxy environment variables have been set"

# Configure Conda proxy
echo "🔧 Configuring Conda proxy..."
conda config --set proxy_servers.http $HTTP_PROXY
conda config --set proxy_servers.https $HTTPS_PROXY
echo "✅ Conda proxy has been configured"

# Configure Pip proxy
echo "🔧 Configuring Pip proxy..."
pip config set global.proxy $HTTP_PROXY
echo "✅ Pip proxy has been configured"

# Configure Git proxy
echo "🔧 Configuring Git proxy..."
git config --global http.proxy $HTTP_PROXY
git config --global https.proxy $HTTPS_PROXY
echo "✅ Git proxy has been configured"

# Configure APT proxy
echo "🔧 Configuring APT proxy..."
cat <<EOF | tee /etc/apt/apt.conf.d/proxy.conf
Acquire::http::Proxy "$HTTP_PROXY";
Acquire::https::Proxy "$HTTPS_PROXY";
EOF
echo "✅ APT proxy has been configured"

# Verify proxy settings
echo "🔍 Verifying proxy configuration..."
echo "🔹 Conda proxy: $(conda config --show proxy_servers | grep proxy)"
echo "🔹 Pip proxy: $(pip config list | grep proxy)"
echo "🔹 Git proxy (HTTP): $(git config --global --get http.proxy)"
echo "🔹 Git proxy (HTTPS): $(git config --global --get https.proxy)"
echo "🔹 APT proxy: $(cat /etc/apt/apt.conf.d/proxy.conf)"

# Test if the proxy works
echo "🌐 Testing proxy access to Google..."
curl_test=$(curl -I https://www.google.com 2>/dev/null | head -n 1)

if [[ "$curl_test" =~ "200 OK" || "$curl_test" =~ "200 Connection established" ]]; then
    echo "✅ Proxy setup successful, network is working!"
    exit 0
else
    echo "❌ Proxy setup failed, please check network or proxy server!"
    exit 1
fi
```

<a href="https://heirenlop.github.io/%E5%B7%A5%E4%BD%9C%E8%AE%B0%E5%BD%95/proxy/">⬅返回proxy页面🔗</a>

# 6. Conda Environment Setup for MonoGS and 3DGS
```shell
#!/bin/bash

# Define the environment name
ENV_NAME="MonoGS-3DGS"

# Create the Conda environment
echo "🔧 Creating Conda environment: $ENV_NAME"
conda create --name $ENV_NAME python=3.8 -y

# Activate the environment
echo "🔧 Activating Conda environment: $ENV_NAME"
conda activate $ENV_NAME

# Install the required dependencies
echo "🔧 Installing dependencies for MonoGS and 3DGS"
conda install -c conda-forge pytorch torchvision cudatoolkit=12.2 -y
conda install -c conda-forge opencv -y
conda install -c conda-forge matplotlib -y
conda install -c conda-forge scikit-learn -y

# Task completed
echo "✅ Conda environment setup completed!"
```

