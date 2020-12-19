FROM nginx:1.15

LABEL maintainer="armand.leopold@outlook.com"

ARG VERSION=v0.8.1

ENV http_proxy $http_proxy
ENV https_proxy $https_proxy
ENV no_proxy $no_proxy
ENV PATH /usr/local/bin:$PATH

RUN apt-get update && \
    apt-get -y install wget unzip && \
    cd /tmp && \
    wget  https://github.com/armandleopold/graphexp/archive/$VERSION.zip && \
    unzip $VERSION.zip && \
    sed 's/const HOST = "localhost"/const HOST = self.location.hostname/' graphexp-$VERSION/scripts/graphConf.js > graphConf.js && \
    mv graphConf.js graphexp-$VERSION/scripts && \
    mv graphexp-$VERSION/*  /usr/share/nginx/html && \
    rm -R /tmp/graphexp-$VERSION && \
    apt-get remove -y wget && \
    apt-get remove -y unzip && \
    rm -R /var/lib/apt/lists/*

WORKDIR  /usr/share/nginx/html
