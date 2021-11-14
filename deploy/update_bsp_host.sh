#!/bin/bash -e

if [ -z "${1}" ]; then
	echo "Provide Target IP"
	exit
fi

# Target configuration
TARGET_IP=${1}
TARGET_USER=root
TARGET=${TARGET_USER}@${TARGET_IP}
EXEC_ON_TARGET="ssh ${TARGET}"
DESTINATION_DIR=/home/root/

BSP_FILE_PATH=$(pwd)/../var-fsl-yocto/build/tmp/deploy/images/imx8mm-var-dart
BSP_FILE=rootfs.tar.gz
UPDATE_SCRIPT=update_bsp_target.sh

cp ${BSP_FILE_PATH}/fsl-image-qt5-imx8mm-var-dart.tar.gz ${BSP_FILE}

transfer_and_validate()
{
	FILE=${1}

	scp ${FILE} ${TARGET}:${DESTINATION_DIR}
	${EXEC_ON_TARGET} "sync"

	LOCAL_MD5SUM=$(md5sum ${FILE} | cut -d ' ' -f1)
	REMOTE_MD5SUM=$(${EXEC_ON_TARGET} "md5sum ${FILE} | cut -d ' ' -f1")

	if [ "${LOCAL_MD5SUM}" != "${REMOTE_MD5SUM}" ]; then
		echo Not matching md5sum!
		exit
	fi

	echo ${FILE} successfully transfered
}

transfer_and_validate ${BSP_FILE}
transfer_and_validate ${UPDATE_SCRIPT}

${EXEC_ON_TARGET} "./${UPDATE_SCRIPT}"
echo Successfully updated

${EXEC_ON_TARGET} "rm ${BSP_FILE}"
${EXEC_ON_TARGET} "rm ${UPDATE_SCRIPT}"
echo Successfully cleaned

echo Reboot target
${EXEC_ON_TARGET} "echo Reboot"
${EXEC_ON_TARGET} "reboot"
