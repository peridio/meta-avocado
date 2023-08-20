DESCRIPTION = "Packagegroup for inclusion in all Avocado initramfs images"

LICENSE = "MIT"

MACHINE_FEATURES += ""

inherit packagegroup

RDEPENDS:${PN} = "\
  base-files \
  base-passwd \
  busybox \
  u-boot-fw-utils \
  util-linux-findfs \
  libubootenv-bin \
  initramfs-framework-base \
  initramfs-module-avocado \
  initramfs-module-udev \
  lvm2-udevrules \
  udev \
  util-linux-mount \
"
