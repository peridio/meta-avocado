DESCRIPTION = "Packagegroup for inclusion in all Avocado qemu images"

LICENSE = "MIT"

MACHINE_FEATURES += "efi"

inherit packagegroup

RDEPENDS:${PN} = " \
  optee-os \
  optee-client \
  optee-ftpm \
  trusted-firmware-a \
"
