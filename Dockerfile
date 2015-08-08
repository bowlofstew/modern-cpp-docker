FROM ubuntu:14.04.2
MAINTAINER Stewart Henderson<henderson.geoffrey@gmail.com>
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install git
RUN apt-get -y install cmake ninja-build scons
RUN apt-get -y install gcc-4.9 g++-4.9 clang-3.4
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.9
RUN apt-get -y install unzip zip bzip2 libbz2-dev zlib1g-dev
RUN apt-get -y install libicu-dev python-dev texinfo

RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
RUN cd / && git clone https://github.com/google/bazel.git
RUN cd /bazel && ./compile.sh
ENV PATH "$PATH:/bazel/output"
RUN mkdir /downloads
RUN cd downloads \
	&& wget -O boost_1_58_0.tar.gz http://sourceforge.net/projects/boost/files/boost/1.58.0/boost_1_58_0.tar.gz/download \
	&& tar xzvf boost_1_58_0.tar.gz \
	&& cd boost_1_58_0 \
	&& ./bootstrap.sh --prefix=/usr \
	&& ./b2 install --with=all
RUN rm -rf /downloads
