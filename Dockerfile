FROM debian:testing-slim

ENV LANG C.UTF-8

ARG DEBIAN_FRONTEND=noninteractive

# Install packages
RUN apt-get update -qy && apt-get upgrade -qy
RUN apt-get install nano wget lame build-essential python-dev python3-dev python3-pip libffi-dev -y

# Download libspotify & compile it
RUN wget -O libspotify.tar.gz https://github.com/mopidy/libspotify-deb/raw/master/libspotify_12.1.103.orig-amd64.tar.gz && \
	tar xvf libspotify.tar.gz && \
  rm -f libspotify.tar.gz && \
	cd libspotify-11.1.60-Linux-x86_64-release && \
	make install prefix=/usr/local

RUN pip3 install git+https://github.com/elganzua124/spotify-ripper

# Link our download location to /data in the container
VOLUME ["/data"]

# Copy needed files for spotify-ripper
COPY ./spotify_appkey.key /root/.spotify-ripper/spotify_appkey.key
COPY ./config.ini /root/.spotify-ripper/config.ini
