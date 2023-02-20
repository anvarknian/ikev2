FROM ubuntu:20.04 AS dev

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade \
    && DEBIAN_FRONTEND=noninteractive apt-get -o Acquire::ForceIPv4=true update \
    && DEBIAN_FRONTEND=noninteractive apt-get -o Acquire::ForceIPv4=true install -y software-properties-common \
    && DEBIAN_FRONTEND=noninteractive add-apt-repository universe \
    && DEBIAN_FRONTEND=noninteractive add-apt-repository restricted \
    && DEBIAN_FRONTEND=noninteractive add-apt-repository multiverse \
    && DEBIAN_FRONTEND=noninteractive apt-get -o Acquire::ForceIPv4=true install -y moreutils dnsutils language-pack-en strongswan libstrongswan-standard-plugins strongswan-libcharon libcharon-standard-plugins libcharon-extra-plugins  iptables-persistent postfix mutt unattended-upgrades certbot uuid-runtime strongswan libstrongswan-standard-plugins libcharon-extra-plugins libcharon-standard-plugins \
    && rm -rf /var/lib/apt/lists/*

ADD ./bin/* /usr/bin/
ADD ./conf/charon-logging.conf /etc/strongswan.d/charon-logging.conf

FROM dev AS prod
ENTRYPOINT /usr/bin/run
