DESCRIPTION = "Packagegroup for SSL/TLS tools in Avocado images"

LICENSE = "MIT"

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit packagegroup

RDEPENDS:${PN} = " \
  libp11 \
  p11-kit \
  gnutls-bin \
"
