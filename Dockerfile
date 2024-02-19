FROM ubuntu:22.04

LABEL maintainer="wmhudson@iastate.edu"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y python3.10 python3-pip make qemu-user gcc-arm-linux-gnueabihf binutils-arm-linux-gnueabihf binutils-arm-linux-gnueabihf-dbg

RUN ln -sf /usr/bin/python3.10 /usr/bin/python3

COPY requirements.txt /requirements.txt
RUN pip3 install --no-cache-dir -r /requirements.txt

ENV LANG=en_US.UTF-8
ENV LC_LANG=en_US.UTF-8

ENV PYTHONIOENCODING=UTF-8
ENV PYTHONPATH=/armgrader/:/grade/serverFilesCourse

RUN groupadd sbuser
RUN useradd -g sbuser sbuser

COPY armgrader /armgrader


