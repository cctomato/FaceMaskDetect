# FaceMaskDetect
Face mask detection based on yolov5 

## Introduction
Based on the training and running environment of docker deploying pytorch, the face mask detection is realized with the help of yolov5 detection algorithm, and accelerated by NVIDIA CUDA technology.

## Usage
Enviroment：Ubuntu 20x

### 1 Install nvidia driver
On Ubuntu, you only need to execute the following command to install the n-card driver automatically.
```bash
$ ubuntu-drivers autoinstall
```
After the installation, restart the system and enter the following command to verify whether the driver is installed successfully.
```bash
$ nvidia-smi
```
After the driver is installed successfully, you can see the relevant information of the graphics card.  
![image](https://github.com/cctomato/FaceMaskDetect/blob/main/detect/inference/images/nvidia-smi.png)

### 2 Install docker
Execute the following commands in order to complete the installation of docker on Ubuntu.
```bash
$ apt-get update
$ apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
$ curl -fsSL https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
$ add-apt-repository "deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
$ apt-get update
$ apt-get install docker-ce
```
### 3 Install nvidia-docker
Execute the following commands in order to complete the installation of nvidia-docker on Ubuntu.
```bash
$ curl -sL https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
$ distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
$ curl -sL https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
$ sudo apt-get update
$ sudo apt-get install nvidia-docker2
```
After installation, use VIM to edit /etc/docker/daemon.json File add default-runtime set to NVIDIA。
```
"default-runtime":"nvidia",
```
Restart docker service
```
$ systemctl daemon-reload
$ systemctl restart docker
```
### 4 Building a pytorch environment
Clone repository, and then download it  
[torch-1.7.1+cu110-cp37-cp37m-linux_x86_64.whl](https://download.pytorch.org/whl/torch_stable.html)  
[torchaudio-0.7.2-cp37-cp37m-linux_x86_64.whl](https://download.pytorch.org/whl/torch_stable.html)  
[torchvision-0.8.2+cu110-cp37-cp37m-linux_x86_64.whl](https://download.pytorch.org/whl/torch_stable.html)  
[Anaconda3-5.3.0-Linux-x86_64.sh](https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/)  
These four files are placed in the root directory of the project to speed up the construction of the environment.  
Please be sure to download files with the same version number, Or use what I sort out[BaiDuYunCode:ac6n](https://pan.baidu.com/s/1q9aKKZgFOK3IJCkF3Cn0dA)  
The file list is shown in the figure below：  
![image](https://github.com/cctomato/FaceMaskDetect/blob/main/detect/inference/images/file.png)  
After completing the preparation of all the required files, use the terminal to enter the facemaskdetect directory, and then build the python environment image through the docker build command.
```
$ docker build -t detect/pytorch:nvidia-cuda .
```
After completion, check the detect/pytorch:nvidia-cuda by docker images.

### 5 Realization of face mask detection
Run the pytorch container and map the detect directory in the project to the container，Put all the pictures that need to be detected in the directory【detect】-【inference】-【images】.
```
$ docker run -it -v /home/showye/FaceMaskDetect/detect/:/home/showye/FaceMaskDetect/detect/ detect/pytorch:nvidia-cuda /bin/bash
```
After the container is successfully started, it will automatically enter the bash terminal of the container，Enter the /home/showye/FaceMaskDetect/detect directory through cd, and then execute the following command to complete the face mask detection。
```
$ python detect.py
```
After the detection, the image will be generated in the directory of 【detect】-【inference】-【output】.

### 6 Test effect demonstration
![image](https://github.com/cctomato/FaceMaskDetect/blob/main/detect/inference/output/1.jpg)  
![image](https://github.com/cctomato/FaceMaskDetect/blob/main/detect/inference/output/2.jpg)

## License
MIT
