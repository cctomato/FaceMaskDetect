# FaceMaskDetect
基于yolov5的人脸口罩检测
Face mask detect based on yolov5

## 介绍 - Introduction
我们基于docker部署pytorch的训练和运行环境，借助yolov5检测算法实现人脸口罩的检测，并通过nvidia-cuda技术进行加速。

## 用法 - Usage
我是在Ubuntu 20x系统上使用
### 1 安装nvidia驱动

在ubuntn上只需要执行以下命令就可以自动安装N卡驱动
```bash
ubuntu-drivers autoinstall
```
安装完成后重启系统，并输入以下命令验证驱动是否安装成功
```bash
nvidia-smi
```
驱动安装成功后就可以看到显卡相关信息

![image](https://github.com/cctomato/FaceMaskDetect/blob/main/detect/inference/images/nvidia-smi.png)

### 2 安装docker
按顺序执行以下命令即可在Ubuntu上完成docker的安装
```bash
apt-get update
apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install docker-ce
```
### 3 安装nvidia-docker
按顺序执行以下命令即可在Ubuntu上完成nvidia-docker的安装
```bash
curl -sL https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -sL https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update
sudo apt-get install nvidia-docker2
```
安装完成后使用vim编辑/etc/docker/daemon.json文件添加default-runtime设置为nvidia
```
"default-runtime":"nvidia",
```
重启docker服务
```
systemctl daemon-reload
systemctl restart docker
```
### 4 构建pytorch环境
clone仓库中的代码，使用终端进入FaceMaskDetect目录，然后通过docker build命令构建pytorch环境镜像
```
docker build -t detect/pytorch:nvidia-cuda .
```
完成后通过docker images命令查看detect/pytorch:nvidia-cuda镜像

### 5 实现人脸口罩的检测

## License - MIT
