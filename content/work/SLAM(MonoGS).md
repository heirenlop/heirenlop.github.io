+++
authors = ["李佳潞"]
title = "MonoGS"
date = "2025-02-13"
categories = [
    "SLAM"
]
series = [""]
tags = [
   "3DGS","CUDA","机器学习"
]
+++

- [*代码部分*](#代码部分)
- [1. 程序](#1-程序)
- [2. 问题](#2-问题)
  - [2.1 libtorch\_cpu.so问题](#21-libtorch_cpuso问题)
  - [2.2 opengl问题](#22-opengl问题)
- [3. 复现](#3-复现)
  - [3.1 DEMO复现](#31-demo复现)
  - [3.2 本地复现](#32-本地复现)
- [4. 代码解读](#4-代码解读)
- [*论文部分*](#论文部分)
  - [5. 前置内容](#5-前置内容)
    - [5.1 相机内参矩阵(K)](#51-相机内参矩阵k)


--- 

# *代码部分*


---

# 1. 程序
源码：<https://github.com/muskie82/MonoGS>

---

# 2. 问题
## 2.1 libtorch_cpu.so问题
- 如果遇到错误 libtorch_cpu.so: undefined symbol: iJIT_NotifyEvent，尝试运行 pip install mkl==2024.0
   
## 2.2 opengl问题
- 如果是在conda内运行可视化，可能会出现x11问题，本质也是opengl问题，同3dgs问题相同：
```bash
Traceback (most recent call last):
  File "slam.py", line 252, in <module>
    slam = SLAM(config, save_dir=save_dir)
  File "slam.py", line 110, in __init__
    self.frontend.run()
  File "/MonoGS/MonoGS/utils/slam_frontend.py", line 482, in run
    data = self.frontend_queue.get()
  File "/usr/lib/python3.8/multiprocessing/queues.py", line 116, in get
    return _ForkingPickler.loads(res)
  File "/usr/local/lib/python3.8/dist-packages/torch/multiprocessing/reductions.py", line 149, in rebuild_cuda_tensor
    storage = storage_cls._new_shared_cuda(
  File "/usr/local/lib/python3.8/dist-packages/torch/storage.py", line 1212, in _new_shared_cuda
    return torch.UntypedStorage._new_shared_cuda(*args, **kwargs)
RuntimeError: CUDA error: invalid resource handle
CUDA kernel errors might be asynchronously reported at some other API call, so the stacktrace below might be incorrect.
For debugging consider passing CUDA_LAUNCH_BLOCKING=1
Compile with `TORCH_USE_CUDA_DSA` to enable device-side assertions.
                                                                                                                                                                                                                 Process Process-4:
Traceback (most recent call last):
  File "/usr/lib/python3.8/multiprocessing/process.py", line 315, in _bootstrap
    self.run()
  File "/usr/lib/python3.8/multiprocessing/process.py", line 108, in run
    self._target(*self._args, **self._kwargs)
  File "/MonoGS/MonoGS/gui/slam_gui.py", line 688, in run
    app.run()
  File "/MonoGS/MonoGS/gui/slam_gui.py", line 676, in update
    self.scene_update()
  File "/MonoGS/MonoGS/gui/slam_gui.py", line 662, in scene_update
    self.receive_data(self.q_main2vis)
  File "/MonoGS/MonoGS/gui/slam_gui.py", line 394, in receive_data
    gaussian_packet = get_latest_queue(q)
  File "/MonoGS/MonoGS/gui/gui_utils.py", line 148, in get_latest_queue
    message_latest = q.get_nowait()
  File "/usr/lib/python3.8/multiprocessing/queues.py", line 129, in get_nowait
    return self.get(False)
  File "/usr/lib/python3.8/multiprocessing/queues.py", line 116, in get
    return _ForkingPickler.loads(res)
  File "/usr/local/lib/python3.8/dist-packages/torch/multiprocessing/reductions.py", line 496, in rebuild_storage_fd
    fd = df.detach()
  File "/usr/lib/python3.8/multiprocessing/resource_sharer.py", line 57, in detach
    with _resource_sharer.get_connection(self._id) as conn:
  File "/usr/lib/python3.8/multiprocessing/resource_sharer.py", line 87, in get_connection
    c = Client(address, authkey=process.current_process().authkey)
  File "/usr/lib/python3.8/multiprocessing/connection.py", line 502, in Client
    c = SocketClient(address)
  File "/usr/lib/python3.8/multiprocessing/connection.py", line 630, in SocketClient
    s.connect(address)
FileNotFoundError: [Errno 2] No such file or directory
^CError in atexit._run_exitfuncs:
Traceback (most recent call last):
  File "/usr/lib/python3.8/multiprocessing/popen_fork.py", line 27, in poll
Traceback (most recent call last):
  File "<string>", line 1, in <module>
  File "/usr/lib/python3.8/multiprocessing/spawn.py", line 116, in spawn_main
    pid, sts = os.waitpid(self.pid, flag)
```

- 解决方法：
  
  docker容器内
  ```bash
  export MESA_GL_VERSION_OVERRIDE=4.3 
  ```
- 参考链接：
  
  <https://github.com/muskie82/MonoGS/issues/5>

---

# 3. 复现
## 3.1 DEMO复现
- 渲染效果：
<div class="container" style="display: flex; justify-content: center;">
    <video controls width="640" height="360">
        <source src="/videos/work-record/MonoGS-demo.mp4" type="video/mp4">
    </video>
</div>
- 测试误差：
            <div class="container">
                <div class="image">
                    <figure>
                         <a data-fancybox="gallery" href="/images/work-record/MonoGS误差.png"  >
              <img src="/images/work-record/MonoGS误差.png" loading="lazy">
          </a>
                        <figcaption>均值轨迹误差</figcaption>
                    </figure>
                </div>
            </div>

## 3.2 本地复现
- 设备
  * 设备型号：Intel realsense D435i
  * 相机类型：深度相机
  * 运行环境：
    (1) GPU：4060Ti
    (2) Docker：cuda-11.6 
    (3) conda：pytorch=1.12.1
- 渲染效果：
<div class="container">
  <div class="image">
        <figure>
              <a data-fancybox="gallery" href="/images/work-record/Peek_MonoGS_camera_1080P.gif"  >
                  <img src="/images/work-record/Peek_MonoGS_camera_1080P.gif" loading="lazy">
              </a>
            <figcaption>均值轨迹误差</figcaption>
        </figure>
    </div>
</div>

# 4. 代码解读
  
- 仓设置为public，其中comment分支更新到2025/03/26，有需要可查阅 ---> [链接: 李佳潞-MonoGS-代码注释](https://github.com/heirenlop/MonoGS-with-comment/compare/comment)


# *论文部分*
  todo
## 5. 前置内容
### 5.1 相机内参矩阵(K)
- fx 和 fy：分别是相机在 x 和 y 方向上的焦距（单位通常是像素）。
- cx 和 cy：分别是图像的主点坐标，通常是图像的中心点，表示相机坐标系的原点在图像中的位置。
- 内参矩阵如下：
```python
[ fx  0   cx ]
[  0  fy   cy ]
[  0   0    1 ]
```