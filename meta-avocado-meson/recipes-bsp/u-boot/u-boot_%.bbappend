FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
  file://avocado.cfg \
  file://env-mmc.cfg \
"

MKENVIMAGE_EXTRA_ARGS = "-r"

do_configure:prepend() {
  cat ${WORKDIR}/avocado.cfg >> ${S}/configs/${UBOOT_MACHINE}
  cat ${WORKDIR}/env-mmc.cfg >> ${S}/configs/${UBOOT_MACHINE}
}