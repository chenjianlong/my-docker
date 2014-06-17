# A docker file to deploy the latest stable version of golang 1.2
# For more information, go to visit: http://github.com/chenjianlong/my-docker

FROM ubuntu:14.04

MAINTAINER "Jianlong Chen"

# Update package repository
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe multiverse" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

# Required packages
RUN apt-get install -y vim zip wget curl git mercurial build-essential

# bashrc
RUN cp -f /root/.bashrc /.bashrc

# prepare golang workspace
RUN mkdir -p /workspace
RUN mkdir -p /workspace/src
RUN mkdir -p /workspace/bin
RUN mkdir -p /workspace/pkg

#create the go directory
RUN mkdir -p /usr/local/go
RUN cd /usr/local/go

RUN hg clone https://code.google.com/p/go -r release-branch.go1.2 /usr/local/go
RUN cd /usr/local/go/src && bash -c './all.bash'

# env
ENV PATH /usr/local/go/bin:/workspace/bin:$PATH
ENV GOROOT /usr/local/go
ENV GOPATH /workspace
ENV GOBIN /workspace/bin
ENV GOARM 5

# golang crosscompile
RUN cd /
RUN git clone git://github.com/davecheney/golang-crosscompile.git
RUN bash -c 'source golang-crosscompile/crosscompile.bash && go-crosscompile-build-all'

# bashrc
RUN echo "source /golang-crosscompile/crosscompile.bash" >> /root/.bashrc
RUN cp -f /root/.bashrc /.bashrc

# misc
WORKDIR /workspace

# Removed unnecessary packages
RUN apt-get autoremove -y

# Clear package repository cache
RUN apt-get clean all
