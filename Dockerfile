FROM nvidia/cuda:11.0-cudnn8-devel-ubuntu18.04

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --allow-insecure-repositories --fix-missing  && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

COPY Anaconda3-5.3.0-Linux-x86_64.sh /anaconda.sh

RUN /bin/bash /anaconda.sh -b -p /opt/conda -u

RUN rm /anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN python -m pip install --upgrade pip -i https://pypi.douban.com/simple

COPY torch-1.7.1+cu110-cp37-cp37m-linux_x86_64.whl /torch-1.7.1+cu110-cp37-cp37m-linux_x86_64.whl

RUN pip install /torch-1.7.1+cu110-cp37-cp37m-linux_x86_64.whl

COPY torchaudio-0.7.2-cp37-cp37m-linux_x86_64.whl /torchaudio-0.7.2-cp37-cp37m-linux_x86_64.whl

RUN pip install /torchaudio-0.7.2-cp37-cp37m-linux_x86_64.whl

COPY torchvision-0.8.2+cu110-cp37-cp37m-linux_x86_64.whl /torchvision-0.8.2+cu110-cp37-cp37m-linux_x86_64.whl

RUN pip install /torchvision-0.8.2+cu110-cp37-cp37m-linux_x86_64.whl

RUN pip install torch==1.7.1+cu110 torchvision==0.8.2+cu110 torchaudio===0.7.2 -f https://download.pytorch.org/whl/torch_stable.html

RUN rm /torch-1.7.1+cu110-cp37-cp37m-linux_x86_64.whl

RUN rm /torchaudio-0.7.2-cp37-cp37m-linux_x86_64.whl

RUN rm /torchvision-0.8.2+cu110-cp37-cp37m-linux_x86_64.whl

RUN pip install -i https://pypi.douban.com/simple opencv-python

RUN pip install -i https://pypi.douban.com/simple flask

RUN pip install -i https://pypi.douban.com/simple tensorboard

RUN pip install -i https://pypi.douban.com/simple --upgrade --ignore-installed PyYaml

RUN apt install -y libgl1-mesa-glx 

RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]
