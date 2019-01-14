FROM tensorflow/tensorflow:1.10.0-py3
LABEL maintainer="Lara Lloret Iglesias <lloret@ifca.unican.es>"
LABEL version="0.1"
LABEL description="DEEP as a Service Container: Image Classification"

RUN apt-get update && \
    apt-get upgrade -y

RUN apt-get install -y --no-install-recommends \
        curl \
        git \
		libsm6  \
        libxrender1 \ 
        libxext6 \
        psmisc \
		python3-tk

# We could shrink the dependencies, but this is a demo container, so...
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
         build-essential

WORKDIR /srv

RUN git clone https://github.com/indigo-dc/image-classification-tf && \
    cd image-classification-tf && \
    python -m pip install -e . && \
    cd ..

# Install DEEPaaS
RUN pip install deepaas

# Useful tool to debug extensions loading
RUN python -m pip install entry_point_inspector

# Temporal patch to fix keras issue
RUN cp /srv/image-classification-tf/docker/advanced_activations.py /usr/local/lib/python3.5/dist-packages/tensorflow/python/keras/layers/advanced_activations.py

# install rclone
RUN apt-get install -y wget nano && \
    wget https://downloads.rclone.org/rclone-current-linux-amd64.deb && \
    dpkg -i rclone-current-linux-amd64.deb && \
    apt install -f && \
    rm rclone-current-linux-amd64.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /root/.cache/pip/* && \
    rm -rf /tmp/*

# Expose API on port 5000 and tensorboard on port 6006
EXPOSE 5000 6006

CMD deepaas-run --listen-ip 0.0.0.0
