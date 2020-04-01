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

# Powershell Core
RUN curl https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb --output packages-microsoft-prod.deb
RUN add-apt-repository universe
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get update && apt-get install -y --no-install-recommends powershell

# DotNet
RUN apt-get update && apt-get install -y --no-install-recommends dotnet-sdk-3.1
RUN dotnet tool install --global dotnet-ef
ENV PATH="/root/.dotnet/tools:${PATH}"

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

# Sql Package
RUN curl -Lq https://go.microsoft.com/fwlink/?linkid=873926 -o sqlpackage-linux-x64-latest.zip
RUN unzip sqlpackage-linux-x64-latest.zip -d /opt/sqlpackage
RUN chmod a+x /opt/sqlpackage/sqlpackage
ENV PATH="/opt/sqlpackage:${PATH}"
ENV SQLPACKAGE=/opt/sqlpackage/sqlpackage


# Clean up /tmp
RUN rm -rf *

WORKDIR /azp

COPY ./start.sh .
RUN chmod +x start.sh

CMD ["./start.sh"]