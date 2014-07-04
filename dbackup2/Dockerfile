# A docker file to deploy the dbackup2 package environment
# For more information, go to visit: http://github.com/chenjianlong/my-docker

FROM ubuntu:14.04

MAINTAINER "Jianlong Chen <jianlong99@gmail.com>"

# Update package repository
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe multiverse" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

# Required packages
RUN apt-get install -y vim zip wget curl git build-essential lua5.2 dpkg-dev

# build depends package
RUN apt-get install -y {libblkid,libparted0,libgtest,liburiparser,zlib1g,libboost1.55,libssl}-dev
RUN apt-get install -y pkg-config debhelper
# yajl depends
RUN apt-get install -y doxygen quilt cmake


# bashrc
RUN cp -f /root/.bashrc /.bashrc

# prepare workspace
RUN mkdir -p /workspace
RUN mkdir -p /workspace/src
RUN mkdir -p /workspace/bin
RUN mkdir -p /workspace/pkg

# vim configure
RUN cd /workspace/src && git clone git://github.com/chenjianlong/my-vim
RUN cd /workspace/src/my-vim && ./my_vim.sh

# misc
WORKDIR /workspace

# Removed unnecessary packages
RUN apt-get autoremove -y

# Clear package repository cache
RUN apt-get clean all
