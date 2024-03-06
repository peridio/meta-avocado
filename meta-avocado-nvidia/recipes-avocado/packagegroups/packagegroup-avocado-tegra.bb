DESCRIPTION = "Packagegroup for inclusion in all Avocado tegra images"

LICENSE = "MIT"

do_image[deptask] = "do_image_complete"
DEPENDS += "tegra-initrd-flash-initramfs"

inherit features_check

IMAGE_FEATURES += "splash hwcodecs"
REQUIRED_DISTRO_FEATURES = "opengl virtualization"

inherit packagegroup

RDEPENDS:${PN} = " \
  nvidia-docker \
  cuda-libraries \
  tegra-tools-tegrastats \
"
