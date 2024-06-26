DESCRIPTION = "Custom flash layout file to add avocado partitions"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI:append = " \
  file://avocado_flash_l4t_nvme_rootfs_ab.xml \
"

INHIBIT_DEFAULT_DEPS = "1"
COMPATIBLE_MACHINE = "(tegra)"

S = "${WORKDIR}"

do_compile[noexec] = "1"

do_install() {
    install -d ${D}${datadir}/avocado-flash-l4t
    install -m 0644 ${S}//avocado_flash_l4t_nvme_rootfs_ab.xml ${D}${datadir}/avocado-flash-l4t/
}

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit nopackages
