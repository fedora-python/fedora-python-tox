FROM registry.fedoraproject.org/fedora:32

LABEL maintainer="Lumír 'Frenzy' Balhar <frenzy.madness@gmail.com>"

RUN dnf update -y \
    && dnf install -y \
    --setopt=tsflags=nodocs \
    --setopt=deltarpm=false \
    findutils \
    pypy-devel \
    pypy3-devel \
    python2-devel \
    python3-devel \
    python27 \
    python34 \
    python35 \
    python36 \
    python37 \
    python38 \
    python39 \
    python3-pip \
    /usr/bin/tox \
    /usr/bin/virtualenv \
    gcc \
    gcc-c++ \
    git-core \
    && dnf clean all

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

ADD run_tests.sh /

CMD ["/run_tests.sh"]
