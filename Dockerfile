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
    unzip \
    wget \
    bison \
    python3 \
    python3-pip \
    --fix-missing \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install robotframework Pillow
RUN cd \tmp \
    && git clone https://github.com/Microsoft/vcpkg \ 
    && cd vcpkg \
    && ./bootstrap-vcpkg.sh 
    
#not work with debian && git checkout fefb2c12b66680c6a9b58822624ec60e95abc642 \

COPY .vcpkg_deps.txt /tmp/vcpkg/
RUN /tmp/vcpkg/vcpkg install "@/tmp/vcpkg/.vcpkg_deps.txt" \
    && /tmp/vcpkg/vcpkg integrate install
