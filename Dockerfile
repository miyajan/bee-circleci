FROM ubuntu:16.04

RUN apt-get update && apt-get install --no-install-recommends -y \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        fakeroot \
        language-pack-ja \
        openjdk-8-jdk \
        perl \
        python \
        python-dev \
        python-pip \
        python-setuptools \
        zip

# Japanese Environment
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8

# Java
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# node.js
ENV NODEBREW_ROOT /usr/local/nodebrew
RUN curl -L git.io/nodebrew | perl - setup
ENV PATH ${NODEBREW_ROOT}/current/bin:${PATH}
RUN nodebrew install-binary v6.11.1
RUN nodebrew use v6.11.1

# awscli
RUN pip install awscli

# fonts
RUN apt-get update && apt-get install --no-install-recommends -y fonts-migmix

# python3
RUN apt-get update && apt-get install --no-install-recommends -y python3

