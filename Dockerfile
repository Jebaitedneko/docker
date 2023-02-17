FROM ubuntu:devel
COPY ["strip.sh", "setup.sh", "/"]
RUN DEBIAN_FRONTEND=noninteractive chmod +x /setup.sh && /setup.sh && rm /setup.sh