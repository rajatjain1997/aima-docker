FROM ubuntu:16.04

# System Update and pre-requisites
RUN apt-get update && \
    apt-get -y install \
        bzip2 \
        build-essential \
        cmake \
        curl \
        git \
        tar \
        tree \
        wget \
        vim && \
    apt-get install -qqy x11-apps && \
    apt-get install -y \
        openmpi-bin
COPY . /home/usr/
RUN for setup in /home/usr/bin/*; do chmod +x $setup && $setup; done && \
    ldconfig && \
    rm -rf /home/usr/bin

# Non-root user account setup
# root user can still be accessed using `su` with the password `aima`
RUN echo "root:aima" | chpasswd && \
    groupadd -g 999 grp && \
    useradd -r -u 999 -g grp usr && \
    cp /root/.bashrc /home/usr && \
    echo "source /home/usr/.bashprofile" >> /home/usr/.bashrc && \
    chown -R usr /home/usr

# Setup default work directory for the user
WORKDIR /home/usr

# Install miniconda for python virtual env management
USER usr:grp
RUN wget "https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh" \
        -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b && \
    /home/usr/miniconda3/bin/conda update -n base -c defaults conda && \
    /home/usr/miniconda3/bin/conda install nb_conda && \
    rm -f /tmp/miniconda.sh

# Setup python machine learning packages
USER root
RUN for env in /home/usr/envs/*; do /home/usr/miniconda3/bin/conda env create -f $env; done && \
    rm -rf /home/usr/envs

# Download and setup aima-python
USER usr:grp
RUN git clone https://github.com/aimacode/aima-python.git /home/usr/aima-python && \
#    /home/usr/miniconda3/bin/conda install python=3.5.6 Need to wait for conda update to enforce this
    /home/usr/miniconda3/bin/pip install -r /home/usr/aima-python/requirements.txt

# Terminal settings for the container
ENV TERM=xterm-256color

CMD ["/bin/bash", "-c", "/home/usr/miniconda3/bin/jupyter notebook"]