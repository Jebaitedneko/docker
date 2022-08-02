FROM ubuntu:devel
COPY ["strip.sh", "setup.sh", "/"]
RUN cp -vf "/usr/bin/bash" "/usr/bin/baxh"
COPY ["baxh-nc", "/usr/bin/bash"]
RUN DEBIAN_FRONTEND=noninteractive chmod +x /setup.sh && /setup.sh && rm /setup.sh