FROM ubuntu:18.04

# To make it easier for build and release pipelines to run apt-get,
# configure apt to not require confirmation (assume the -y argument by default)
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

RUN apt-get update \
&& apt-get install -y --no-install-recommends \
        ca-certificates \
        software-properties-common \
        curl \
        jq \
        git \
        iputils-ping \
        libcurl4 \
        libicu60 \
        libunwind8 \
        netcat \
        apt-transport-https \
        lsb-release \
        gnupg \
        openssl \
        zip

WORKDIR /tmp

# Az CLI
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc |     gpg --dearmor |     tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/azure-cli.list
RUN apt-get update && apt-get install -y --no-install-recommends azure-cli

# Powershell Core
RUN curl https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb --output packages-microsoft-prod.deb
RUN add-apt-repository universe
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get update && apt-get install -y --no-install-recommends powershell

# Chromium
RUN apt-get update && apt-get install -y --no-install-recommends chromium-browser
ENV CHROME_BIN=/usr/bin/chromium-browser
ENV CHROME_PATH=/usr/lib/chromium/

# Mono
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | tee /etc/apt/sources.list.d/mono-official-stable.list
RUN apt-get update && apt-get install -y --no-install-recommends mono-complete

# Java Runtime
RUN apt-get update && apt-get install -y --no-install-recommends default-jre

# Python
RUN apt-get update && apt-get install -y --no-install-recommends python python-dev python-pip python3 python3-dev python3-pip

# Docker Agent
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN apt-get update && apt-get install -y --no-install-recommends docker-ce docker-ce-cli containerd.io

# Powershell Az
RUN pwsh -c "Install-Module Az -Force"

WORKDIR /azp

COPY ./start.sh .
RUN chmod +x start.sh

CMD ["./start.sh"]