FROM ubuntu:20.04
RUN apt-get -y update && apt-get -y upgrade

RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y install libopencv-dev build-essential curl v4l2loopback-utils v4l2loopback-source git cmake
RUN dpkg-reconfigure --frontend noninteractive tzdata
WORKDIR /app
#RUN git clone --recursive --depth=1 https://github.com/floe/backscrub.git
#COPY patch ./backscrub
COPY ./ .
RUN git submodule update --init --recursive && mkdir build && cd build && cmake .. && make -j$(nproc)
ENTRYPOINT [ "/app/build/backscrub" ]

