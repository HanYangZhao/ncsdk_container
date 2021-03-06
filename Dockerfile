FROM ubuntu:16.04

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
      build-essential \
      git \
      lsb-release \
      sudo \
      udev \
      usbutils \
      wget \
    && apt-get clean all
#RUN useradd -c "Movidius User" -m movidius
COPY 10-installer /etc/sudoers.d/
RUN mkdir -p /etc/udev/rules.d/
#USER movidius
WORKDIR /root
RUN git clone https://github.com/HanYangZhao/ncsdk.git
WORKDIR /root/ncsdk
RUN make install
RUN sudo udevadm trigger
RUN sudo usermod -a -G users root
RUN make opencv
