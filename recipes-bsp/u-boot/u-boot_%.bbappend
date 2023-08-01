FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI += " \
  file://avocado.cfg \
  file://env-mmc.cfg \
  file://0001-peridio-qemu-arm-mmc-env.patch \
"

do_configure:prepend() {
  cat ${WORKDIR}/avocado.cfg >> ${S}/configs/${UBOOT_MACHINE}
  cat ${WORKDIR}/env-mmc.cfg >> ${S}/configs/${UBOOT_MACHINE}
}
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}/envs:"
require u-boot-env.inc
