FROM ubuntu:23.04

# Automatically generated by the CM workflow automation meta-framework
# https://github.com/mlcommons/ck

LABEL github=""
LABEL maintainer=""
LABEL license=""

SHELL ["/bin/bash", "-c"]

ARG CM_GH_TOKEN
ARG CM_ADD_DOCKER_GROUP_ID=""


# Notes: https://runnable.com/blog/9-common-dockerfile-mistakes
# Install system dependencies
RUN apt-get update -y
RUN apt-get install -y python3 python3-pip git sudo wget
RUN apt-get install -y libgl1-mesa-glx

# Setup docker environment
ENV TZ="US/Pacific"
ENV PATH="${PATH}:/home/cmuser/.local/bin"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ >/etc/timezone

# Setup docker user
RUN groupadd ${CM_ADD_DOCKER_GROUP_ID} cm
RUN useradd  -g cm --create-home --shell /bin/bash cmuser
RUN echo "cmuser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER cmuser:cm
WORKDIR /home/cmuser

# Install python packages
RUN python3 -m pip install --user cmind requests giturlparse tabulate --break-system-packages

# Download CM repo for scripts
RUN cm pull repo mlcommons@cm4mlops --checkout=dev
RUN cm pull repo --url=https://oauth2:${CM_GH_TOKEN}@github.com/mlcommons/cm4abtf.git --checkout=dev

# Install extra system dependencies for MLPerf
RUN cm run script --tags=get,sys-utils-cm --quiet
