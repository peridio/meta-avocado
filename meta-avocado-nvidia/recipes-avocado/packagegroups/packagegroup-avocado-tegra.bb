DESCRIPTION = "Packagegroup for inclusion in all Avocado tegra images"

LICENSE = "MIT"

IMAGE_FEATURES += "splash hwcodecs"

inherit features_check

REQUIRED_DISTRO_FEATURES = "opengl virtualization"

inherit packagegroup

RDEPENDS:${PN} = " \
  nvidia-docker \
  cuda-libraries \
  tegra-tools-tegrastats \
  tensorflow \
  keras \
"

