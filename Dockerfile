FROM ghcr.io/linuxserver/baseimage-selkies:debiantrixie

# title
ENV TITLE=WeChat

RUN \
  echo "**** add icon ****" && \
  curl -o \
    /usr/share/selkies/www/icon.png \
    https://open.weixin.qq.com/zh_CN/htmledition/res/assets/res-design-download/icon16_wx_logo.png && \
  echo "**** download packages ****" && \
  curl -o /tmp/WeChatLinux_x86_64.deb \
    https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.deb && \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libatomic1 \
    libxkbcommon-x11-dev \
    libxcb-icccm4-dev \
    libxcb-image0-dev \
    libxcb-render-util0-dev \
    libxcb-keysyms1-dev \
    zenity && \
  apt-get install -y --no-install-recommends \
    /tmp/WeChatLinux_x86_64.deb && \
  echo "**** cleanup ****" && \
  apt-get autoclean && \
  rm -rf \
    /config/.cache \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000

VOLUME /config
