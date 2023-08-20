FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://avocado-init"

do_install:append () {
    # Format the data partition
    install -m 0755 ${WORKDIR}/avocado-init ${D}/init.d/90-avocado-init
}

PACKAGES += "initramfs-module-avocado"

SUMMARY:initramfs-module-avocado = "initramfs support for initializing avocado"
RDEPENDS:initramfs-module-avocado = "${PN}-base libubootenv-bin"
FILES:initramfs-module-avocado = "/init.d/90-avocado-init"
