DESCRIPTION = "Packagegroup for inclusion in all Avocado images"

LICENSE = "MIT"

inherit packagegroup

RDEPENDS:${PN} = " \
  e2fsprogs-mke2fs \
  f2fs-tools \
  fwup \
  haveged \
  kernel \
  libubootenv-bin \
  peridiod \
  procps \
  socat \
  picocom \
"
