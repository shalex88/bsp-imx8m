#!/bin/bash

green=$'\e[1;32m'
white=$'\e[0m'

BITBAKE_ENV_FILE=bitbake_env_variables
BITBAKE_ENV_FILE_KERNEL=bitbake_env_variables_kernel
BITBAKE_ENV_FILE_UBOOT=bitbake_env_variables_uboot
IMAGE=$1

if [ -z "${BUILDDIR}" ]; then
    cd var-fsl-yocto
    source setup-environment build
fi

bitbake -e ${IMAGE} > ${BITBAKE_ENV_FILE}
bitbake -e virtual/kernel > ${BITBAKE_ENV_FILE_KERNEL}
bitbake -e virtual/bootloader > ${BITBAKE_ENV_FILE_UBOOT}

echo ${green}"Build Configuration:"${white}
echo $(cat ${BITBAKE_ENV_FILE} | grep BB_NUMBER_THREADS=)
echo $(cat ${BITBAKE_ENV_FILE} | grep PARALLEL_MAKE=)
echo $(cat ${BITBAKE_ENV_FILE} | grep BSPDIR=)
echo $(cat ${BITBAKE_ENV_FILE} | grep DL_DIR=)
echo $(cat ${BITBAKE_ENV_FILE} | grep SSTATE_DIR=)
echo $(cat ${BITBAKE_ENV_FILE} | grep ^DEPLOY_DIR_IMAGE=)
echo $(cat ${BITBAKE_ENV_FILE} | grep ^IMAGE_FSTYPES=)

echo ${green}"BSP:"${white}
echo $(cat ${BITBAKE_ENV_FILE} | grep MACHINE_ARCH=)
echo $(cat ${BITBAKE_ENV_FILE} | grep KERNEL_DEVICETREE=)
echo $(cat ${BITBAKE_ENV_FILE} | grep PREFERRED_PROVIDER_virtual/bootloader=)
echo $(cat ${BITBAKE_ENV_FILE_UBOOT} | grep UBOOT_LOCALVERSION=)
echo $(cat ${BITBAKE_ENV_FILE_UBOOT} | grep UBOOT_DTB_NAME=)
echo $(cat ${BITBAKE_ENV_FILE_UBOOT} | grep UBOOT_DTB_EXTRA=)

echo $(cat ${BITBAKE_ENV_FILE} | grep PREFERRED_PROVIDER_virtual/kernel=)
echo $(cat ${BITBAKE_ENV_FILE_KERNEL} | grep KERNEL_RELEASE=)
echo $(cat ${BITBAKE_ENV_FILE} | grep KERNEL_DIR=)

echo ${green}"Distro:"${white}
echo $(cat ${BITBAKE_ENV_FILE} | grep DISTROOVERRIDES=)
echo $(cat ${BITBAKE_ENV_FILE} | grep DISTRO_VERSION=)
echo $(cat ${BITBAKE_ENV_FILE} | grep ^DISTRO_FEATURES=)

echo ${green}"Packages:"${white}
echo $(cat ${BITBAKE_ENV_FILE} | grep ROOTFS_PKGMANAGE=)
echo $(cat ${BITBAKE_ENV_FILE} | grep PACKAGE_CLASSES=)
echo $(cat ${BITBAKE_ENV_FILE} | grep IMAGE_BASENAME=)
echo $(cat ${BITBAKE_ENV_FILE} | grep ^IMAGE_FEATURES=)
echo $(cat ${BITBAKE_ENV_FILE} | grep IMAGE_INSTALL=)
echo $(cat ${BITBAKE_ENV_FILE} | grep PACKAGE_EXCLUDE=)

echo ${green}"SDK:"${white}
echo $(cat ${BITBAKE_ENV_FILE} | grep TOOLCHAIN_HOST_TASK=)

echo ${green}"Extensions:"${white}
echo $(cat ${BITBAKE_ENV_FILE} | grep HAILO_EXTERNALSRC=)

rm ${BITBAKE_ENV_FILE} ${BITBAKE_ENV_FILE_KERNEL} ${BITBAKE_ENV_FILE_UBOOT}
