SRC_URI += "file://uboot-env.txt"

ENV_FILENAME = "uboot.env"
ENV_FILEPATH = "${WORKDIR}/uboot-env.txt"

do_compile:append() {
    bbnote "Compile U-Boot environment"
    ${B}/tools/mkenvimage ${MKENVIMAGE_EXTRA_ARGS} -s ${UBOOT_ENV_SIZE} ${ENV_FILEPATH} -o ${ENV_FILENAME}
}

do_deploy:append() {
    if [ -e  ${B}/${ENV_FILENAME} ]; then
        install -Dm 0644 ${B}/${ENV_FILENAME} ${DEPLOYDIR}
    fi
}
