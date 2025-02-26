+++
authors = ["Li Jialu"]
title = "CUDA"
date = "2025-01-23"
categories = [
    "Development Tools"
]
series = [""]
tags = [
    "GPU"
]
+++

- [1. Install CUDA Toolkit](#1-install-cuda-toolkit)
- [2. Install Drivers](#2-install-drivers)
    - [Troubleshooting](#troubleshooting)
- [3. Nvidia-container-toolkit](#3-nvidia-container-toolkit)
- [4. GPU Power Settings](#4-gpu-power-settings)

# 1. Install CUDA Toolkit

The CUDA Toolkit includes: CUDA, cuDNN, TensorRT, and more.

1. Download the CUDA Toolkit
   Download link: [CUDA Toolkit Archive](https://developer.nvidia.com/cuda-toolkit-archive)

2. Set up Environment Variables
    ```bash
    export PATH=/usr/local/cuda-12.2/bin:$PATH
    export LD_LIBRARY_PATH=/usr/local/cuda-12.2/lib64:$LD_LIBRARY_PATH
    ```

3. Test the installation
    ```bash
    nvcc --version # Display CUDA version
    ```

# 2. Install Drivers

1. Check if the system detects the NVIDIA GPU:
    ```bash
    lspci | grep -i nvidia
    ```

2. Use `ubuntu-drivers` to check for the recommended NVIDIA driver version:
    ```bash
    ubuntu-drivers devices
    ```

3. Install the recommended driver:
    To let the system automatically install the recommended NVIDIA driver:
    ```bash
    sudo ubuntu-drivers autoinstall
    ```
    If you need to install a specific driver version manually:
    ```bash
    sudo apt install nvidia-driver-535  # The recommended version on my system is 535
    ```

4. After installation, reboot the system:
    ```bash
    sudo reboot
    ```

5. Check if the NVIDIA driver is loaded:
    ```bash
    nvidia-smi  # The output should match Step 3 from the first part
    ```

At this point, the installation should be complete.

### Troubleshooting
1. If there's no output or you see an error such as:
    ```bash
    NVIDIA-SMI has failed because it couldn't communicate with the NVIDIA driver. Make sure that the latest NVIDIA driver is installed and running.
    ```
2. Run the following command to check if the driver is properly installed:
    ```bash
    dpkg -l | grep nvidia
    ```
    Look for an entry like `nvidia-driver-535`.

3. Check if the NVIDIA module is loaded:
    ```bash
    lsmod | grep nvidia
    ```
4. If there's no output, try manually loading it:
    ```bash
    sudo modprobe nvidia
    ```

If you encounter this error:
    ```bash
    modprobe: ERROR: could not insert 'nvidia': Operation not permitted
    ```
    This is likely due to Secure Boot being enabled.

5. Check if Secure Boot is enabled:
    ```bash
    mokutil --sb-state
    ```
    If it shows `SecureBoot enabled`, you need to disable it, as Secure Boot prevents unsigned drivers from loading.

6. Disabling Secure Boot:

- **Method 1: BIOS Settings**
  1. Restart the computer and enter the BIOS/UEFI settings.
  2. Find the Secure Boot option and set it to Disabled.
  3. Save the changes and exit the BIOS.

- **Method 2: MOK Settings**
  1. Run the following command to disable Secure Boot or register the key:
    ```bash
    sudo mokutil --disable-validation
    ```
  2. Set a password when prompted.
  3. Reboot the system:
    ```bash
    sudo reboot
    ```
  4. Enter the MOK management interface:
     - "Continue Boot" to proceed with normal startup.
     - "Enroll MOK" to register keys (if you selected to import keys).
     - "Disable Secure Boot" (if you ran `mokutil --disable-validation`).
     - "Change Password" to change the password.

7. Finally, check if the NVIDIA driver is properly loaded:
    ```bash
    nvidia-smi
    ```

# 3. Nvidia-container-toolkit

This toolkit helps users access/build/run GPU-accelerated applications in containerized environments (like Docker). It includes a runtime library and associated utilities that automatically configure containers to leverage NVIDIA GPUs for efficient GPU acceleration in containerized applications.

**Installation**

1. Check if `nvidia-container-toolkit` is installed:
    ```bash
    dpkg -l | grep nvidia-container-toolkit
    ```

2. Install the toolkit:
    ```bash
    sudo apt-get install -y nvidia-container-toolkit
    ```
    If you encounter the error:
    ```
    E: Unable to locate package nvidia-container-toolkit
    ```
    Follow the steps below.

3. Add NVIDIA GPG key:
    ```bash
    curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
    ```

4. Add the NVIDIA container toolkit repository:
    ```bash
    distribution=$(. /etc/os-release; echo $ID$VERSION_ID)
    curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list |
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' |
    sudo tee /etc/apt/sources.list.d/nvidia-docker.list
    ```

5. Update the package list:
    ```bash
    sudo apt-get update
    ```

6. Install `nvidia-container-toolkit`:
    ```bash
    sudo apt-get install -y nvidia-container-toolkit
    ```

7. Restart Docker service:
    ```bash
    sudo systemctl restart docker
    ```

**Usage**

1. Start a container with GPU support:
   When running a Docker container, use the `--gpus all` flag to enable GPU support, and the `-v` flag to mount the host system’s CUDA directory to the container. For example, if the host’s CUDA installation path is `/usr/local/cuda`, use:
    ```bash
    docker run --gpus all -it \ 
      -v /usr/local/cuda:/usr/local/cuda \
      your_docker_image
    ```

2. Set up environment variables inside the container to ensure it can find `nvcc`:
    ```bash
    export PATH=/usr/local/cuda/bin:$PATH
    export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
    ```

3. Test CUDA:
    ```bash
    nvcc --version
    ```

# 4. GPU Power Settings

To limit power usage:
```bash
nvidia-smi -i 0 -pl 100  # -i 0 for the first GPU, -pl 100 to limit power to 100W
```

To restore power limits:
```bash
nvidia-smi -i 0 -pl 160
```
