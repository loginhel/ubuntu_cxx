FROM ubuntu:20.04

RUN cp -ra /etc/apt/sources.list /etc/apt/sources.list.bak

#配置apt-get源
RUN echo 'deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse\n\
deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse\n\
deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse\n\
deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse\n\
deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse\n\
deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse\n'\
> /etc/apt/sources.list \
&& apt-get update \
&& apt-get install -y apt-utils \
&& apt-get upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt install -y tzdata

RUN	buildDeps="ninja-build\
			   gcc\
			   g++\
			   make\
			   libtool\
			   cmake\
			   ragel\
			   libhwloc-dev\
			   libnuma-dev\
			   libpciaccess-dev\
			   libcrypto++-dev\
			   libboost-all-dev\
			   libxml2-dev\
			   xfslibs-dev\
			   libgnutls28-dev\
			   liblz4-dev\
			   libsctp-dev\
			   libprotobuf-dev\
			   protobuf-compiler\
			   python3\
			   systemtap-sdt-dev\
			   libyaml-cpp-dev\
			   libc-ares-dev\
			   stow\
			   libfmt-dev\
			   diffutils\
			   valgrind" && \
    apt-get install -f -y ${buildDeps}
	
	
RUN apt-get install -y git vim openssh-server ctags bzip2 texinfo net-tools rsync pkg-config

RUN mkdir /run/sshd

#drogon等
RUN firstDeps="libasio-dev\
			 libevent-dev\
			 libspdlog-dev\
			 libpq-dev\
			 libpqxx-dev\
			 libmysqlclient-dev\
			 libpoco-dev\
			 libsqlite3-dev\
			 libjsoncpp-dev\
			 libssl-dev\
			 libgrpc-dev\
			 libgrpc++-dev\
			 protobuf-compiler-grpc\
			 libbison-dev\
			 libcppunit-dev\
			 libleveldb-dev\
			 libfastjson-dev\
			 libprotoc-dev\
			 libuv1-dev\
			 libnghttp2-dev\
			 libgmock-dev\
			 rapidjson-dev\
			 libsnappy-dev\
			 libbson-dev\
			 libmsgpack-dev\
			 libbenchmark-dev\
			 librestbed-dev\
			 libwebsocketpp-dev\
			 libcds-dev\
			 librabbitmq-dev\
			 librdkafka-dev\
			 libhiredis-dev\
			 libmemcached-dev\
			 libczmq-dev\
			 libdouble-conversion-dev \
			 libgoogle-glog-dev \
			 libgflags-dev \
			 libiberty-dev \
			 liblzma-dev \
			 zlib1g-dev \
			 binutils-dev \
			 libjemalloc-dev \
			 libunwind-dev \
			 libzookeeper-mt-dev \
			 libtinyxml2-dev \
			 libtbb-dev \
			 librocksdb-dev \
			 libopenblas-dev \
			 liblapack-dev \
			 libjson-c-dev \
			 libcurlpp-dev \
			 libjwt-dev \
			 libbz2-dev \
			 libthrift-dev \
			 libmstch-dev \
			 libzstd-dev \
			 libreadline-dev \
			 libgoogle-perftools-dev \
			 libx264-dev \
			 libx265-dev \
			 libde265-dev \
			 libfaac-dev \
			 libflatbuffers-dev \
			 thrift-compiler \
			 rocksdb-tools \
			 flex \
			 python \
			 gperf \
			 zstd \
			 bison\
			 curl\
			 sudo\
			 lsof\
			 nginx\
			 netcat \
			 unzip\
			 lrzsz\
			 zip\
			 lksctp-tools\
			 numactl" && \
    apt-get install -f -y ${firstDeps}

WORKDIR /tmp
RUN git clone https://github.com/vipshop/hiredis-vip.git \
	&& cd hiredis-vip \
	&& make && make install \
	&& rm -rf /tmp/hiredis-vip

RUN sudo ldconfig

# 安装rust环境：curl -sf -L https://static.rust-lang.org/rustup.sh | sh

RUN apt-get install -y \
			libutfcpp-dev \
			nlohmann-json3-dev \
			python3-pip
		
# conan环境
#RUN pip3 install conan

#Nebula安装依赖 folly\fatal\proxygen\wangle\fizz\mvfst\fbthrift
# proxygen直接拉代码到linux可正常编译

# mongodb环境
