FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}/envs:"

SRC_URI:append:qemuarm64-secureboot = " \
  file://0001-peridio-qemu-arm-mmc-init.patch \
  file://avocado.cfg \
  file://env-mmc.cfg \
"

MKENVIMAGE_EXTRA_ARGS = "-r"

do_configure:prepend:qemuarm64-secureboot() {
  cat ${WORKDIR}/avocado.cfg >> ${S}/configs/${UBOOT_MACHINE}
  cat ${WORKDIR}/env-mmc.cfg >> ${S}/configs/${UBOOT_MACHINE}
}
