FROM ubuntu:16.04
MAINTAINER Victor Laza <vlaza@zeding.ro>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends software-properties-common curl \
    && sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_16.04/ /' >> /etc/apt/sources.list.d/arc-theme.list" \
    && curl -SL http://download.opensuse.org/repositories/home:Horst3180/xUbuntu_16.04/Release.key | apt-key add - \
    && add-apt-repository ppa:fcwu-tw/ppa \
    && apt-get update \
    && apt-get install -y --no-install-recommends --allow-unauthenticated \
		supervisor openssh-server pwgen sudo net-tools vim alacarte \
		gtk2-engines-murrine ttf-ubuntu-font-family lxde x11vnc xvfb \
		nginx firefox python-pip python-setuptools \
		mesa-utils libgl1-mesa-dri libjavascriptcoregtk-3.0-0 libwebkitgtk-3.0-common libwebkitgtk-3.0-0 \
		gnome-themes-standard gtk2-engines-pixbuf gtk2-engines-murrine dbus-x11 x11-utils \
		default-jre \
    && apt-get autoclean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

ADD https://github.com/krallin/tini/releases/download/v0.9.0/tini /bin/tini
RUN chmod +x /bin/tini

ADD image /
ADD lxde_pannel /root/.config/lxpanel/LXDE/panels/panel
RUN easy_install -U pip && pip install -r /usr/lib/web/requirements.txt

RUN echo "export SWT_GTK3=0" >> /etc/environment

EXPOSE 80

WORKDIR /root
ENV TERM=xterm
ENV HOME=/home/ubuntu
ENV SHELL=/bin/bash

ENTRYPOINT ["/startup.sh"]
