FROM ubuntu:16.04

RUN apt-get update && apt-get install --no-install-recommends -y \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        fakeroot \
        openjdk-8-jdk \
        perl \
        python \
        python-dev \
        python-pip \
        python-setuptools \
        zip

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# node.js
ENV NODEBREW_ROOT /usr/local/nodebrew
RUN curl -L git.io/nodebrew | perl - setup
ENV PATH ${NODEBREW_ROOT}/current/bin:${PATH}
RUN nodebrew install-binary v6.10.3
RUN nodebrew use v6.10.3

# awscli
RUN pip install awscli

