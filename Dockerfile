FROM registry.fedoraproject.org/fedora:39

LABEL maintainer="Lumír 'Frenzy' Balhar <frenzy.madness@gmail.com>"

RUN dnf update -y \
    && dnf install -y \
    --setopt=tsflags=nodocs \
    --setopt=deltarpm=false \
    findutils \
    pypy2-devel \
    pypy3.9-devel \
    pypy3.10-devel \
    python2.7 \
    python3.6 \
    python3.7 \
    python3.8 \
    python3.9 \
    python3.10-devel \
    python3.10-tkinter \
    python3.11-devel \
    python3.11-tkinter \
    python3.12-devel \
    python3.12-tkinter \
    python3.13-devel \
    python3.13-tkinter \
    python3.14-devel \
    python3.14-tkinter \
    python3-pip \
    /usr/bin/tox \
    /usr/bin/virtualenv \
    gcc \
    gcc-c++ \
    git-core \
    make \
    && dnf clean all

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

ADD run_tests.sh /

CMD ["/run_tests.sh"]
