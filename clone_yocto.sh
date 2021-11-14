#!/usr/bin/env bash

set -e

directory="var-fsl-yocto"
bsp_version="fsl-warrior"

src_version="imx-4.19.35-1.1.0-var01"

# create the directory
mkdir -p ${directory}
cd ${directory}

# Configure google repo
git config --global user.name "Alex Sh"
git config --global user.email "shalex.work@gmail.com"
git config --global color.ui true

# Clone poky and other layers
repo init -u https://github.com/varigit/variscite-bsp-platform.git -b ${bsp_version} -m ${src_version}.xml
repo sync -j4

echo "Done, type \"MACHINE=imx8mm-var-dart DISTRO=fsl-imx-xwayland . var-setup-release.sh\" to create the build environment"
