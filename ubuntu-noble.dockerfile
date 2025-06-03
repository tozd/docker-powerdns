FROM registry.gitlab.com/tozd/docker/dinit:ubuntu-noble

EXPOSE 53/udp 53/tcp

VOLUME /var/log/powerdns
VOLUME /etc/powerdns/pdns.d

ENV LOG_TO_STDOUT=0

RUN apt-get update -q -q && \
  apt-get install pdns-server --yes --force-yes && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache ~/.npm

COPY ./etc/service/powerdns /etc/service/powerdns
