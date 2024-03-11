do_deploy:append () {
    dd if=${DEPLOYDIR}/u-boot.bin.sd.bin of=${DEPLOYDIR}/u-boot.bin.sd.ssb.bin bs=1 count=444
    dd if=${DEPLOYDIR}/u-boot.bin.sd.bin of=${DEPLOYDIR}/u-boot.bin.sd.tsb.bin bs=512 skip=1
}