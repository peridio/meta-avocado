FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI:append = " \
  file://squashfs.cfg \
  file://mmc.cfg \
  file://f2fs.cfg \
"
