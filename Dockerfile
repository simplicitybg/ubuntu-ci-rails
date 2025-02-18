FROM ubuntu:24.04

ENV DEBIAN_FRONTEND noninteractive

# No need of gem documentation
RUN set -eux; \
  { \
  echo 'install: --no-document'; \
  echo 'update: --no-document'; \
  } >> /etc/gemrc

# Installing ruby
RUN apt-get update && apt-get install -y --no-install-recommends\
    ruby ruby-dev graphviz nodejs \
    autoconf \
    automake \
    bison \
    bzip2 \
    cmake \
    dpkg-dev \
    file \
    g++ \
    gcc \
    git \
    gpg-agent \
    imagemagick \
    libbz2-dev \
    libc6-dev \
    libcurl4-openssl-dev \
    libdb-dev \
    libevent-dev \
    libffi-dev \
    libgdbm-dev \
    libglib2.0-dev \
    libgmp-dev \
    libjpeg-dev \
    libkrb5-dev \
    liblzma-dev \
    libmagickcore-dev \
    libmagickwand-dev \
    libmaxminddb-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libpng-dev \
    libpq-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libtool \
    libwebp-dev \
    libxml2-dev \
    libxslt-dev \
    libyaml-dev \
    make \
    openssh-client \
    patch \
    pkg-config \
    software-properties-common \
    tzdata \
    unzip \
    wkhtmltopdf \
    xz-utils \
    zlib1g-dev \
    locales  && rm -rf /var/lib/apt/lists/*

# Install Mozilla Team PPA
RUN add-apt-repository ppa:mozillateam/ppa

# Set higher priority for Mozilla Team PPA
ADD mozillateam-ppa /etc/apt/preferences.d/99-mozillateam

# Installing firefox for Selenium / Capybara
RUN apt-get update && apt-get install -y \
  libxpm4 libxrender1 libgtk2.0-0 libnss3 libgconf-2-4 libpango1.0-0 libxss1 \
  libxtst6 fonts-liberation libappindicator1 xdg-utils gtk2-engines-pixbuf \
  xfonts-cyrillic xfonts-100dpi xfonts-75dpi xfonts-base xfonts-scalable imagemagick \
  x11-apps firefox firefox-geckodriver --no-install-recommends

RUN apt-get remove --purge -y gpg-agent software-properties-common && apt-get autoremove --purge -y && rm -rf /var/lib/apt/lists/*

RUN gem install bundler

# For the most optimal install we download the yarn package directly from 
# github and install it. Installing yarn as recommended by
# https://yarnpkg.com/getting-started/install requires installing libssl1.0-dev
# to install npm, which conflicts with libcurl4-openssl-dev and results in the 
# installation of a number of additional packages
# Installing it using https://classic.yarnpkg.com/en/docs/install#debian-stable
# also requires the installation of gpgv/gnupg2
ADD https://github.com/yarnpkg/releases/raw/gh-pages/debian/pool/main/y/yarn/yarn_1.22.5_all.deb /yarn_1.22.5_all.deb 
RUN dpkg -i /yarn_1.22.5_all.deb
RUN rm /yarn_1.22.5_all.deb

## Set LOCALE to UTF8
#
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
  locale-gen en_US.UTF-8 && \
  dpkg-reconfigure locales && \
  /usr/sbin/update-locale LANG=en_US.UTF-8
ENV LC_ALL en_US.UTF-8
