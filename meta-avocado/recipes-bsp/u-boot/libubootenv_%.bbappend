FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI:append:class-target = " \
  file://fw_env.config \
"
FILES:${PN} += "${sysconfdir}/fw_env.config"

do_install:append:class-target() {
  install -d ${D}${sysconfdir}
  install -m 644 ${WORKDIR}/fw_env.config ${D}${sysconfdir}/fw_env.config
}
