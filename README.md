# FaceMaskDetect
基于yolov5的人脸口罩检测
Face mask detect based on yolov5

## 介绍 - Introduction
我们基于docker部署pytorch的训练和运行环境，借助yolov5检测算法实现人脸口罩的检测，并通过nvidia-cuda技术进行加速。

## 用法 - Usage

### 1 安装nvidia驱动

在ubuntn上只需要执行以下命令就会自动安装N卡驱动
```bash
ubuntu-drivers autoinstall
```
安装完成后重启系统，并输入以下命令验证驱动是否安装成功
```bash
nvidia-smi
```
驱动安装成功后就可以看到显卡相关信息
<img src="https://github.com/cctomato/FaceMaskDetect/blob/main/detect/inference/images/nvidia-smi.png">
### 2 安装docker

### 3 安装nvidia-docker

### 4 构建pytorch环境

### 5 实现人脸口罩的检测

## License - MIT
