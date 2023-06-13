DESCRIPTION = "Packagegroup for inclusion in all Avocado images"

LICENSE = "MIT"

inherit packagegroup

RDEPENDS:${PN} = " \
  fwup \
  f2fs-tools \
  e2fsprogs-mke2fs \
  haveged \
  procps \
  libubootenv-bin \
  peridiod \
"
