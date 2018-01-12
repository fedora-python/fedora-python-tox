# Fedora + Pythons + Tox in docker image

[![Build Status](https://travis-ci.org/frenzymadness/fedora-python-tox.svg?branch=master)](https://travis-ci.org/frenzymadness/fedora-python-tox)

This repository contains source code for Docker image designed to help you
run your Tox tests with all available Python versions in Docker container.

[Docker image is hosted on Docker Hub](https://hub.docker.com/r/frenzymadness/fedora-python-tox/) and build automatically after every push to master branch.

# Installed packages

On top of stable Fedora, this Docker image contains:
- Python 2.6, 2.7, 3.3, 3.4, 3.5, 3.6, 3.7
- Pypy and Pypy3
- Jython
- python2-pip and python3-pip
- tox
- virtualenv

# Example usage with local source code

If you want to use this Docker image as environmet for your test, use this command:

```
cd example_project
docker run --rm -it -v $PWD:/src -w /src frenzymadness/fedora-python-tox

py26 create: /src/.tox/py26
py26 installdeps: pytest
py26 installed: DEPRECATION: Python 2.6 is no longer supported by the Python core team, please upgrade your Python. A future version of pip will drop support for Python 2.6,argparse==1.4.0,ordereddict==1.1,py==1.4.34,pytest==3.2.2
py26 runtests: PYTHONHASHSEED='3794647945'
py26 runtests: commands[0] | pytest
==== test session starts ====
platform linux4 -- Python 2.6.9, pytest-3.2.2, py-1.4.34, pluggy-0.4.0
rootdir: /src, inifile:
collected 10 items

test_fac.py ..........

==== passed in 0.07 seconds ====
py27 create: /src/.tox/py27
py27 installdeps: pytest
py27 installed: py==1.4.34,pytest==3.2.2
py27 runtests: PYTHONHASHSEED='3794647945'
py27 runtests: commands[0] | pytest
==== test session starts ====
platform linux2 -- Python 2.7.13, pytest-3.2.2, py-1.4.34, pluggy-0.4.0
rootdir: /src, inifile:
collected 10 items

test_fac.py ..........

==== passed in 0.06 seconds ====

... etc ...
```

This command will download an image from Docker hub for you

```
Unable to find image 'frenzymadness/fedora-python-tox:latest' locally
Trying to pull repository docker.io/frenzymadness/fedora-python-tox ... 
sha256:d4b51931dd86a33552b6a08f39575db336b606f4ccebbc48f390d7f728367a6f: Pulling from docker.io/frenzymadness/fedora-python-tox

```

Command and argument description:

- `docker run`    - run docker image
- `--rm`          - automatically remove the container when it exits
- `-i`            - keep STDIN open even if not attached
- `-t`            - allocate a pseudo-TTY
- `-v $PWD:/src`  - mount your current working directory to /src inside container
- `-w`            - use /src (mountpoint) as working directory inside container
- `frenzymadness/fedora-python-tox` - name of Docker image

Tox is run automatically with this container. How cool!

You also can limit Tox tests by passing environment variable to Docker. For example:

```
cd example_project
docker run --rm -it -v $PWD:/src -w /src -e TOXENV=pypy3 frenzymadness/fedora-python-tox
pypy3 create: /src/.tox/pypy3
pypy3 installdeps: pytest
pypy3 installed: cffi==1.10.1,greenlet==0.4.12,py==1.4.34,pytest==3.2.2,readline==6.2.4.1
pypy3 runtests: PYTHONHASHSEED='68938415'
pypy3 runtests: commands[0] | pytest
==== test session starts ====
platform linux -- Python 3.5.3[pypy-5.8.0-beta], pytest-3.2.2, py-1.4.34, pluggy-0.4.0
rootdir: /src, inifile:
collected 10 items

test_fac.py ..........

==== passed in 0.24 seconds ====

  pypy3: commands succeeded
  congratulations :)
```

# Example usage with GIT URL

Instead of mounting local folder with source code into container, you can
provide HTTPS URL of your GIT repository and it will be cloned automatically.

For example:
```
docker run --rm -it -e GIT_URL=https://github.com/fedora-python/pyp2rpm.git frenzymadness/fedora-python-tox
Cloning into 'temp_project_dir'...
remote: Counting objects: 3075, done.
remote: Compressing objects: 100% (5/5), done.
remote: Total 3075 (delta 1), reused 3 (delta 1), pack-reused 3069
Receiving objects: 100% (3075/3075), 2.97 MiB | 2.57 MiB/s, done.
Resolving deltas: 100% (2188/2188), done.
GLOB sdist-make: /temp_project_dir/setup.py
py27 create: /temp_project_dir/.tox/py27

... etc ...
```

# License

MIT
