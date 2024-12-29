FROM ubuntu:noble

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update

RUN apt -y install gcc g++ git cmake ninja-build lsb-release libsdl2-dev \
libpng-dev libsdl2-net-dev libzip-dev zipcmp zipmerge ziptool \
 nlohmann-json3-dev libtinyxml2-dev libspdlog-dev libboost-dev libopengl-dev

CMD ["bash"]
