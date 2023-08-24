FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI += " \
    file://avoenv \
    file://avorootfs \
    file://avooverlaymkfs \
    file://avofinish \
"

do_install:append () {
    # Avocado env
    install -m 0755 ${WORKDIR}/avoenv ${D}/init.d/50-avoenv

    # Avocado rootfs
    install -m 0755 ${WORKDIR}/avorootfs ${D}/init.d/89-avorootfs
    
    # Avocado overlaymkfs
    install -m 0755 ${WORKDIR}/avooverlaymkfs ${D}/init.d/90-avooverlaymkfs

    # Avocado finish
    install -m 0755 ${WORKDIR}/avofinish ${D}/init.d/98-avofinish
}

PACKAGES += " \
    initramfs-module-avocado-env \
    initramfs-module-avocado-rootfs \
    initramfs-module-avocado-overlaymkfs \
    initramfs-module-avocado-finish \
"

SUMMARY:initramfs-module-avocado-env = "Populate Avocado U-Boot environment"
RDEPENDS:initramfs-module-avocado-env = "${PN}-base libubootenv-bin"
FILES:initramfs-module-avocado-env = "/init.d/50-avoenv"

SUMMARY:initramfs-module-avocado-rootfs = "Avocado support for mounting RootFS"
RDEPENDS:initramfs-module-avocado-rootfs = "${PN}-base"
FILES:initramfs-module-avocado-rootfs = "/init.d/89-avorootfs"

SUMMARY:initramfs-module-avocado-overlaymkfs = "Avocado support for formatting data part"
RDEPENDS:initramfs-module-avocado-overlaymkfs = "${PN}-base e2fsprogs-mke2fs f2fs-tools"
FILES:initramfs-module-avocado-overlaymkfs = "/init.d/90-avooverlaymkfs"

SUMMARY:initramfs-module-avocado-finish = "Avocado support for finishing up initramfs"
RDEPENDS:initramfs-module-avocado-finish = "${PN}-base"
FILES:initramfs-module-avocado-finish = "/init.d/98-avofinish"
