FROM debian:stretch

LABEL description="Build base container for VTT"

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    pkg-config \
    git \
    tar \
    zip \
    gperf \
    unzip \
    wget \
    bison \
    autoconf \
    automake \
    autotools-dev \
    file \
    libltdl-dev \
    libltdl7 \
    libmagic-mgc \
    libmagic1 \
    libtool \
    libreadline-gplv2-dev\
    libncursesw5-dev \
    libssl-dev \
    libsqlite3-dev \
    tk-dev \
    libgdbm-dev \
    libc6-dev \
    libbz2-dev \
    libffi-dev \
    zlib1g-dev \
    libglfw3 \
    x11-xserver-utils \
    libxrandr-dev \
    libxi-dev \
    libxcursor-dev \
    libxinerama-dev \
    libgles2-mesa-dev \
    --fix-missing \
    && rm -rf /var/lib/apt/lists/*

#
RUN cd \tmp \
    && wget https://www.python.org/ftp/python/3.9.4/Python-3.9.4.tgz \
    && tar xzf Python-3.9.4.tgz \
    && cd Python-3.9.4 \
    && ./configure --enable-optimizations \
    && make install \
    && update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3 9
#RUN pip3 install robotframework Pillow
RUN cd \tmp \
    && git clone https://github.com/Microsoft/vcpkg \ 
    && cd vcpkg \
    && git checkout 7a6855abecfbab6a6b6e6bcb46850b8a32fee814 \
    && ./bootstrap-vcpkg.sh
    
#old not work with debian: && git checkout fefb2c12b66680c6a9b58822624ec60e95abc642 \

COPY .vcpkg_deps.txt /tmp/vcpkg/
RUN /tmp/vcpkg/vcpkg install fribidi[core] \
    && /tmp/vcpkg/vcpkg install libepoxy[core] \
    && /tmp/vcpkg/vcpkg install "@/tmp/vcpkg/.vcpkg_deps.txt" \
    && /tmp/vcpkg/vcpkg integrate install
    && rm -rf /tmp/vcpkg/downloads
    && rm -rf /tmp/vcpkg/buildtrees
