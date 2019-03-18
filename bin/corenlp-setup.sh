#!/bin/sh

cd /usr/local &&
wget http://nlp.stanford.edu/software/stanford-corenlp-full-2018-10-05.zip -O stanford-corenlp.zip &&
unzip stanford-corenlp.zip &&
rm -rf stanford-corenlp.zip
