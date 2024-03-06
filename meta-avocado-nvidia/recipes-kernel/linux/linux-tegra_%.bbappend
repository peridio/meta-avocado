FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI += " \
  file://squashfs.cfg \
  file://f2fs.cfg \
  file://overlayfs.cfg \
"
