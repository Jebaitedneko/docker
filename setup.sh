#!/bin/bash

apt-get dist-upgrade -y -qq && apt-get upgrade -y -qq && apt-get update -y -qq
ln -snf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime && echo Asia/Kolkata > /etc/timezone
apt-get install --no-install-recommends -y -qq aria2 bc bison ca-certificates cpio curl file gcc git lib{c6,c,ssl,xml2}-dev make python2 unzip zip
apt-get install --no-install-recommends -y -qq gcc-10-{{aarch64-linux-gnu,arm-linux-gnueabi}{,-base},cross-base,multilib-arm-linux-gnueabi} cpp-10-{aarch64-linux-gnu,arm-linux-gnueabi} linux-libc-dev-{arm64,armel,armhf}-cross binutils-{aarch64-linux-gnu,arm-linux-gnueabi} lib{{asan6,atomic1,c6,c6-dev,gcc-10-dev,gomp1,ubsan1,stdc++6,gcc-s1}-{arm64,armel}-cross,{itm1,lsan0,tsan0}-arm64-cross} libc6{,-dev}-armhf{,-armel}-cross libhf{asan6,atomic1,gcc-10-dev,gcc-s1,gomp1,stdc++6,ubsan1}-armel-cross
find /usr/bin | grep -E "aarch64-linux-gnu-.*-10|arm-linux-gnueabi-.*-10" | while read -r f; do ln -svf "$(realpath "${f}")" "${f/-10/}"; done
apt-get autoremove -y && apt-get clean autoclean && rm -rf /var/lib/apt/lists/*
chmod +x strip.sh && /strip.sh / && rm -rfv strip.sh ./*.txt