SUMMARY = "Configurable embedded Linux firmware update creator and runner"
DESCRIPTION = ""
HOMEPAGE = "https://github.com/fwup-home/fwup"
SECTION = "devel"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"
DEPENDS = "libconfuse libarchive libsodium zlib pkgconfig-native"
SRC_URI = "git://github.com/fwup-home/fwup.git;protocol=https;branch=main;"

# Modify these as desired
PV = "1.10.0"
SRCREV = "a713b55f9cd94f8fee74b275bc0dcc417c04946a"

S = "${WORKDIR}/git"

SRC_URI:append:class-target = " \
  file://fwup.conf \
"

CFLAGS:prepend = "-I${S} "

inherit autotools lib_package pkgconfig
FILES:${PN} += "${datadir}/bash-completion/completions/fwup \
               ${bindir}/fwup \
"

FILES:${PN}-img2fwup = "${bindir}/img2fwup"

PACKAGES = "${PN}-dev ${PN}-dbg ${PN}-img2fwup ${PN}"
BBCLASSEXTEND = "native nativesdk"

inherit deploy

do_deploy() {
  # Only deploy for target
  if [ "${CLASSOVERRIDE}" != "class-target" ]; then
    return;
  fi
  install -m 644 ${WORKDIR}/fwup.conf ${DEPLOYDIR}
}

do_configure:append () {
  ln -s ${S}/src/fwup.h2m ${WORKDIR}/build/src/fwup.h2m
}

addtask deploy after do_install before do_build
