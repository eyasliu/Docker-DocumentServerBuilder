FROM ubuntu:trusty
MAINTAINER Ascensio System SIA <support@onlyoffice.com>

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    DEBIAN_FRONTEND=noninteractive \
    QT_SELECT=qt5 \
    PHANTOMJS_CDNURL=http://npm.taobao.org/mirrors/phantomjs \
    CHROMEDRIVER_CDNURL=http://npm.taobao.org/mirrors/chromedriver \
    SELENIUM_CDNURL=http://npm.taobao.org/mirrorss/selenium \
    NVM_NODEJS_ORG_MIRROR=http://npm.taobao.org/mirrors/node \
    NVM_IOJS_ORG_MIRROR=http://npm.taobao.org/mirrors/iojs

COPY sources.list /etc/apt/sources.list

RUN apt-get -y update && \
    apt-get install --force-yes -yq apt-transport-https locales software-properties-common curl && \
    curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
    locale-gen en_US.UTF-8 && \
    apt-get -y update && \
    apt-get install --force-yes -yq \
        wget \
        build-essential \
        sed \
        dpkg-dev \
        debhelper \
        createrepo \
        dpkg-dev \
        debhelper \
        libxml2-dev \
        libcurl4-gnutls-dev \
        libglib2.0-dev \
        libgdk-pixbuf2.0-dev \
        libgtkglext1-dev \
        libatk1.0-dev \
        libcairo2-dev \
        libxss-dev \
        libgconf2-dev \
        default-jre \
        qt5-default \
        qtchooser \
        nodejs \
        p7zip-full \
        git \
        subversion \
        python-pip && \
    npm install -g npm && \
    npm install -g grunt-cli && \
    npm cache clean && \
    pip install awscli && \
    rm -rf /var/lib/apt/lists/* && \
    npm config set registry https://registry.npm.taobao.org && \
    npm config set disturl https://npm.taobao.org/dist && \
    npm config set operadriver_cdnurl http://cdn.npm.taobao.org/dist/operadriver && \
    npm config set fse_binary_host_mirror https://npm.taobao.org/mirrors/fsevents && \
    npm config set sass_binary_site http://cdn.npm.taobao.org/dist/node-sass && \
    npm config set electron_mirror http://cdn.npm.taobao.org/dist/electron/ && \
    curl -a -o /etc/hosts  https://raw.githubusercontent.com/racaljk/hosts/master/hosts

ADD build.sh /app/onlyoffice/build.sh

VOLUME /var/lib/onlyoffice

CMD bash -C '/app/onlyoffice/build.sh'
