SRC_URI += "file://${MACHINE}.txt"

ENV_FILENAME = "uboot.env"
ENV_FILEPATH = "${WORKDIR}/${MACHINE}.txt"

DEPENDS += "u-boot-mkenvimage-native"
UBOOT_MKENVIMAGE ?= "uboot-mkenvimage"

do_compile:append() {
    bbnote "Compile U-Boot environment"
    ${UBOOT_MKENVIMAGE} ${MKENVIMAGE_EXTRA_ARGS} -s ${UBOOT_ENV_SIZE} ${ENV_FILEPATH} -o ${ENV_FILENAME}
}

do_deploy:append() {
    if [ -e  ${B}/${ENV_FILENAME} ]; then
        install -Dm 0644 ${B}/${ENV_FILENAME} ${DEPLOYDIR}
    fi
}
