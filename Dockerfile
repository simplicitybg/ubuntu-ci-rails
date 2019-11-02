FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y ruby2.5 ruby2.5-dev graphviz \
libxpm4 libxrender1 libgtk2.0-0 libnss3 libgconf-2-4 libpango1.0-0 libxss1 \
libxtst6 fonts-liberation libappindicator1 xdg-utils gtk2-engines-pixbuf \
xfonts-cyrillic xfonts-100dpi xfonts-75dpi xfonts-base xfonts-scalable imagemagick \
x11-apps firefox nodejs locales --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN gem install bundler -v '1.17.3'

## Set LOCALE to UTF8
#
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
  locale-gen en_US.UTF-8 && \
  dpkg-reconfigure locales && \
  /usr/sbin/update-locale LANG=en_US.UTF-8
ENV LC_ALL en_US.UTF-8