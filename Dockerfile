# ==============================================================================
# NGASP DOCKERFILE
# ==============================================================================
# Usage:
#
#   - Build : docker build -t ngasp .
#   - Run   : xhost +
#             docker run --rm --net host ngasp

# ==============================================================================
# BASE IMAGE
# ==============================================================================

FROM centos:7

LABEL maintainer="Héctor Gracia <hector.gracia@cragenomica.es>"

RUN yum update -y && \
    mkdir -p /app && \
    mkdir -p /opt/lib

# ****************
# *** Packages ***
# ****************

RUN yum install -y kernel-headers kernel-devel && \
    yum install -y gcc-c++ libstdc++-devel
RUN yum install -y make \
    bzip2 \
    boost \
    boost-devel \ 
    boost-system \
    boost-filesystem \
    boost-thread \
    wget \
    git \
    zip \
    unzip \
    ncurses-devel \
    openmpi-devel
    
RUN yum groupinstall -y "Development Tools"

# ==============================================================================
# RUNTIME LIBRARIES
# ==============================================================================

# ***********
# *** gsl ***
# ***********

RUN mkdir -p /tmp/gsl && \
    curl -o /tmp/gsl-2.2.tar.gz ftp://ftp.gnu.org/gnu/gsl/gsl-2.2.tar.gz -LOk && \
    tar -zxvf /tmp/gsl-2.2.tar.gz -C /tmp/gsl && \
    rm /tmp/gsl-2.2.tar.gz && \
    cd /tmp/gsl/gsl-2.2 && \
    ./configure && \
    make && \
    make install

# ************
# *** zlib ***
# ************

RUN mkdir -p /tmp/zlib && \
    curl -o  /tmp/zlib/zlib-1.2.10.tar.gz http://zlib.net/fossils/zlib-1.2.10.tar.gz -LOk && \
    tar -zxvf /tmp/zlib/zlib-1.2.10.tar.gz -C /tmp/zlib && \
    rm /tmp/zlib/zlib-1.2.10.tar.gz && \
    cd /tmp/zlib/zlib-1.2.10 && \
    ./configure && \
    make && \
    make install

# **************
# *** Htslib ***
# **************

RUN mkdir -p /tmp/htslib && \
    curl -o /tmp/htslib/htslib-1.3.1.tar.bz2 https://github.com/samtools/htslib/releases/download/1.3.1/htslib-1.3.1.tar.bz2 -LOk && \
    tar jxf /tmp/htslib/htslib-1.3.1.tar.bz2 -C /tmp/htslib && \
    rm /tmp/htslib/htslib-1.3.1.tar.bz2 && \
    cd /tmp/htslib/htslib-1.3.1 && \
    ./configure && \
    make && \
    make install

# ***************
# *** openmpi ***
# ***************

RUN mkdir /tmp/openmpi && \
    cd /tmp/openmpi && \
    curl -o openmpi-1.10.1.tar.bz2 https://www.open-mpi.org/software/ompi/v1.10/downloads/openmpi-1.10.1.tar.bz2 -LOk && \
    tar -jxf openmpi-1.10.1.tar.bz2 && \
    cd openmpi-1.10.1/ && \
    ./configure --prefix=/opt/lib/openmpi && \
    make all && \
    make install
ENV OPEN_MPI_HOME /opt/lib/openmpi
ENV LD_LIBRARY_PATH "/opt/lib/openmpi/lib:${LD_LIBRARY_PATH}"
ENV PATH "/opt/lib/openmpi/bin:${PATH}"

# ==============================================================================
# NODE JS SERVER
# ==============================================================================

# ************
# *** epel ***
# ************

RUN curl -o epel.rpm https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -LOk && \
    rpm -Uvh epel.rpm

RUN yum install -y nodejs

# ***************
# *** chrome  ***
# ***************

#RUN yum -y install mesa-dri-drivers libexif libcanberra-gtk2 libcanberra; yum clean all
#ADD https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm /root/google-chrome-stable_current_x86_64.rpm
#RUN yum -y install /root/google-chrome-stable_current_x86_64.rpm; yum clean all
#RUN dbus-uuidgen > /etc/machine-id
#RUN yum install -y chromium
#RUN yum -y install  liberation-mono-fonts  liberation-narrow-fonts liberation-sans-fonts  liberation-serif-fonts


# ==============================================================================
# DEVELOPMENT COMPILERS
# ==============================================================================

# ****************
# *** Java JDK ***
# ****************

RUN yum install -y http://vault.centos.org/7.3.1611/updates/x86_64/Packages/java-1.8.0-openjdk-1.8.0.131-3.b12.el7_3.x86_64.rpm http://vault.centos.org/7.3.1611/updates/x86_64/Packages/java-1.8.0-openjdk-headless-1.8.0.131-3.b12.el7_3.x86_64.rpm
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.131-3.b12.el7_3.x86_64/jre

# **************
# *** Gradle ***
# **************

RUN mkdir -p /app/gradle && \
    curl -o /app/gradle/gradle-3.1-bin.zip https://services.gradle.org/distributions/gradle-3.1-bin.zip -LOk && \
    unzip -o /app/gradle/gradle-3.1-bin.zip -d /app/gradle && \
    rm /app/gradle/gradle-3.1-bin.zip && \
    echo "export PATH=\$PATH:/app/gradle/gradle-3.1/bin" > /etc/profile.d/gradle.sh && \
    echo "export PATH=\$PATH:/app/gradle/gradle-3.1/bin" >> ~/.bashrc
ENV PATH "/app/gradle/gradle-3.1/bin:${PATH}"


# ==============================================================================
# COMPILATION LIBRARIES
# ==============================================================================

# *************
# *** yaml *** 
# *************

RUN mkdir -p /opt/lib/yaml && \
    cd /opt/lib/yaml && \
    wget https://github.com/jbeder/yaml-cpp/archive/master.zip && \
    unzip -o master.zip && \
    rm master.zip

# ==============================================================================
# GUI APPS REQUIREMENTS
# ==============================================================================

VOLUME ["/tmp/.X11-unix", "/tmp/.X11-unix"]
ENV DISPLAY :0.0
RUN export DISPLAY=:0.0

# ==============================================================================
# NGASP
# ==============================================================================

#TODO: no descargar el master?
#TODO: el cheout sera del latest supongo

WORKDIR /app
#Uso este para tests
RUN git clone https://github.com/Hgracia/ngasp.git
WORKDIR /app/ngasp
RUN git checkout ngaSP-0.6

#RUN git clone https://github.com/CRAGENOMICA/ngasp.git
#WORKDIR /usr/ngasp
#RUN git checkout develop


# para que continue funcionando todo hace falta que exista la carpeta develop y
# contenga todo lo que hay en src
RUN mkdir /develop
RUN cp -R /app/ngasp/src/. /develop

#Añado compilacion de las librerias
RUN /bin/bash /develop/compile_all.sh

# ==============================================================================
# CLEAN
# ==============================================================================

RUN yum erase -y kernel-headers \
    kernel-devel \
    libstdc++-devel \
    openmpi-devel \
    git \
    ncurses-devel
RUN yum -y update; yum clean all
RUN rm -rf /tmp/gsl
RUN rm -rf /tmp/zlib
RUN rm -rf /tmp/htslib
RUN rm -rf /tmp/openmpi

# ==============================================================================
# START
# ==============================================================================

WORKDIR /develop
ENTRYPOINT ["/develop/webapp/start_ngasp.sh"]