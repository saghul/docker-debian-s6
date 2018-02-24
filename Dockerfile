FROM debian:stretch-slim

ENV TZ=Europe/Amsterdam

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.2.2/s6-overlay-amd64.tar.gz /tmp/s6-overlay.tar.gz
ADD https://github.com/just-containers/socklog-overlay/releases/download/v2.1.0-1/socklog-overlay-amd64.tar.gz /tmp/socklog-overlay.tar.gz

COPY rootfs /

RUN \
	tar xfz /tmp/s6-overlay.tar.gz -C / && \
	tar xfz /tmp/socklog-overlay.tar.gz -C / && \
	apt-dpkg-wrap apt-get update && \
	apt-dpkg-wrap apt-get dist-upgrade -y && \
	rm -f /tmp/*.tar.gz && \
	rm -rf /var/lib/apt/lists/

ENTRYPOINT [ "/init" ]
