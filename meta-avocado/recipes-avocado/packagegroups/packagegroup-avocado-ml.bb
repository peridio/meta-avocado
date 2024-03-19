DESCRIPTION = "Packagegroup for common machine learning tools"

LICENSE = "MIT"

inherit packagegroup

RDEPENDS:${PN} = " \
  git \
  python3 \
  python3-pip \
  python3-numpy \
  python3-opencv \
  python3-matplotlib \
"
