FROM ubuntu:16.04

# System Update and pre-requisites
RUN apt-get update && \
    apt-get install -y \
        bzip2 \
        build-essential \
        cmake \
        curl \
        default-jre \
        git \
        openmpi-bin \
        tar \
        wget \
        zip
        
COPY bin/. /home/usr/bin
RUN for setup in /home/usr/bin/*; do chmod +x $setup && $setup; done && \
    ldconfig && \
    rm -rf /home/usr/bin

# Non-root user account setup
# root user can still be accessed using `su` with the password `aima`
RUN echo "root:aima" | chpasswd && \
    groupadd -g 999 grp && \
    useradd -r -u 999 -g grp usr && \
    cp /root/.bashrc /home/usr && \
    echo "source /home/usr/.bashprofile" >> /home/usr/.bashrc

# Setup default work directory for the user
WORKDIR /home/usr

# Install miniconda for python virtual env management
RUN wget "https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh" \
        -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p /opt/miniconda3 && \
    /opt/miniconda3/bin/conda update -n base -c defaults conda && \
    /opt/miniconda3/bin/conda install nb_conda && \
    chown -R usr /opt/miniconda3 && \
    rm -f /tmp/miniconda.sh

# Download and setup aima-python
RUN git clone https://github.com/aimacode/aima-python.git /home/usr/aima-python && \
#    /opt/miniconda3/bin/conda install python=3.5.6 && \
    /opt/miniconda3/bin/pip install -r /home/usr/aima-python/requirements.txt && \
    (cd aima-python && \
    git submodule init && \
    git submodule update) && \
    rm -rf /home/usr/aima-python/.git

# Repository setup
COPY . /home/usr
RUN ln -s /home/usr/src/docker-introduction.ipynb /home/usr/introduction.ipynb && \
    chown -R usr /home/usr && \
    rm -rf /home/usr/cpu /home/usr/gpu /home/usr/bin

# Setup python machine learning packages
COPY cpu/envs/. /home/usr/envs
RUN for env in /home/usr/envs/*; do /opt/miniconda3/bin/conda env create -f $env; done && \
    rm -rf /home/usr/envs

# Terminal settings for the container
USER usr:grp
ENV TERM=xterm-256color
ENV SHELL=/bin/bash

EXPOSE 8888

CMD ["/bin/bash", "-c", "source /home/usr/.bashprofile && /opt/miniconda3/bin/jupyter notebook --NotebookApp.token='' --NotebookApp.password='' --no-browser --ip=0.0.0.0"]