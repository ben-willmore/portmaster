FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y --no-install-recommends \
        sudo whiptail ca-certificates apt-utils

RUN apt install -y --no-install-recommends \
        build-essential cmake nano git wget

# To install all SDL dependencies, see:
# https://github.com/libsdl-org/SDL/blob/main/docs/README-linux.md
# it should be safe to install extra dependencies, only those available
# will by dynamically loaded on target system
RUN apt install -y build-essential git make \
pkg-config cmake ninja-build gnome-desktop-testing libasound2-dev libpulse-dev \
libaudio-dev libjack-dev libsndio-dev libx11-dev libxext-dev \
libxrandr-dev libxcursor-dev libxfixes-dev libxi-dev libxss-dev \
libxkbcommon-dev libdrm-dev libgbm-dev libgl1-mesa-dev libgles2-mesa-dev \
libegl1-mesa-dev libdbus-1-dev libibus-1.0-dev libudev-dev fcitx-libs-dev

# newer version of gcc
RUN apt install -y gcc-10 g++-10

RUN apt install -y curl

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y

CMD ["bash"]
