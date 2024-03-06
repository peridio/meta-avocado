FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
  file://peridio.json \
  file://peridiod.conf \
"

FILES:${PN} += " \
  ${sysconfdir}/peridiod/peridio.json \
  ${systemd_unitdir}/system.conf.d/peridiod.conf \
"

do_install:append() {
  install -D -m 644 ${WORKDIR}/peridio.json \
    ${D}/${sysconfdir}/peridiod

  install -D -m 644 ${WORKDIR}/peridiod.conf \
    ${D}${systemd_unitdir}/system.conf.d/peridiod.conf
}
