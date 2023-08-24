DESCRIPTION = "Packagegroup for common Avocado test applications"

LICENSE = "MIT"

inherit packagegroup

RDEPENDS:${PN} = " \
  strace \
"
