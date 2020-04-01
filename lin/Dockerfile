FROM ubuntu:18.04

# To make it easier for build and release pipelines to run apt-get,
# configure apt to not require confirmation (assume the -y argument by default)
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

RUN apt-get update && apt-get install -y --no-install-recommends \
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
        zip \
        unzip \
        && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

# Az CLI
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc |     gpg --dearmor |     tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/azure-cli.list
RUN apt-get update && apt-get install -y --no-install-recommends azure-cli

# DotNet
RUN apt-get update && apt-get install -y --no-install-recommends dotnet-sdk-3.1

# Entity Framework & Powershell Core
RUN dotnet tool install --global dotnet-ef \ 
        dotnet tool install --global PowerShell
ENV PATH="/root/.dotnet/tools:${PATH}"

# Chromium
RUN apt-get update && apt-get install -y --no-install-recommends chromium-browser
ENV CHROME_BIN=/usr/bin/chromium-browser \
        CHROME_PATH=/usr/lib/chromium/

# Java Runtime
RUN apt-get update && apt-get install -y --no-install-recommends default-jre

# Python
RUN apt-get update && apt-get install -y --no-install-recommends python python-dev python-pip python3 python3-dev python3-pip

# Docker Agent
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN apt-get update && apt-get install -y --no-install-recommends docker-ce docker-ce-cli containerd.io

# Clean up /tmp
RUN rm -rf *

WORKDIR /azp

COPY ./start.sh .
RUN chmod +x start.sh

CMD ["./start.sh"]