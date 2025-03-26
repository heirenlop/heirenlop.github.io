+++
authors = ["李佳潞"]
title = "Point-SLAM"
date = "2024-12-31"
categories = [
    "SLAM"
]
series = [""]
tags = [
   "端到端","CUDA","深度学习"
]
+++

- [一. 程序](#一-程序)
- [二. 问题](#二-问题)
- [三. 测试](#三-测试)

# 一. 程序

源码：<https://github.com/eriksandstroem/Point-SLAM>

根据pytorch和cuda toolkit版本，要求ubuntu为20.04

# 二. 问题

程序内无可视化界面，但可通过wandb可视化。

# 三. 测试
1. 完善dockerfile
```bash
RUN apt-get update && apt-get install -y vim # 安装vim 
RUN pip install wandb # 安装wandb
```

2. 运行容器并挂载数据集
```bash
docker run -v /home/heirenlop/workspace/Dataset/Point-SLAM/Replica:/point-slam/datasets/Replica -it --gpus all point-slam:latest
```

3. 修改参数
修改 configs/point_slam.yaml
```yaml
wandb : false -> true
wandb_folder : "old path" -> "new path""
```

4. 运行程序
```python
python run.py configs/Replica/room0.yaml
```

5. 输出

以Replica的wandb 日志为例

<div class="container">
    <div class="image">
        <figure>
          <a data-fancybox="gallery" href="/images/work-record/wandb1.png" data-lightbox="point-slam">
              <img src="/images/work-record/wandb1.png" loading="lazy">
          </a>
        </figure>
    </div>
</div>

(1) *参数*

| 图表名称            | 横坐标单位         | 纵坐标单位                |
|---------------------|--------------------|---------------------------|
| `color_loss_tracker`| Step（步数，无单位）| Loss（无单位）            |
| `color_loss_pixel`  | Step（步数，无单位）| Loss per Pixel（无单位）  |
| `num_joint_iters`   | Step（步数，无单位）| Iterations（次数）        |
| `pts_total`         | Step（步数，无单位）| Points Count（个）        |
| `camera_quad_error` | Step（步数，无单位）| Quaternion Error（无单位）|
| `time`              | Step（步数，无单位）| Time per Frame（秒）      |


(2) *color_loss_tracker*
指标意义：这是 Point-SLAM 中颜色损失的跟踪器，用于评估在 SLAM 系统中对颜色信息的预测误差。
变化趋势：
起初损失较低，随后略有上升。
可能的原因：随着更多帧的处理，系统可能开始尝试拟合更复杂的颜色分布，导致损失增加。

(3) *color_loss_pixel*
指标意义：评估单个像素的颜色损失，用于衡量系统对颜色信息的拟合程度。
变化趋势：
开始时损失较高，随后迅速下降，最后趋于平稳。
可能的解释：
起初系统对数据的拟合较差，随着优化进行，系统逐渐拟合数据。

(4) *num_joint_iters*
指标意义：每一帧中优化过程所需的迭代次数。
变化趋势：
开始时迭代次数很高，随后迅速下降并稳定在较低值。
可能的解释：
系统在初期需要更多迭代来调整参数，随着优化的收敛，迭代次数减少。

(5) *pts_total*
蓝色曲线，来自 mapper_20250102_090445。
指标意义：SLAM 系统中总点数的累积数量。
变化趋势：
曲线呈现线性增长，表明系统持续添加新的点到地图中。
可能的解释：
系统每处理一帧，会提取新的点云信息。

(6) *camera_quad_error*
指标意义：SLAM 中相机姿态（四元数）估计的误差。
变化趋势：
曲线在整个运行过程中有较大的波动。
可能的解释：
不同帧的姿态估计可能受到噪声或数据分布变化的影响。

(7) *time*
指标意义：每帧的处理时间。
变化趋势：
时间逐渐上升，表明处理复杂性随着时间增加。
可能的解释：
随着点云数量增加，每帧需要处理的数据更多，导致耗时增加。

<div class="container">
    <div class="image">
        <figure>
          <a data-fancybox="gallery" href="/images/work-record/wandb2.png" data-lightbox="point-slam">
              <img src="/images/work-record/wandb2.png" loading="lazy">
          </a>
        </figure>
    </div>
</div>

(1) *Mapping_00100_0299 和 Mapping_00050_0299*
这是两个不同的时间点或关键帧的结果。

(2) *第一行：深度图的可视化*

a. Input Depth：
表示 SLAM 系统输入的深度图（真实深度）。
通常是由深度相机获取或 Ground Truth 提供的深度信息。
颜色编码：深色（蓝色）表示近距离，亮色（黄色/红色）表示远距离。

b. Rendered Depth：
表示由 SLAM 系统生成或预测的深度图。
通过渲染模型输出的深度估计。

c. Depth Residual：
表示输入深度图与生成深度图间的误差（残差）。
颜色越亮，表示误差越大；颜色接近黑色，表示误差接近零。

作用：用于评估 SLAM 系统在深度信息上的拟合效果。

(3) *第二行：RGB图的可视化*

a. Input RGB：
表示 SLAM 系统输入的 RGB 图像（原始图像）。
通常是相机采集的真实场景图像。

b. Rendered RGB：
表示 SLAM 系统根据场景建模生成的 RGB 图像。
通过系统的渲染和颜色估计模块生成。

c. RGB Residual：
表示输入 RGB 图像与生成 RGB 图像之间的误差（残差）。
通常是基于像素的差异显示，颜色越亮表示误差越大。

<div class="container">
    <div class="image">
        <figure>
          <a data-fancybox="gallery" href="/images/work-record/wandb3.jpg" data-lightbox="point-slam">
              <img src="/images/work-record/wandb3.jpg" loading="lazy">
          </a>
        </figure>
    </div>
</div>

(1) *geo_loss_pixel*
纵坐标：几何误差，通常表示每个像素的几何损失。
趋势：
初期模型拟合场景时，误差快速下降。
后期场景复杂性增加，几何拟合受到更多挑战。
观察意义：几何误差的下降和波动情况可以用来评估优化效果。

(2) *idx_map*
纵坐标（Map Index）：当前地图中的关键帧或地图块索引。
趋势：
曲线呈现线性增长，表明地图中的索引在每帧都在增加。
观察意义：反映系统地图构建过程的动态变化。

