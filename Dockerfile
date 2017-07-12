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
        unzip \
        wget \
        zip

# Japanese Environment
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8

# Java
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# node.js
ENV NODE_VERSION v6.11.1
ENV NODEBREW_ROOT /usr/local/nodebrew
RUN curl -L git.io/nodebrew | perl - setup
ENV PATH ${NODEBREW_ROOT}/current/bin:${PATH}
RUN nodebrew install-binary ${NODE_VERSION}
RUN nodebrew use ${NODE_VERSION}

# awscli
RUN pip install awscli

# xvfb
RUN apt-get update -qqy \
  && apt-get -qqy install \
    locales \
    xvfb \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*
ENV SCREEN_WIDTH 1360
ENV SCREEN_HEIGHT 1020
ENV SCREEN_DEPTH 24
ENV DISPLAY :99.0

# chrome
ENV CHROME_VERSION google-chrome-stable=59.0.3071.115-1
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qqy \
  && apt-get -qqy install \
    ${CHROME_VERSION:-google-chrome-stable} \
  && rm /etc/apt/sources.list.d/google-chrome.list \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# chromedriver
ENV CHROME_DRIVER_VERSION 2.30
RUN wget --no-verbose -O /tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip \
  && rm -rf /opt/selenium/chromedriver \
  && unzip /tmp/chromedriver_linux64.zip -d /opt/selenium \
  && rm /tmp/chromedriver_linux64.zip \
  && mv /opt/selenium/chromedriver /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION \
  && chmod 755 /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION \
  && ln -fs /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION /usr/bin/chromedriver

