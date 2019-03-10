<div align="center">
  <a href="http://aima.cs.berkeley.edu/"><img src="https://raw.githubusercontent.com/aimacode/aima-python/master/images/aima_logo.png"></a><br><br>
</div>

# `aima-docker`

Welcome to aima-docker! You can use this in conjunction with a course on AI, or for study on your own. 

## Installation Guide

Before you start, make sure you have [Docker](www.docker.com) installed!

To pull the image:

	docker pull rajatjain1997/aima-docker

If you want persistent storage, create the folder `~/aimacode`.

	mkdir -p ~/aimacode

To start Jupyter, use the following command:

	docker run -itd --rm --network=host -v $HOME/aimacode:/home/usr/code rajatjain1997/aima-docker

If you're a collaborator, you need to first clone the repository, and then run a *different* docker run command:

	AIMA=<path to aima git repo> && docker run -it --rm --network=host -v $HOME/aimacode:/home/usr/code -v $AIMA/src:/home/usr/src -v $AIMA/images:/home/usr/images rajatjain1997/aima-docker /opt/miniconda3/bin/jupyter notebook --allow-root --no-browser