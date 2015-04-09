# -----------------------------------------------------------------------------
# docker-mythtv
#
# Builds a basic docker image for running a mythtv backend
#
# Authors: Brian Eilber 
# Updated: Mar 23rd, 2015
# Require: Docker (http://www.docker.io/)
# -----------------------------------------------------------------------------
FROM   ubuntu:14.04

ENV    DEBIAN_FRONTEND noninteractive

RUN echo 'deb http://archive.ubuntu.com/ubuntu/ trusty main' | tee /etc/apt/sources.list
RUN echo 'deb-src http://archive.ubuntu.com/ubuntu/ trusty main' | tee -a /etc/apt/sources.list
RUN echo 'deb http://archive.ubuntu.com/ubuntu/ trusty-updates main' | tee -a /etc/apt/sources.list
RUN echo 'deb-src http://archive.ubuntu.com/ubuntu/ trusty-updates main' | tee -a /etc/apt/sources.list
RUN echo 'deb http://archive.ubuntu.com/ubuntu/ trusty universe' | tee -a /etc/apt/sources.list
RUN echo 'deb-src http://archive.ubuntu.com/ubuntu/ trusty universe' | tee -a /etc/apt/sources.list
RUN echo 'deb http://archive.ubuntu.com/ubuntu/ trusty-updates universe' | tee -a /etc/apt/sources.list
RUN echo 'deb-src http://archive.ubuntu.com/ubuntu/ trusty-updates universe' | tee -a /etc/apt/sources.list
RUN echo 'deb http://archive.ubuntu.com/ubuntu/ trusty multiverse' | tee -a /etc/apt/sources.list
RUN echo 'deb-src http://archive.ubuntu.com/ubuntu/ trusty multiverse' | tee -a /etc/apt/sources.list
RUN echo 'deb http://archive.ubuntu.com/ubuntu/ trusty-updates multiverse' | tee -a /etc/apt/sources.list
RUN echo 'deb-src http://archive.ubuntu.com/ubuntu/ trusty-updates multiverse' | tee -a /etc/apt/sources.list

RUN apt-get update &&\
    apt-get upgrade -y -q &&\
    apt-get -y -q autoclean &&\
    apt-get -y -q autoremove

RUN apt-get --yes install software-properties-common &&\
    apt-get install --force-yes -y -q mythtv-backend xz-utils file locales dbus-x11 \
    fonts-dejavu fonts-liberation hicolor-icon-theme libgl1-mesa-glx libgl1-mesa-dri &&\
    ln -sf /usr/share/zoneinfo/UTC /etc/localtime &&\
    apt-get clean



# Locales

RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

RUN dpkg-reconfigure locales

ADD ./scripts/start /start

RUN chmod +x /start

EXPOSE 6543
EXPOSE 6544

VOLUME ["/data"]

CMD    ["/start"]
