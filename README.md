# Serverless Docker

[![Build Status](https://gitlab.com/StanGirard/Serverless-Docker/badges/main/pipeline.svg)](https://gitlab.com/StanGirard/Serverless-Docker/)

A [docker image](https://hub.docker.com/r/stangirard/serverless) for running [serverless](https://serverless.com) commands.

This can be useful for building and deploying serverless stacks from CI environments.

The `VERSION` file contains the [serverless release](https://github.com/serverless/serverless/releases) to be built.

## Example ##

```
$ docker pull stangirard/serverless
$ docker run --rm stangirard/serverless serverless --version
```

## Base image ##

[Debian Slim Buster](https://hub.docker.com/_/debian)

Included packages from base image:

- [aws-cli](https://github.com/aws/aws-cli).
- Python 3.7.9
- NodeJS 12.x

## Check the installed tools

```bash
docker run -it --rm --entrypoint="./startup.sh" stangirard/serverless

=================================================
Python 3.7.9
aws-cli/2.1.4 Python/3.7.3 Linux/5.4.39-linuxkit exe/x86_64.debian.10
node v12.20.0
yarn 1.22.5
serverless Framework Core: 2.12.0
Plugin: 4.1.2
SDK: 2.3.2
Components: 3.4.2
=================================================
```

Source [Github](https://github.com/StanGirard/Serverless-Docker)