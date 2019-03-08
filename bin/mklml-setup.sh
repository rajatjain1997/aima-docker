#!/bin/sh

mkdir /usr/local/mklml && \
wget https://github.com/01org/mkl-dnn/releases/download/v0.14/mklml_lnx_2018.0.3.20180406.tgz && \
tar -xzf mklml_lnx_2018.0.3.20180406.tgz -C /usr/local/mklml && \
rm -rf /mklml_lnx_2018.0.3.20180406.tgz && \
wget --no-verbose -O - https://github.com/01org/mkl-dnn/archive/v0.14.tar.gz | tar -xzf - && \
cd mkl-dnn-0.14 && \
ln -s /usr/local external && \
mkdir -p build && \
cd build && \
cmake .. && \
make && \
make install && \
cd ../.. && \
rm -rf mkl-dnn-0.14