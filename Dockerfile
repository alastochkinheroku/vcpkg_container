FROM ubuntu:latest

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
    --fix-missing \
    && rm -rf /var/lib/apt/lists/*
	
RUN cd \tmp \
    && git clone https://github.com/Microsoft/vcpkg \ 
    && cd vcpkg \
	&& git checkout fefb2c12b66680c6a9b58822624ec60e95abc642 \
    && ./bootstrap-vcpkg.sh 

COPY .vcpkg_deps.txt /tmp/vcpkg/
RUN /tmp/vcpkg/vcpkg install "@/tmp/vcpkg/.vcpkg_deps.txt" \
    && /tmp/vcpkg/vcpkg integrate install