FROM ubuntu:latest
COPY ["strip.sh", "setup.sh", "remove-gcc.txt", "remove-clang.txt", "/"]
RUN DEBIAN_FRONTEND=noninteractive chmod +x /setup.sh && /setup.sh && rm /setup.sh