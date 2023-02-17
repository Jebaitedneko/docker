#!/bin/bash
apt-get update -yqq
apt-get install --install-recommends -yqq make bc bison flex cpio ca-certificates curl python{2,3} zip libarchive-tools git gcc{,-12-{arm-linux-gnueabi,aarch64-linux-gnu}} lib{c6,c,ssl,xml2,mpc}-dev lib{debuginfod-common,debuginfod1} file findutils ccache
find /usr/bin | grep -E "aarch64-linux-gnu-.*-12|arm-linux-gnueabi-.*-12" | while read -r f; do ln -svf "$(realpath "${f}")" "${f/-12/}"; done
git clone --depth=1 --single-branch https://github.com/cyberknight777/gcc-arm64 ~/.local/gcc64
git clone --depth=1 --single-branch https://github.com/cyberknight777/gcc-arm ~/.local/gcc32
chmod +x strip.sh && /strip.sh / && rm -rfv strip.sh