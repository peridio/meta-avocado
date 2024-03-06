FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI += " \
  file://squashfs.cfg \
  file://mmc.cfg \
  file://f2fs.cfg \
  file://overlayfs.cfg \
  file://gpt.cfg \
  file://ftpm.cfg \
"
