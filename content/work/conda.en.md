+++
authors = ["Li Jialu"]
title = "Conda"
date = "2025-01-18"
categories = [
    "Development Tools"
]
series = [""]
tags = [
    "conda","python","virtual environment"
]
+++
- [1. Environment Management](#1-environment-management)
- [2. Environment Configuration](#2-environment-configuration)
- [3. Package Management](#3-package-management)
- [4. Change Source](#4-change-source)

# 1. Environment Management

1. **Create a virtual environment**  
    ```bash
    conda create -n <env_name> python=<version>  # -n specifies the environment name, python= specifies the Python version
    conda env create -f environment.yml  # Create environment based on the environment.yml file
    ```

2. **Delete a virtual environment**  
   ```bash
   conda env remove -n <env_name>
   ```
3. Activate/Switch virtual environments
   ```bash
   conda activate <env_name> #  Activate the virtual environment by name
   or
   source activate <env_name> 
   ```
4. Deactivate the current virtual environment
   ```bash
   conda deactivate
   ```
5. List all virtual environments
   ```bash
   conda env list
   ```
6. View current virtual environment information
   ```bash
   conda info
   ```
7. Update the environment based on the environment.yml file
   ```bash
   conda env update -f environment.yml
   ```

8. Display the list of mirror sources
   ```bash
   conda config --show channels
   ```
   
# 2. Environment Configuration

1. Export the virtual environment configuration to a .yaml file
   ```bash
   conda env export > environment.yaml
   ```
2. Create a virtual environment using a .yaml file
   ```bash
   conda env create -f environment.yaml
   ```
3. Update a virtual environment using a .yaml file
   ```bash
   conda env update -f environment.yaml
   ```
   
# 3. Package Management

1. Install a package
   ```bash
   conda install package_name # conda install numpy
   conda install package_name=version # conda install numpy=1.16.0
   ```
2. Update a package
   ```
   conda update package_name # conda update numpy
   ```

# 4. Change Source
```bash
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/
conda config --set show_channel_urls yes # Display the source URL

conda clean -i # Clean index cache
```
    