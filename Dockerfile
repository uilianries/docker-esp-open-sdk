# Install esp-open-sdk

FROM ubuntu
MAINTAINER Uilian Ries <uilianries@gmail.com>

RUN apt-get update
RUN apt-get install -y make wget unrar-free autoconf automake libtool gcc g++ gperf flex bison texinfo gawk ncurses-dev libexpat1-dev python sed python-serial srecord bc git help2man unzip python-serial bzip2 libtool-bin python-dev

RUN groupadd docker
RUN useradd -c 'Docker user' -m -d /home/docker -s /bin/bash docker -g docker
RUN adduser docker sudo

RUN mkdir -p /home/docker/dev
RUN git clone --recursive https://github.com/pfalcon/esp-open-sdk.git /home/docker/dev/esp-open-sdk

RUN chown -R docker /home/docker/dev
USER docker
WORKDIR /home/docker/dev/esp-open-sdk
RUN make STANDALONE=y

RUN echo 'export ESP_HOME=/home/docker/dev/esp-open-sdk' >> /home/docker/.bashrc
RUN echo 'export PATH=/home/docker/dev/esp-open-sdk/xtensa-lx106-elf/bin:$PATH' >> /home/docker/.bashrc

WORKDIR /home/docker/dev

CMD ["bash"]
