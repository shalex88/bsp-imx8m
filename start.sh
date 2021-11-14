#!/usr/bin/env bash

set -e

hostname=${PWD##*/}
container="bsp-imx8m"
tag="1.2"

usage()
{
    echo "usage: ./start [options]"
    echo "options:"
    echo "-h - help"
    echo "-b - build container"
}

run_container()
{
    docker run \
    -it \
    --rm \
    -e "TERM=xterm-256color" \
    --hostname ${hostname} \
    --name ${hostname} \
    -v "${PWD}":/home/bsp/yocto \
    --workdir /home/bsp/yocto \
    ${container}:${tag}
}

build_container()
{
    docker image build docker -t ${container}:${tag}
}

while getopts "bh" OPTION;
do
    case ${OPTION} in
    b)
        build_container
        exit 0
        ;;
    h)
        usage
        exit 0
        ;;
    ?)
        usage
        exit 1
        ;;
    esac
done
shift "$(($OPTIND -1))"

run_container
