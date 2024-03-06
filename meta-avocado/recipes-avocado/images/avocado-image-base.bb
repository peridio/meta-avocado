DESCRIPTION = "Avocado rootfs image"

IMAGE_FEATURES += "ssh-server-openssh"

LICENSE = "MIT"

do_image[deptask] = "do_image_complete"
DEPENDS = "${INITRAMFS_IMAGE}"

inherit core-image

CORE_IMAGE_BASE_INSTALL += "packagegroup-avocado-base packagegroup-avocado-basetests packagegroup-avocado-tls"
CORE_IMAGE_BASE_INSTALL += "${@'packagegroup-avocado-systemd' if d.getVar('VIRTUAL-RUNTIME_init_manager') == 'systemd' else ''}"
CORE_IMAGE_BASE_INSTALL += "${@'packagegroup-avocado-qemu' if d.getVar('MACHINE').startswith('qemu') else ''}"

IMAGE_FSTYPES += "squashfs"

