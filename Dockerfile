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
    --fix-missing \
    && rm -rf /var/lib/apt/lists/*
	
RUN cd \tmp \
    && git clone https://github.com/Microsoft/vcpkg \ 
    && cd vcpkg \
    && ./bootstrap-vcpkg.sh 

COPY .vcpkg_deps.txt /tmp/vcpkg/
RUN /tmp/vcpkg/vcpkg install "@/tmp/vcpkg/.vcpkg_deps.txt" \
    && /tmp/vcpkg/vcpkg integrate install