# Copyright (c) 2018 Serguei Kalentchouk. All rights reserved.
# Use of this source code is governed by an MIT license that can be found in the LICENSE file.
FROM centos:7

# Install basic build depedencies
RUN yum -y install wget
RUN yum -y install make automake gcc gcc-c++
RUN yum -y install libX11-devel
RUN yum -y install git

# Install newer version of cmake
RUN cd /tmp \
    && wget https://cmake.org/files/v3.11/cmake-3.11.3.tar.gz \
    && tar -xvzf cmake-3.11.3.tar.gz \
    && cd cmake-3.11.3 \
    && ./bootstrap --prefix=/usr/local \
    && make && make install

# Install Maya Devkit (2018.2)
# Download link is retrieved from:
# https://www.autodesk.com/developer-network/platform-technologies/maya
RUN cd /tmp \
    && wget https://autodesk.box.com/shared/static/gloudjq6zljbg7br7o35vi82t158qcsd \
    && tar -xvzf gloudjq6zljbg7br7o35vi82t158qcsd \
    && mkdir -p /usr/autodesk/maya2018/ \
    && mv ./devkitBase/include /usr/autodesk/maya2018/. \
    && mv ./devkitBase/lib /usr/autodesk/maya2018/. \
    && rm -rf gloudjq6zljbg7br7o35vi82t158qcsd* devkit*

CMD ["/bin/bash"]
