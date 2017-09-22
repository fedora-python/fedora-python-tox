# Fedora + Pythons + Tox in docker image

This repository contains source code for Docker image designed to help you
run your Tox tests with all available Python versions in Docker container.

[Docker image is hosted on Docker Hub](https://hub.docker.com/r/frenzymadness/fedora-python-tox/) and build automatically after every push to master branch.

# Installed packages

On top of stable Fedora, this Docker image contains:
- Python 2.6, 2.7, 3.3, 3.4, 3.5, 3.6
- Pypy and Pypy3
- Jython
- python2-pip and python3-pip
- tox
- virtualenv

# Example usage

If you want to use this Docker image as environmet for your test, use this command:

```
docker run --rm -it -v $PWD:/src -w /src frenzymadness/fedora-python-tox
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
docker run --rm -it -v $PWD:/src -w /src -e TOXENV=py35-django18 frenzymadness/fedora-python-tox
```

# License

MIT
