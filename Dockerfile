FROM ubuntu:devel
COPY ["strip.sh", "setup.sh", "remove-gcc.txt", "remove-clang.txt", "noclone3", "bash-noclone3", "/"]
RUN sed -i "s/\/bin\/bash/\/bash-noclone3/g" /etc/passwd && cat /etc/passwd
RUN su - root
RUN DEBIAN_FRONTEND=noninteractive chmod +x /setup.sh && /setup.sh && rm /setup.sh
ENTRYPOINT ["/bin/su", "-", "root"]