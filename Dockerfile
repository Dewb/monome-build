FROM ubuntu:18.04
LABEL maintainer="Michael Dewberry (dewb)"
LABEL description="Builder image for monome AVR32-based eurorack modules"

RUN apt-get update && \
    apt-get install --no-install-recommends -y apt-utils build-essential && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y -f tzdata && \
    apt-get install --no-install-recommends -y \
        ragel \
        python3 \
        python3-pip \
        python3-setuptools \
        pandoc \
        locales \
        texlive-xetex \
        latexmk \
        git \
        curl

# Install the cross-compiler tools
WORKDIR /avr32-tools
RUN curl http://ww1.microchip.com/downloads/archive/avr32-gnu-toolchain-3.4.3.820-linux.any.x86_64.tar.gz | gzip -dc | tar -xv --strip-components 1
ENV PATH="/avr32-tools/bin:${PATH}"

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

