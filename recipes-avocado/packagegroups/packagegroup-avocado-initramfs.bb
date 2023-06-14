DESCRIPTION = "Packagegroup for inclusion in all Avocado initramfs images"

LICENSE = "MIT"

MACHINE_FEATURES += ""

inherit packagegroup

VIRTUAL-RUNTIME_dev_manager = "busybox-mdev"
VIRTUAL-RUNTIME_initscripts = ""
VIRTUAL-RUNTIME_init_manager = "avocado-init"
VIRTUAL-RUNTIME_login_manager = ""
VIRTUAL-RUNTIME_syslog = ""
VIRTUAL-RUNTIME_keymaps = ""
VIRTUAL-RUNTIME_update-alternatives = ""

RDEPENDS:${PN} = "\
    base-files \
    busybox \
    ${VIRTUAL-RUNTIME_dev_manager} \
    ${VIRTUAL-RUNTIME_init_manager} \
    ${VIRTUAL-RUNTIME_initscripts} \
    ${VIRTUAL-RUNTIME_login_manager} \
    ${VIRTUAL-RUNTIME_syslog} \
    u-boot-fw-utils \
    util-linux-findfs \
    libubootenv-bin \
    "
