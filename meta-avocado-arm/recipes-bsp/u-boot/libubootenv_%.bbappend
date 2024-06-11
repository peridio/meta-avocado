FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

inherit deploy

do_deploy() {
    install -m 644 ${WORKDIR}/fw_env.config ${DEPLOYDIR}/fw_env.config
}

addtask deploy after do_compile before do_install
