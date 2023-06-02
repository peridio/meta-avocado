DESCRIPTION = "Packagegroup for inclusion in all Avocado images"

LICENSE = "MIT"

inherit packagegroup

RDEPENDS:${PN} = " \
  fwup \
  f2fs-tools \
  haveged \
  procps \
  libubootenv-bin \
  peridiod \
"
