FROM centos:7.2.1511

MAINTAINER Tomochika Hara <dockerhub@thara.jp>

# system update
RUN yum -y update && yum clean all

RUN yum groupinstall -y "Development Tools" ; yum clean all
RUN yum install -y curl curl-devel coreutils gcc gcc-c++ gettext openssl-devel perl wget zlib-devel bzip2-devel ; yum clean all

RUN mkdir -p /usr/src/gcc \
  && cd /usr/src/gcc \
  && curl -O http://ftp.tsukuba.wide.ad.jp/software/gcc/releases/gcc-7.1.0/gcc-7.1.0.tar.bz2 \
  && tar xfj gcc-7.1.0.tar.bz2

RUN mkdir -p /usr/src/gmp \
  && cd /usr/src/gmp \
  && wget ftp://ftp.gnu.org/gnu/gmp/gmp-6.1.2.tar.xz \
  && tar xf gmp-6.1.2.tar.xz \
  && mv gmp-6.1.2 /usr/src/gcc/gcc-7.1.0/gmp

RUN mkdir -p /usr/src/mpfr \
  && cd /usr/src/mpfr \
  && wget https://ftp.gnu.org/gnu/mpfr/mpfr-3.1.5.tar.xz \
  && tar xf mpfr-3.1.5.tar.xz \
  && mv mpfr-3.1.5 /usr/src/gcc/gcc-7.1.0/mpfr

RUN mkdir -p /usr/src/mpc \
  && cd /usr/src/mpc \
  && wget ftp://ftp.gnu.org/gnu/mpc/mpc-1.0.3.tar.gz \
  && tar xf mpc-1.0.3.tar.gz \
  && mv mpc-1.0.3 /usr/src/gcc/gcc-7.1.0/mpc

RUN cd /usr/src/gcc/gcc-7.1.0 \
  && ./configure --disable-bootstrap --disable-multilib -enable-languages=c,c++ \
  && make -j 2 \
  && make install

