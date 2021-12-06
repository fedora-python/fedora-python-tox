# Fedora + Pythons + Tox in docker image

![CI/CD status](https://github.com/fedora-python/fedora-python-tox/actions/workflows/build-and-push.yml/badge.svg)

This repository contains source code for Docker image designed to help you
run your Tox tests with all available Python versions in Docker container.

[Docker image is hosted on Docker Hub](https://hub.docker.com/r/fedorapython/fedora-python-tox/) and build automatically after every push to master branch.

# Installed packages

On top of stable Fedora, this Docker image contains:
- Python 2.7, 3.5, 3.6, 3.7, 3.8, 3.9, 3.10, 3.11
- Pypy2 and Pypy3
- python3-pip
- gcc, gcc-c++, git-core and make
- tox
- virtualenv

# Docker and Podman

The image works very well with both [Docker](https://www.docker.com/) and [Podman](https://podman.io/) so you can use containers management tool you prefer.

# Example usage with local source code

If you want to use this Docker image as environmet for your test, use this command:

```
cd example_project
docker run --rm -it -v $PWD:/src -w /src fedorapython/fedora-python-tox

py27 create: /src/.tox/py27
py27 installdeps: pytest < 3.3
py27 installed: py==1.5.3,pytest==3.2.5
py27 runtests: PYTHONHASHSEED='85819776'
py27 runtests: commands[0] | pytest
==== test session starts ====
platform linux2 -- Python 2.7.18, pytest-3.2.5, py-1.5.3, pluggy-0.4.0
rootdir: /src, inifile:
collected 10 items

test_fac.py ..........

==== 10 passed in 0.02 seconds ====

py35 create: /src/.tox/py35
py35 installdeps: pytest < 3.3
py35 installed: py==1.5.3,pytest==3.2.5
py35 runtests: PYTHONHASHSEED='1223497559'
py35 runtests: commands[0] | pytest
==== test session starts ====
platform linux -- Python 3.5.10, pytest-3.2.5, py-1.5.3, pluggy-0.4.0
rootdir: /src, inifile:
collected 10 items

test_fac.py ..........

==== 10 passed in 0.04 seconds ====
... etc ...
```

This command will download an image from Docker hub for you

```
Unable to find image 'fedorapython/fedora-python-tox:latest' locally
Trying to pull repository docker.io/fedorapython/fedora-python-tox ...
sha256:d4b51931dd86a33552b6a08f39575db336b606f4ccebbc48f390d7f728367a6f: Pulling from docker.io/fedorapython/fedora-python-tox

```

Command and argument description:

- `docker run`    - run docker image
- `--rm`          - automatically remove the container when it exits
- `-i`            - keep STDIN open even if not attached
- `-t`            - allocate a pseudo-TTY
- `-v $PWD:/src`  - mount your current working directory to /src inside container
- `-w`            - use /src (mountpoint) as working directory inside container
- `fedorapython/fedora-python-tox` - name of Docker image

Tox is run automatically with this container. How cool!

You also can limit Tox tests by passing environment variable to Docker. For example:

```
cd example_project
docker run --rm -it -v $PWD:/src -w /src -e TOXENV=pypy3 fedorapython/fedora-python-tox
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

## Parallel run and other tox features

You can adjust the behavior of tox by setting TOX_PARAMS variable with any combination of CLI parameters. It's useful for example for parallel run of your tests.

```
docker run --rm -it -v $PWD:/src -w /src -e TOX_PARAMS="-p auto" fedorapython/fedora-python-tox
✔ OK py37 in 1.664 seconds
✔ OK py35 in 1.893 seconds
✔ OK py27 in 1.902 seconds
✔ OK py38 in 1.913 seconds
✔ OK py36 in 1.987 seconds
✔ OK pypy in 2.904 seconds
✔ OK pypy3 in 3.688 seconds
__________________________________________ summary ___________________________________________
  py27: commands succeeded
  py35: commands succeeded
  py36: commands succeeded
  py37: commands succeeded
  py38: commands succeeded
  pypy: commands succeeded
  pypy3: commands succeeded
  congratulations :)
```

# Example usage with GIT URL

Instead of mounting local folder with source code into container, you can
provide HTTPS URL of your GIT repository and it will be cloned automatically.

For example:
```
docker run --rm -it -e GIT_URL=https://github.com/fedora-python/pyp2rpm.git fedorapython/fedora-python-tox
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

# Installing RPM packages from Fedora

Sometimes, your tests need some system packages (such as C libraries).
You can install them via `dnf` by setting the `$DNF_INSTALL` environment variable:

```
docker run --rm -it -v $PWD:/src -w /src -e DNF_INSTALL="libyaml-devel libgit2-devel" fedorapython/fedora-python-tox
...
Installed:
  http-parser-2.9.3-2.fc32.x86_64    libgit2-1.0.1-2.fc32.x86_64
  libgit2-devel-1.0.1-2.fc32.x86_64  libssh2-1.9.0-5.fc32.x86_64
  libyaml-devel-0.2.2-3.fc32.x86_64  openssl-devel-1:1.1.1g-1.fc32.x86_64
  pcre2-devel-10.35-4.fc32.x86_64    pcre2-utf16-10.35-4.fc32.x86_64
  pcre2-utf32-10.35-4.fc32.x86_64    zlib-devel-1.2.11-21.fc32.x86_64

Complete!
py27 create: /src/.tox/py27
...
```

You can install packages by any RPM *Provides*, for example:

* Fedora package names, e.g. `libgit2-devel`,
* pkgconfig names, e.g. `pkgconfig(libgit2)`, or
* commands, e.g. `/usr/bin/cowsay`.

# License

MIT
