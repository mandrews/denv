# denv

Docker Development Environment Manager

## Overview

Encapsulate `zsh`, `vi`, `tmux` installation and configuration within an easy to replicate Docker container for local development. A cross between [`dotfiles`](https://dotfiles.github.io/) and [`venv`](https://docs.python.org/3/library/venv.html)/[`rvm`](https://rvm.io/). Works well with [iTerm2](https://www.iterm2.com/) and [Solarized Dark](https://ethanschoonover.com/solarized/).

## Dependencies
- [Docker](https://docs.docker.com/docker-for-mac/install/)
- [Clipper](https://github.com/wincent/clipper) (**Optional**)
- ~~HomeBrew~~ (**Not Required**)
- ~~Git~~ (**Not Required**))

## Install
After installing Docker, install with a simple `curl` command:
```bash
curl -L 'https://raw.githubusercontent.com/mandrews/denv/master/bin/install.sh' | bash
```
![denv install example](https://raw.githubusercontent.com/wiki/mandrews/denv/INSTALL.gif)

## Switch Development Environment
To switch development environments, simply type the name of the Docker Image and Tag.

**Example**:
```bash
# Switch to Python 2.7 environment
denv python:2.7

# Switch to Python 3.7 environment
denv python:3.7

# Switch to Java 11 environment
denv java:11
```

![denv environment example](https://raw.githubusercontent.com/wiki/mandrews/denv/DENV.gif)

Data in development environments can be persisted to `$HOME/.local` using Docker volumes. To create a new Docker volume, include the volume name as the second argument. This can effectively replace [RVM Gemsets](https://rvm.io/gemsets/basics) or [VEnv Virtual Environments](https://docs.python.org/3/library/venv.html).


**Example**:
```bash
# Switch to Python environment with volume projectA
denv python projectA

# Switch to Python environment with volume projectB
denv python projectB
```

![denv volume example](https://raw.githubusercontent.com/wiki/mandrews/denv/DENV_VOLUME.gif)

## Other Dockerized Development Environments
- [JAremko/alpine-vim](https://github.com/JAremko/alpine-vim)
- [zen-cmd](https://github.com/thierrymarianne/demo-zen-command-line)

## TODO
- [ ] Add [`awscli`](https://aws.amazon.com/cli/) to `base`
- [ ] Add [`gcp`](https://cloud.google.com/sdk/install) to `base`
