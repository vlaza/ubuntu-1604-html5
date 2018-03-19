FROM ubuntu:16.04
MAINTAINER Victor Laza <vlaza@zeding.ro>

ENV DEBIAN_FRONTEND noninteractive

ADD files /

RUN apt-get update \
    && apt-get install -y --no-install-recommends software-properties-common curl \
    && add-apt-repository ppa:fcwu-tw/ppa \
    && apt-add-repository ppa:nilarimogard/webupd8 \
    && apt-get update \
    && curl -sLo /bin/tini https://github.com/krallin/tini/releases/download/v0.17.0/tini \
    && chmod +x /bin/tini \
    && apt-get install -y --no-install-recommends --allow-unauthenticated \
		supervisor pwgen net-tools vim alacarte \
		gtk2-engines-murrine ttf-ubuntu-font-family lxde x11vnc xvfb \
		nginx python-pip python-setuptools \
		mesa-utils libgl1-mesa-dri libjavascriptcoregtk-3.0-0 libwebkitgtk-3.0-common libwebkitgtk-3.0-0 \
		gnome-themes-standard gtk2-engines-pixbuf gtk2-engines-murrine dbus-x11 x11-utils \
		pulseaudio \
    && apt-get install -y grive keepassx firefox \
    && apt-get autoclean && apt-get autoremove && rm -rf /var/lib/apt/lists/* \
    && easy_install -U pip \
    && pip install -r /usr/lib/web/requirements.txt \
    && echo "export SWT_GTK3=0" >> /etc/environment

EXPOSE 80

WORKDIR /root
ENV TERM=xterm
ENV HOME=/root
ENV SHELL=/bin/bash

ENTRYPOINT ["/startup.sh"]
