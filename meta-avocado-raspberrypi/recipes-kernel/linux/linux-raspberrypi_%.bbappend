FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI += " \
  file://squashfs.cfg \
  file://f2fs.cfg \
  file://overlayfs.cfg \
"
SRC_URI:append:raspberrypi5 = " \
  file://localversion.cfg \
"
