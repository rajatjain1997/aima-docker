<div align="center">
  <a href="http://aima.cs.berkeley.edu/"><img src="https://raw.githubusercontent.com/aimacode/aima-python/master/images/aima_logo.png"></a><br><br>
</div>

# `aima-docker` ![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/rajatjain1997/aima-docker.svg)

Welcome to aima-docker! aima-docker is created to help the readers of *Artificial Intelligence: A Modern Approach* to learn and experiment with machine learning frameworks like Tensorflow, CNTK, scikit-learn etc. You can use this in conjunction with a course on AI, or for study on your own. 

## Installation Guide

Before you start, make sure you have [Docker](https://www.docker.com) installed! If you have an nvidia gpu, we recommend you install [Nvidia Docker](https://github.com/NVIDIA/nvidia-docker) as well.

### For Linux Users

The installation process is simple. You need to download the `aima-docker` script and execute it using the following commands.

	wget -q0- "https://raw.githubusercontent.com/rajatjain1997/aima-docker/master/aima-docker"
	chmod +x aima-docker
	sudo ./aima-docker

This should download and set-up the aima-docker repository for you. To check, try opening `http://localhost:8888` in your browser once the setup is complete.

To run aima-docker again, you just need to re-run the `aima-docker` script as follows:

	sudo ./aima-docker

### For developers

To install the development image for aima-docker, clone the repository and run the `aima-docker` script from inside the cloned project.

	git clone https://github.com/rajatjain1997/aima-docker.git
	cd aima-docker
	sudo ./aima-docker

### Additional parameters

The `aima-docker` script automatically detects if you have a valid setup available to run the docker image on GPU. To force it to use a particular tag on docker hub, use:

	sudo ./aima-docker <tag-name>

You can also set the following environment variables before running the script:

Variable Name | Function | Default
--------------|----------|----------
AIMA_HOME | Sets the persistent storage location for the `code` folder in aima-container | $HOME/aimacode
AIMA_REPO | *For Developers:* Points the script to a local aima-docker repository | $PWD
