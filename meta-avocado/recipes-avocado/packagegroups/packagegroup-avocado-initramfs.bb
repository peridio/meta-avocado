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
  initramfs-module-debug \
  initramfs-module-udev \
  initramfs-module-avocado-env \
  initramfs-module-avocado-rootfs \
  initramfs-module-avocado-overlaymkfs \
  initramfs-module-overlayroot \
  initramfs-module-avocado-finish \
  lvm2-udevrules \
  udev \
  util-linux-mount \
"
