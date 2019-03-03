FROM ubuntu:16.04

RUN apt-get update
RUN apt-get -y install vim tree curl wget git sudo tar bzip2
RUN apt-get install -qqy x11-apps

RUN echo "root:aima" | chpasswd
RUN groupadd -g 999 grp && \
    useradd -r -u 999 -g grp usr
RUN mkdir /home/usr
RUN cp /root/.bashrc /home/usr

WORKDIR /home/usr    

RUN chown -R usr /home/usr

USER usr:grp
RUN wget "https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh" -O /tmp/miniconda.sh
RUN bash /tmp/miniconda.sh -b
RUN rm -f /tmp/miniconda.sh
RUN echo "PATH=$PATH:/home/usr/miniconda/bin" >> /home/usr/.bashrc

USER root
COPY . /home/usr/
RUN for env in /home/usr/envs/*; do /home/usr/miniconda3/bin/conda env create -f $env; done

ENV TERM=xterm-256color

CMD ["/bin/bash"]