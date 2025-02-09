ARG BASE_IMAGE=vbatts
ARG BASE_VERSION=15.0
FROM ${BASE_IMAGE}:${BASE_VERSION} AS builder

RUN echo 'y' | slackpkg update
RUN echo 'y' | slackpkg install \
ar \
argon2 \
autoconf \
autoconf-archive \
automake \
binutils \
brotli \
c-ares \
ca-certificates \
cmake \
cryptsetup \
curl \
cyrus-sasl \
dcron \
elfutils \
eudev \
flex \
g++ \
gc \
gcc \
glibc \
guile \
infozip \
jansson \
json-c  \
kernel-headers \
keyutils \
libarchive \
libffi \
libgcrypt \
libgpg-error \
libidn2 \
libnsl \
libssh \
libssh2 \
libunistring \
libxml2 \
libxslt \
linuxdoc-tools \
lvm2 \
lz4 \
lzip \
lzlib \
m4 \
make \
meson \
nghttp2 \
ninja \
openldap \
openssh \
openssl \
pkg-config \
pkg-tools \
popt \
python3 \
socat \
udisks2 \
zlib \
zstd

# Install alien's binary package of jq
ARG BASE_VERSION
COPY src/${BASE_VERSION}/jq-* /root/build/
WORKDIR /root/build/
ENV PKG=jq-1.7.1-x86_64-1alien.txz
RUN md5sum -c "${PKG}.md5" && installpkg "${PKG}" && jq --version