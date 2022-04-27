#!/usr/bin/env bash

set -e

directory="var-fsl-yocto"
bsp_version="fsl-zeus"

src_version="imx-5.4.70-2.3.2-var01"

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

# Clone Hailo layer
cd sources
git clone https://github.com/hailo-ai/meta-hailo -b zeus

echo "Done, type \"MACHINE=imx8mp-var-dart DISTRO=fsl-imx-xwayland . var-setup-release.sh\" to create the build environment"
