DESCRIPTION = "Avocado initramfs"
LICENSE = "MIT"

inherit core-image

PACKAGE_INSTALL = "packagegroup-avocado-initramfs"

# Do not pollute the initrd image with rootfs features
export IMAGE_BASENAME = "${MLPREFIX}avocado-image-initramfs"
IMAGE_NAME_SUFFIX ?= ""
IMAGE_FEATURES = ""
IMAGE_LINGUAS = ""

do_image[nostamp] = "1"

IMAGE_FSTYPES = "${INITRAMFS_FSTYPES}"
IMAGE_FSTYPES ??= "cpio.gz"

IMAGE_ROOTFS_SIZE = "8192"
IMAGE_ROOTFS_EXTRA_SPACE = "0"

remove_alternative_files () {
    rm -rf ${IMAGE_ROOTFS}/usr/lib/opkg
}

ROOTFS_POSTPROCESS_COMMAND += "remove_alternative_files;"
