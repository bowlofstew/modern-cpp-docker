FROM ubuntu:14.04.2
MAINTAINER Stewart Henderson<henderson.geoffrey@gmail.com>
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get -y update
RUN apt-get -y install git
RUN apt-get -y install cmake ninja-build scons
RUN apt-get -y install g++-4.9 clang-3.4