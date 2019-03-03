FROM ubuntu:16.04

# System Update
RUN apt-get update
RUN apt-get -y install vim tree curl wget git sudo tar bzip2
RUN apt-get install -qqy x11-apps

# Non-root user account setup
# root user can still be accessed using `su` with the password `aima`
RUN echo "root:aima" | chpasswd
RUN groupadd -g 999 grp && \
    useradd -r -u 999 -g grp usr
RUN mkdir /home/usr
RUN cp /root/.bashrc /home/usr
RUN echo "source /home/usr/.bashprofile" >> /home/usr/.bashrc

# Setup default work directory for the user
WORKDIR /home/usr
RUN chown -R usr /home/usr

# Install miniconda for python virtual env management
USER usr:grp
RUN wget "https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh" -O /tmp/miniconda.sh
RUN bash /tmp/miniconda.sh -b
RUN rm -f /tmp/miniconda.sh
RUN echo "PATH=$PATH:/home/usr/miniconda3/bin" >> /home/usr/.bashrc
COPY . /home/usr/

# Setup python machine learning packages
USER root
RUN for env in /home/usr/envs/*; do /home/usr/miniconda3/bin/conda env create -f $env; done
RUN rm -rf /home/usr/envs

# Download aima repositories
USER usr:grp
RUN git clone https://github.com/aimacode/aima-python.git /home/usr/aima-python

# Terminal settings for the container
ENV TERM=xterm-256color

CMD ["/bin/bash"]