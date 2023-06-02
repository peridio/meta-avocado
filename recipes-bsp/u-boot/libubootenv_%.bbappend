FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI:append:class-target = " \
  file://fw_env.config \
"
FILES:${PN} += "/etc/fw_env.config"

inherit deploy

do_install:append() {
  install -d ${D}${sysconfdir}
  install -m 644 ${WORKDIR}/fw_env.config ${D}${sysconfdir}/fw_env.config
}

do_deploy() {
	install -m 644 ${WORKDIR}/fw_env.config ${DEPLOYDIR}
}

addtask deploy after do_install before do_build
