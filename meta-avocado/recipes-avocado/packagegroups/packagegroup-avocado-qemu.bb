DESCRIPTION = "Packagegroup for inclusion in all Avocado qemu images"

LICENSE = "MIT"

MACHINE_FEATURES += "efi"

inherit packagegroup

RDEPENDS:${PN} = " \
  optee-client \
  optee-os \
  optee-test \
  optee-examples \
  trusted-firmware-a \
"
