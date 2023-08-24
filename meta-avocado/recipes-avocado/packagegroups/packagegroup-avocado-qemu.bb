DESCRIPTION = "Packagegroup for inclusion in all Avocado qemu images"

LICENSE = "MIT"

MACHINE_FEATURES += "efi"

inherit packagegroup

RDEPENDS:${PN} = " \
  optee-client \
  optee-ftpm \
  optee-os \
  trusted-firmware-a \
"
