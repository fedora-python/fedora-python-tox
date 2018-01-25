FROM fedora:27

LABEL maintainer="Lumír 'Frenzy' Balhar <frenzy.madness@gmail.com>"

RUN curl https://copr.fedorainfracloud.org/coprs/g/python/pypy35/repo/fedora-27/group_python-pypy35-fedora-27.repo \
    -o /etc/yum.repos.d/group_python-pypy35-fedora-27.repo

RUN dnf update -y \
    && dnf install -y \
    --setopt=tsflags=nodocs \
    --setopt=deltarpm=false \
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
    python37 \
    python2-pip \
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
