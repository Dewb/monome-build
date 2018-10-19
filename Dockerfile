FROM ubuntu:18.04
LABEL maintainer="Michael Dewberry (dewb)"
LABEL description="Builder image for monome AVR32-based eurorack modules"

# Install cross-compiler prerequisites
RUN apt-get update 
RUN apt-get install --no-install-recommends -y \
    curl \
    flex \
    bison \
    libgmp3-dev \
    libmpfr-dev \
    autoconf \
    build-essential \
    libncurses5-dev \
    libmpc-dev \
    texinfo \
    git \
    gawk \
    file \
    zlib1g-dev \
    unzip \
    ca-certificates 

# Build cross-compiler
WORKDIR /cross
RUN git clone https://github.com/denravonska/avr32-toolchain

WORKDIR /cross/avr32-toolchain
RUN PREFIX=/avr32-tools make install-cross
ENV PATH="/avr32-tools/bin:${PATH}"

# Other monome build tools and prerequisites
RUN apt-get install -y apt-utils
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -f tzdata
RUN apt-get install -y \
   ragel \
   python3 \
   python3-pip \
   pandoc \
   locales \
   texlive-xetex \
   latexmk

# Install python modules
RUN pip3 install \
    jinja2 \
    pypandoc \
    pytoml 

# Make sure shell and Python encoding are set to UTF-8
RUN locale-gen en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8
ENV PYTHONIOENCODING=utf-8

WORKDIR /target
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["make"]

