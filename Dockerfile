FROM ubuntu:20.04

RUN apt-get update && apt-get -y install wget && wget https://apt.kitware.com/kitware-archive.sh && bash kitware-archive.sh
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install --no-install-recommends git cmake ninja-build gperf ccache dfu-util device-tree-compiler wget python3-dev python3-pip python3-setuptools python3-tk python3-wheel xz-utils file make gcc gcc-multilib g++-multilib libsdl2-dev

RUN pip3 install west

RUN mkdir ncs
WORKDIR /ncs
RUN west init -m https://github.com/nrfconnect/sdk-nrf --mr v1.9.1 && west update && west zephyr-export
RUN pip3 install -r zephyr/scripts/requirements.txt && pip3 install -r nrf/scripts/requirements.txt && pip3 install -r bootloader/mcuboot/scripts/requirements.txt
SHELL ["/bin/bash", "-c"]
RUN source zephyr/zephyr-env.sh
