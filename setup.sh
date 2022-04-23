#!/bin/bash

apt-get dist-upgrade -y -qq && apt-get upgrade -y -qq && apt-get update -y -qq
ln -snf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime && echo Asia/Kolkata > /etc/timezone
apt-get install --no-install-recommends -y -qq aria2 bc bison ca-certificates cpio curl file gcc git lib{c6,c,ssl,xml2}-dev make python2 unzip zip
apt-get autoremove -y && apt-get clean autoclean && rm -rf /var/lib/apt/lists/*
curl -L https://github.com/AkihiroSuda/clone3-workaround/releases/download/v1.0.0/clone3-workaround.x86_64 -o noclone3 && chmod +x noclone3

t2h() {
    echo "$1" | od -An -tx1 | tr -d '\n' | head -n1 | sed "s/ 0a$//g;s/ /\\\x/g"
}

rep() {
    LANG=C grep -robUaPHn "$(t2h '$1')" -l | while read -r f; do
        echo "${f}:${1}->${2}" && sed -i "s|$(t2h "$1")|$(t2h "$2")|g" "$f"
    done
}

rem() {
    cd /usr/"$1" && while read -r line; do rm -rfv "$line"; done < "/remove-$(echo "$1" | sed "s/32//g;s/64//g").txt" && cd /
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

gitlab ElectroPerf/atom-x-clang atom-15 clang

cd /usr/clang && rep 'github.com/llvm/llvm-project' 'youtu.be/watch?v=dQw4w9WgXcQ' && cd /

chmod +x strip.sh && /strip.sh / && rm -rfv strip.sh ./*.txt