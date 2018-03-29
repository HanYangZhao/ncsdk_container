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
RUN useradd -c "Movidius User" -m movidius
COPY 10-installer /etc/sudoers.d/
RUN mkdir -p /etc/udev/rules.d/
USER movidius
WORKDIR /home/movidius
RUN git clone https://github.com/HanYangZhao/ncsdk
WORKDIR /home/movidius/ncsdk
RUN make install
RUN make opencv
RUN sudo cp 97-usbboot.rules /etc/udev/rules.d/
RUN sudo udevadm control --reload-rules
RUN sudo udevadm trigger
