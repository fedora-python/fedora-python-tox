FROM fedora:26

MAINTAINER Lumír 'Frenzy' Balhar <frenzy.madness@gmail.com>

RUN dnf install -y \
    --setopt=tsflags=nodocs \
    --setopt=deltarpm=false \
    dnf-plugins-core \
    findutils \
    jython \
    pypy-devel \
    pypy3-devel \
    python2-devel \
    python3-devel \
    python26 \
    python27 \
    python33 \
    python34 \
    python35 \
    python36 \
    python2-pip \
    python3-pip \
    /usr/bin/tox \
    /usr/bin/virtualenv \
    gcc \
    gcc-c++ \
    && dnf clean all

RUN dnf -y copr enable @python/pypy35 && dnf update -y pypy3

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

CMD ["/usr/bin/tox"]