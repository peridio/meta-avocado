SUMMARY = "Tools for Flash-Friendly File System (F2FS)"
HOMEPAGE = "https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git"

LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://COPYING;md5=362b4b2594cd362b874a97718faa51d3"

# to provide libuuid
DEPENDS = "util-linux"

SRCREV = "47558d1ab784cceea1ee0fd8da43e5d3c5fcf8ab"
SRC_URI = "git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git;branch=master \
           "
UPSTREAM_CHECK_GITTAGREGEX = "v(?P<pver>\d+(\.\d+)+)"

S = "${WORKDIR}/git"

inherit pkgconfig autotools

BBCLASSEXTEND = "native"
