FROM fedora:26

MAINTAINER Lumír 'Frenzy' Balhar <frenzy.madness@gmail.com>

RUN dnf install -y \
    findutils \
    pypy \
    pypy3 \
    python26 \
    python2 \
    python33 \
    python34 \
    python35 \
    python36 \
    python2-pip \
    python3-pip \
    python2-tox \
    python3-tox \
    python2-virtualenv \
    python3-virtualenv


ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
