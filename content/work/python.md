+++
authors = ["李佳潞"]
title = "python"
date = "2025-03-12"
categories = [
    "python"
]
series = [""]
tags = [
   "python","学习记录"
]
+++
- [python 学习记录](#python-学习记录)
  - [1. 类](#1-类)
  - [2. 变量](#2-变量)
  - [3. 函数](#3-函数)
  - [4. 符号](#4-符号)
  - [5. 库](#5-库)
    - [5.1 pytorch](#51-pytorch)
    - [5.2 socket](#52-socket)
    - [5.3 numpy](#53-numpy)
    - [5.4 os](#54-os)
    - [5.5 json](#55-json)
    - [5.6 random](#56-random)
    - [5.7 PIL](#57-pil)
    - [5.8 opencv](#58-opencv)
    - [5.9 yaml](#59-yaml)
    - [5.10 rich](#510-rich)
    - [5.11 munch](#511-munch)
  - [6. 数据结构](#6-数据结构)
    - [6.1 列表 \[\]](#61-列表-)
    - [6.2 字典 {}](#62-字典-)
    - [6.3 元组 ()](#63-元组-)
    - [6.4 数组 \[\]](#64-数组-)
  - [7. 切片](#7-切片)
# python 学习记录
## 1. 类
- 继承
   ```python
   class GaussianRasterizationSettings(NamedTuple):
   ```
- 构造函数
   ```python
   def __init__(self,)
   ```
- public和private属性
  ```python
  self._raster_settings = raster_settings # private
  self.raster_settings = raster_settings  # public

  def _get_raster_settings(self): # private
  def get_raster_settings(self): # public
  ```
- 元类：用于创建类的类，决定了一个类如何被构造。
  ```python
  # 元类（metaclass） = NamedTupleMeta
  class NamedTuple(metaclass=NamedTupleMeta):
  ```
  
- 创建实例特殊方法
  ```python
  class MyClass:
    def __new__(cls, *args, **kwargs):
        print("__new__ 被调用")
        instance = super().__new__(cls)  # 调用父类 type 的 __new__
        return instance

    def __init__(self, value):
        print("__init__ 被调用")
        self.value = value

    obj = MyClass(42)  
    ### output:
    __new__ 被调用
    __init__ 被调用
  ```
- @property:装饰器，用于将类内函数变成属性，使得调用时不需要加 ()，就像访问普通变量一样。
  
------------
## 2. 变量
- 未赋值
  ```python
  a = None 
  ```
------------
## 3. 函数

- .format()
  ```python
  print("Output folder: {}".format(args.model_path))
  print("Model: {}, Epochs: {}".format("ResNet", 50))

  ```
- vars(): 获取对象的属性字典
- range()： 生成整数序列
  ```python
  # 生成从 start 到 stop 的整数序列，步长为 step。
  range(start, stop, step)
  ```
- for
  ```python
  #  遍历 cam_extrinsics 字典，并同时获取索引 idx 和键 key。
  for idx, key in enumerate(cam_extrinsics):
  ```

- with open () as file:
```python
# with： 自动管理文件的打开和关闭，避免资源泄露

# os.path.join(self.model_path, "cameras.json")： 如果路径不存在，则创建一个名为 cameras.json 的文件，并写入 json_cams 的内容。

# w: 写入 / r: 读取 / wb: 二进制写入 / rb: 二进制读取 

# json.dump(json_cams, file)： 将 json_cams 中的内容写入到 file 中。

with open(os.path.join(self.model_path, "cameras.json"), 'w') as file:
                json.dump(json_cams, file)
```

- if isinstance(v, dict): 判断 v 是否为字典类型

- current_datetime = datetime.now().strftime("%Y-%m-%d-%H-%M-%S")： 获取当前时间，并格式化为 "%Y-%m-%d-%H-%M-%S" 的字符串。




- tmp = tmp.split(".")[0]：将字符串 tmp 按照点 (.) 分割，并获取分割后的第一个部分。
  ```python
  '/workspace/MonoGS/configs/mono/tum/fr3_office.yaml'
  变成
  '/workspace/MonoGS/configs/mono/tum/fr3_office'
  ```

------------

## 4. 符号
- *= ： 乘法赋值
  ```python
  a *= 2 #等价于
  a = a * 2
  ```
- **： 幂运算
  ```python
  0.1 ** 2 # 等价于
  0.1 * 0.1 
  ```
- ~： 取反，一般用在bool掩码变量上
------------
## 5. 库
### 5.1 pytorch 
- torch.save(obj, file_path): 保存模型obj到路径file_path
- torch.cuda.empty_cache()：清空缓存
- torch.squeeze(): 删除维度
- torch.unsqueeze(): 增加维度
```python
image = torch.randn(3, 224, 224)  # 创建一个形状为 (3, 224, 224) 的张量
image = image.unsqueeze(0)  # 在第 0 维添加一个新的维度
print(image.shape)  # 输出: torch.Size([1, 3, 224, 224])
```
- .item(): 获取张量中的标量值并返回float
```python
import torch
loss = torch.tensor(2.5)  # 0 维张量
print(loss.item())  # 输出：2.5
```
- .max(): 返回张量中的最大值和索引
```python
import torch

a = torch.tensor([1, 2, 3])
b = torch.tensor([3, 1, 2])

result = torch.max(a, b)
print(result)  # 输出: tensor([3, 2, 3])
```

- .norm(): 计算张量范数
```python
# 计算 viewspace_point_tensor.grad 在 update_filter 选定的元素中的前两个维度，并计算最后一个维度的 L2 范数，并保持原来的维度。
torch.norm(viewspace_point_tensor.grad[update_filter, :2], dim=-1, keepdim=True)


# 示例
import torch

# 生成假设的梯度张量 (5, 3)
viewspace_point_tensor_grad = torch.tensor([
    [3.0, 4.0, 5.0],  # 行索引 0
    [1.0, 2.0, 3.0],  # 行索引 1
    [0.5, 0.5, 0.5],  # 行索引 2
    [4.0, 3.0, 2.0],  # 行索引 3
    [6.0, 8.0, 10.0]  # 行索引 4
])

# 选择部分索引（比如选择 0, 2, 4 这三行）
update_filter = torch.tensor([0, 2, 4])

# 取出选中的行，并截取前两列
selected_grad = viewspace_point_tensor_grad[update_filter, :2]
print("Selected Gradients:\n", selected_grad)

# 计算 L2 范数
norm_result = torch.norm(selected_grad, dim=-1, keepdim=True)
print("Norm Result:\n", norm_result)

# 输出
Selected Gradients:
 tensor([[3.0000, 4.0000],
        [0.5000, 0.5000],
        [6.0000, 8.0000]])

Norm Result:
 tensor([[5.0000],
        [0.7071],
        [10.0000]])

```

- .step(): 更新优化器的学习率
```python
# 更新优化器的学习率
gaussians.exposure_optimizer.step() 
```
- torch.where(input,true,false): 返回满足条件的索引
- torch.zero_grad(): 清空梯度
- torch.set_detect_anomaly(): 设置是否检测异常
- torch.logical_and(a,b): 逻辑与,即满足条件a和b的索引
- torch.tensor(): 将输入转换为张量
- torch.tensor().grad(): 获取张量中的梯度
- torch.tensor().isnan(): 判断张量中是否有NaN值
- torch.zeros(): 生成全零张量
- torch.zeros_like(): 生成与输入张量形状相同的全零张量
- torch.ones(): 生成全一张量
- torch.clamp(input,min,max): 数值限制，保证取值如果大于max，则取max，如果小于min，则取min
- torch.clamp_min(input,min): 数值限制，保证取值不小于min。input>min，则取input，否则取min
- torch.nn.Parameter(): 将输入转换为可训练参数
- torch.eye(): 生成单位矩阵
- torch.rand(): 生成随机数
- torch.stack(): 堆叠张量
- torch.cat(): 拼接张量
  ```python
  # dim=0 → 在行方向拼接
  # dim=1 → 在列方向拼接
  torch.cat((tensor1, tensor2, ...), dim)
  ```
  ```python
  # 生成一个形状为(3,)的随机数tensor，且值在0到1之间
  test = torch.rand(3)
  ```
### 5.2 socket


### 5.3 numpy

- np.clip() ： 限制数值范围
```python
# 计算 step 在 max_steps 之间的进度（归一化处理），使其值在 0 到 1 之间
t = np.clip(step / max_steps, 0, 1)
```
- np.log()： 计算对数
- np.exp()： 计算指数函数


- np.array(): 将输入转换为 numpy 数组
- np.transpose()： 转置矩阵 
- np.hstack()： 水平拼接矩阵
- np.vstack()： 垂直拼接矩阵
- np.flatten()： 将多维数组拉平为一维数组
- np.linalg.norm()： 计算向量的L2 范数，即模长
- np.linalg.inv()： 计算矩阵的逆矩阵
- np.asarray()： 将输入转换为 numpy 数组
###  5.4 os
- os.getenv()： 获取环境变量
- os.path.join()： 拼接路径
  ```python
  path = os.path.join("HOME", "test")
  print(path) # 输出：/HOME/test
  ```
- os.path.exists()： 判断路径是否存在
  ```python
   if os.path.exists(os.path.join(args.source_path, "sparse")):
      print("sparse folder exists")
  ```



  Image(
    id=30, 
  qvec=array([ 0.99594658,  0.04321676, -0.07542195,  0.02311393]), tvec=array([-3.26441913, -0.18824842,  2.00088495]), 
  camera_id=1, 
  name='00030.jpeg', 
  xys=array([[550.90352136,   7.60615692],
       [528.6300753 ,  41.42015624],
       [588.32130018,  47.0929698 ],
       ...,
       [302.97620595, 366.21732777],
       [ 44.8081433 , 553.1233508 ],
       [558.25662663, 509.63862292]]), 
point3D_ids=array([  -1,   -1,   -1, ..., 3763,   -1,   -1]))


### 5.5 json
- json.dump(a,file)： 将 a 序列化为 JSON 格式的字符串，并写入到文件file中。

### 5.6 random

- random.shuffle(a)： 将列表(list)a中的元素随机打乱。
- random.randint(a,b)： 返回一个随机整数，范围从a到b（包括a和b）。
### 5.7 PIL

- PIL.Image.open(path)： 打开图片，返回一个Image对象。
```python
image = PIL.Image.open(path)
```
### 5.8 opencv
- cv2.imread(path)： 读取图片，返回一个numpy数组。
- map1,map2 = cv2.initUndistortRectifyMap(cameraMatrix, distCoeffs, R, newCameraMatrix, size, m1type)： 初始化映射
- image = cv2.remap(image, map1, map2, interpolation=cv2.INTER_LINEAR)： 得到去畸变后的图像。和initUndistortRectifyMap搭配使用。




### 5.9 yaml
- output = yaml.full_load(f): 读取yaml文件，返回一个字典。
------------

### 5.10 rich
- rich.print(a): 打印a，支持颜色、格式化等。

### 5.11 munch
- b = muchify(a): 将字典a转换为munch对象b，支持点式访问。

## 6. 数据结构
### 6.1 列表 []
- 特性:
  可修改 / 可重复 / 有序
- 示例：
  ```python
  my_list = [1, 2, 3, 4, 5]
  print(type(my_list))  # <class 'list'>
  ```
- 用法：
  ```python
  a = [] 
  b = [1, 2, 3]
  a.append(1) # 添加元素
  a.extend(b) # 扩展列表
  c = len(a) # 获取长度
  d = a.pop(0) # 删除并返回指定索引的元素
  ```
### 6.2 字典 {}
- 其他表达：dict()
- 特性:
  可修改 / 无序 / 键唯一
- 示例：
  ```python
  my_dict = {"name": "Alice", "age": 25, "city": "New York"}
  print(my_dict["name"])  # Alice
  ```
### 6.3 元组 ()
- 特性:
  不可修改 / 可重复 / 有序
- 示例：
  ```python
  my_tuple = (1, 2, 3, 4, 5)
  print(type(my_tuple))  # <class 'tuple'>
  ```
### 6.4 数组 []
- 特性:
  数值计算 / 元素类型相同 / 有序
- 示例：
  ```python
  import numpy as np
  vector1 = np.array([[-6.1033707, -0.8284, 2.981597]])
  print(vector1.shape)  # (1, 3)

  vector2 = np.array([[-6.1033707], 
                      [-0.8284],
                      [2.981597]])
  print(vector2.shape)  # (3, 1)

  ```
------------
## 7. 切片

- 张量切片语法：
  ```python
  features[start_dim1:end_dim1, start_dim2:end_dim2, start_dim3:end_dim3]
   
  features[:, :, 0:1] 
  # 第一维所有元素
  # 第二维所有元素
  # 第三维取索引0到1，左闭右开，实际只取0
  # todo
  ```