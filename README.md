<div align="center">
  <a href="http://aima.cs.berkeley.edu/"><img src="https://raw.githubusercontent.com/aimacode/aima-python/master/images/aima_logo.png"></a><br><br>
</div>

# `aima-docker` 
<!-- [![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/rajatjain1997/aima-docker.svg)](https://hub.docker.com/r/rajatjain1997/aima-docker) -->

Welcome to aima-docker! aima-docker is created to help the readers of *Artificial Intelligence: A Modern Approach* to learn and experiment with machine learning frameworks like Tensorflow, CNTK, scikit-learn etc. You can use this in conjunction with a course on AI, or for study on your own. 

## Installation Guide

Before you start, make sure you have [Docker](https://www.docker.com) installed! If you have an nvidia gpu, we recommend you install [Nvidia Docker](https://github.com/NVIDIA/nvidia-docker) as well.

### For Linux/MacOS Users

The installation process is simple. You need to download the `aima-docker` script and execute it using the following commands.

	wget -q0- "https://raw.githubusercontent.com/rajatjain1997/aima-docker/master/aima-docker"
	chmod +x aima-docker
	sudo ./aima-docker

This should download and set-up the aima-docker repository for you. To check, try opening `http://localhost:8888` in your browser once the setup is complete.

To run aima-docker again, you just need to re-run the `aima-docker` script as follows:

	sudo ./aima-docker

### For Windows Users

After you install Docker for Windows, make sure you allow containers access to the disk drive that you want aima-docker to store code files on. To run aima-docker, make sure that docker service is running and run the following command in Windows Powershell:

	docker run -itd --rm -p 8888:8888 -v <PATH_TO_CODE_FOLDER>:/home/usr/code rajatjain1997/aima-docker:cpu
	
Can be executed without -v paremeter
	
	docker run -itd --rm -p 8888:8888 rajatjain1997/aima-docker:cpu


**Note:** Since nvidia-docker does not support MacOS and Windows, only Linux users will be able to lerverage their GPUs.

### For developers

To install the development image for aima-docker, clone the repository and run the `aima-docker` script from inside the cloned project.

	git clone https://github.com/rajatjain1997/aima-docker.git
	cd aima-docker
	chmod +x aima-docker
	sudo ./aima-docker

**Note:** Linux is recommended for developers since *aima-docker* script binds container network to the host's network. This docker feature is not available on MacOS or Windows.

### Additional parameters

The `aima-docker` script automatically detects if you have a valid setup available to run the docker image on GPU. To force it to use a particular tag on docker hub, use:

	sudo ./aima-docker <tag-name>

You can also set the following environment variables before running the script:

Variable Name | Function | Default
--------------|----------|----------
AIMA_HOME | Sets the persistent storage location for the `code` folder in aima-container | $HOME/aimacode
AIMA_REPO | *For Developers:* Points the script to a local aima-docker repository | $PWD
