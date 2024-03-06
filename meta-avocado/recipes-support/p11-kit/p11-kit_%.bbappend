FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
  file://pkcs11.conf \
  file://libckteec.module \
"

do_install:append() {
  install -d ${D}${sysconfdir}/pkcs11/
  install -d ${D}${datadir}/p11-kit/modules
  
  install -m 0644 ${WORKDIR}/pkcs11.conf ${D}${sysconfdir}/pkcs11/
  install -m 0644 ${WORKDIR}/libckteec.module ${D}${datadir}/p11-kit/modules
}
