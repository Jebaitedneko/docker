#!/bin/bash

apt-get dist-upgrade -y -qq && apt-get upgrade -y -qq && apt-get update -y -qq
ln -snf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime && echo Asia/Kolkata > /etc/timezone
apt-get install --no-install-recommends -y -qq aria2 bc bison ca-certificates cpio curl file gcc git lib{c6,c,ssl,xml2}-dev make python2 unzip zip
apt-get install --no-install-recommends -y -qq gcc-10-{{aarch64-linux-gnu,arm-linux-gnueabi}{,-base},cross-base,multilib-arm-linux-gnueabi} cpp-10-{aarch64-linux-gnu,arm-linux-gnueabi} linux-libc-dev-{arm64,armel,armhf}-cross binutils-{aarch64-linux-gnu,arm-linux-gnueabi} lib{{asan6,atomic1,c6,c6-dev,gcc-10-dev,gomp1,ubsan1,stdc++6,gcc-s1}-{arm64,armel}-cross,{itm1,lsan0,tsan0}-arm64-cross} libc6{,-dev}-armhf{,-armel}-cross libhf{asan6,atomic1,gcc-10-dev,gcc-s1,gomp1,stdc++6,ubsan1}-armel-cross
find /usr/bin | grep -E "aarch64-linux-gnu-.*-10|arm-linux-gnueabi-.*-10" | while read -r f; do ln -svf "$(realpath "${f}")" "${f/-10/}"; done
dpkg --remove --force-depends cpp-10-{aarch64-linux-gnu,arm-linux-gnueabi} lib{,hf}stdc++6-{arm64,armel}-cross
apt-get autoremove -y && apt-get clean autoclean && rm -rf /var/lib/apt/lists/*

t2h() {
    echo "$1" | od -An -tx1 | tr -d '\n' | head -n1 | sed "s/ 0a$//g;s/ /\\\x/g"
}

rep() {
    LANG=C grep -robUaPHn "$(t2h '$1')" -l | while read -r f; do
        echo "${f}:${1}->${2}" && sed -i "s|$(t2h "$1")|$(t2h "$2")|g" "$f"
    done
}

rem() {
    cd /usr/"$1" && while read -r line; do rm -rfv $line; done < "/remove-$(echo "$1" | sed "s/32//g;s/64//g").txt" && cd /
}

set_cmn() {
    unzip "$3".zip -d. && rm "$3".zip && mv -v "${1##*/}-$2" "/usr/${3}"
    find "/usr/${3}" -exec chmod +x {} \; && rem "$3"
}

github() {
    curl -LSs  "https://codeload.github.com/$1/zip/$2" -o "$3".zip
    set_cmn "$1" "$2" "$3"
}

gitlab() {
    curl -LSs  "https://gitlab.com/$1/-/archive/$2/${1##*/}-$2.zip" -o "$3".zip
    set_cmn "$1" "$2" "$3"
}

chmod +x strip.sh && /strip.sh / && rm -rfv strip.sh ./*.txt