FROM ubuntu:19.04

DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get install -y apt-transport-https curl php libapache2-mod-php

RUN curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install -y nodejs

# Install latest NPM, Yarn, Bower and Gulp
RUN npm install -g npm@latest
RUN npm install -g yarn@latest
RUN npm install -g bower@latest
RUN npm install -g gulp-cli@latest

# install additional native dependencies build tools
RUN apt install -y build-essential

# install Git client
RUN apt-get install -y git
# install unzip utility to speed up Cypress unzips
# https://github.com/cypress-io/cypress/releases/tag/v3.8.0
RUN apt-get install -y unzip

# avoid any prompts
ENV DEBIAN_FRONTEND noninteractive
#install tzdata package
RUN apt-get install -y tzdata
# set your timezone
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata

# install Cypress dependencies (separate commands to avoid time outs)
RUN apt-get install -y \
    libgtk2.0-0
RUN apt-get install -y \
    libnotify-dev
RUN apt-get install -y \
    libgconf-2-4 \
    libnss3 \
    libxss1
RUN apt-get install -y \
    libasound2 \
    xvfb

# a few environment variables to make NPM installs easier
# good colors for most applications
ENV TERM xterm
# avoid million NPM install messages
ENV npm_config_loglevel warn
# allow installing when the main user is root
ENV npm_config_unsafe_perm true

# versions of local tools
RUN echo  " node version:    $(node -v) \n" \
  "npm version:     $(npm -v) \n" \
  "yarn version:    $(yarn -v) \n" \
  "debian version:  $(cat /etc/debian_version) \n" \
  "user:            $(whoami) \n" \
  "git:             $(git --version) \n"

RUN echo "More version info"
RUN cat /etc/lsb-release
RUN cat /etc/os-release
