FROM ubuntu:18.04

# To make it easier for build and release pipelines to run apt-get,
# configure apt to not require confirmation (assume the -y argument by default)
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

RUN apt-get update
RUN apt-get install -y --no-install-recommends gnupg ca-certificates
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | tee /etc/apt/sources.list.d/mono-official-stable.list

RUN apt-get update && apt-get install -y --no-install-recommends \
        apt-utils \
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
        mono-devel \
        && apt-get upgrade \
        && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

# Az CLI
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/azure-cli.list
RUN apt-get update && apt-get install -y --no-install-recommends azure-cli

# SqlCmd
RUN curl -s https://packages.microsoft.com/config/ubuntu/18.04/prod.list | tee /etc/apt/sources.list.d/msprod.list
ENV ACCEPT_EULA=Y
RUN apt-get update && apt-get install -y --no-install-recommends azure-cli mssql-tools unixodbc-dev
ENV PATH="/opt/mssql-tools/bin:${PATH}"

# .NET SDK
RUN add-apt-repository universe
RUN apt-get update && apt-get install -y --no-install-recommends dotnet-sdk-3.1
ENV PATH="/root/.dotnet/tools:${PATH}"

# Entity Framework & Powershell Core
RUN dotnet tool install --global dotnet-ef
RUN dotnet tool install --global PowerShell

# Java Runtime
RUN apt-get update && apt-get install -y --no-install-recommends default-jre

# Python
RUN apt-get update && apt-get install -y --no-install-recommends python3 python3-dev python3-pip

# Chromium
RUN apt-get update && apt-get install -y --no-install-recommends chromium-browser
ENV CHROME_BIN=/usr/bin/chromium-browser \
        CHROME_PATH=/usr/lib/chromium/

# Kubectl
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update && apt-get install -y --no-install-recommends kubectl

# Clean up /tmp
RUN rm -rf *

WORKDIR /azp

COPY ./start.sh .
RUN chmod +x start.sh

CMD ["./start.sh"]