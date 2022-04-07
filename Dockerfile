FROM debian:stretch

LABEL description="Build base container for VTT"

RUN apt-get update && apt-get install -y --no-install-recommends \
    at \
    autoconf \
    autoconf-archive \
    automake \
    autotools-dev \
    bison \
    build-essential \
    ca-certificates \
    cifs-utils \
    curl \
    dh-autoreconf \
    file \
    flex \
    gfortran \
    git \
    glew-utils \
    gperf \
    libbison-dev \
    libbz2-dev \
    libc6-dev \
    libffi-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libgdbm-dev \
    libgl1-mesa-dev \
    libgl1-mesa-dev \
    libgles2-mesa-dev \
    libgles2-mesa-dev \
    libglfw3 \
    libglu1-mesa-dev \
    libltdl-dev \
    libltdl7 \
    libmagic-mgc \
    libmagic1 \
    libncurses5-dev \
    libncursesw5-dev \
    libnuma-dev \
    libnuma1 \
    libreadline-gplv2-dev\
    libsqlite3-dev \
    libssl-dev \
    libtool \
    libtool \
    libudev-dev \
    libx11-dev \
    libx11-xcb-dev \
    libxaw7-dev \
    libxcb-glx0-dev \
    libxcb-icccm4-dev \
    libxcb-image0-dev \
    libxcb-keysyms1-dev \
    libxcb-randr0-dev \
    libxcb-render-util0-dev \
    libxcb-shape0-dev \
    libxcb-shm0-dev \
    libxcb-sync-dev \
    libxcb-xfixes0-dev \
    libxcb-xinerama0-dev \
    libxcb-xkb-dev \
    libxcb1-dev \
    libxcursor-dev \
    libxext-dev \
    libxfixes-dev \
    libxi-dev \
    libxinerama-dev \
    libxkbcommon-dev \
    libxkbcommon-x11-dev \
    libxrandr-dev \
    libxt-dev \
    libxxf86vm-dev \
    mesa-common-dev \
    mesa-utils \
    pkg-config \
    python-yaml \
    ruby-full \
    tar \
    tk-dev \
    unzip \
    wget \
    x11-xserver-utils \
    xutils-dev \
    yasm \
    zip \
    zlib1g-dev \
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
RUN /tmp/vcpkg/vcpkg install "@/tmp/vcpkg/.vcpkg_deps.txt" \
    && /tmp/vcpkg/vcpkg integrate install \
    && rm -rf /tmp/vcpkg/downloads \
    && rm -rf /tmp/vcpkg/buildtrees
