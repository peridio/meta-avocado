#!/bin/sh
echo "Avocado initramfs"

# Setup
mount -t devtmpfs none /dev
mount -t proc none /proc
mount -t sysfs none /sys

mkdir -p /run/lock

find_boot_part() {
	if findfs "LABEL=BOOT-A" > /dev/null; then
		PERIDIO_BOOT="a"
		echo "A"
	elif findfs "LABEL=BOOT-B" > /dev/null; then
		PERIDIO_BOOT="b"
		echo "B"
	fi
}

find_mount_devpath() {
	grep $1 /proc/mounts -m 1 | cut -d ' ' -f 1
}

shell() {
    echo "Starting shell"
    exec sh
}

# Wait for blkdev to mount the rootfs
ATTEMPTS=0
MAX_WAIT=10
find_boot_part
while [[ $ATTEMPTS -lt $MAX_WAIT ]] && [[ -v $PERIDIO_BOOT ]]; do
	echo "Waiting for blkdev"
	sleep 1
	find_boot_part
	let ATTEMPTS=ATTEMPTS+1
done

# Read the variables from the UBoot env
PERIDIO_INITRAMFS_SHELL=$(fw_printenv -n peridio_initramfs_shell)
PERIDIO_DISK_DEVPATH=$(fw_printenv -n peridio_disk_devpath)
PERIDIO_ROOTFS_DEVPATH=$(fw_printenv -n ${PERIDIO_BOOT}.peridio_rootfs_part0_devpath)
PERIDIO_ROOTFS_TYPE=$(fw_printenv -n ${PERIDIO_BOOT}.peridio_rootfs_part0_type)
PERIDIO_PLATFORMFS_DEVPATH=$(fw_printenv -n ${PERIDIO_BOOT}.peridio_platformfs_part0_devpath)
PERIDIO_PLATFORMFS_TYPE=$(fw_printenv -n ${PERIDIO_BOOT}.peridio_platformfs_part0_type)
PERIDIO_DATAFS_DEVPATH=$(fw_printenv -n ${PERIDIO_BOOT}.peridio_datafs_part0_devpath)
PERIDIO_DATAFS_TYPE=$(fw_printenv -n ${PERIDIO_BOOT}.peridio_datafs_part0_type)
PERIDIO_DATAFS_TARGET=$(fw_printenv -n ${PERIDIO_BOOT}.peridio_datafs_part0_target)

# Create the directories for mountpoints
for dir in root rootfs platformfs overlay; do
	mkdir -p /mnt/$dir
done

mount -t tmpfs -o size=10% tmpfs /mnt/overlay

for dir in upper work; do
	mkdir -p /mnt/overlay/$dir
done

# Mount the overlayfs
mount -t $PERIDIO_ROOTFS_TYPE -o ro $PERIDIO_ROOTFS_DEVPATH /mnt/rootfs
mount -t $PERIDIO_PLATFORMFS_TYPE $PERIDIO_PLATFORMFS_DEVPATH /mnt/platformfs
mount -t overlay -o rw,lowerdir=/mnt/platformfs:/mnt/rootfs,upperdir=/mnt/overlay/upper,workdir=/mnt/overlay/work overlay /mnt/root

# Calculate the devpaths incase PARTUUID or LABEL is being used as devpath
PERIDIO_ROOTFS_DEVPATH=$(find_mount_devpath /mnt/rootfs)
PERIDIO_PLATFORMFS_DEVPATH=$(find_mount_devpath /mnt/platformfs)
if [[ $PERIDIO_DISK_DEVPATH == UUID* ]]; then
  PERIDIO_DISK_DEVPATH="${PERIDIO_ROOTFS_DEVPATH%%+([[:digit:]])}"
fi
# Save the environment for the new rootfs
echo """
PERIDIO_BOOT=${PERIDIO_BOOT}
PERIDIO_DISK_DEVPATH=${PERIDIO_DISK_DEVPATH}
PERIDIO_PLATFORMFS_DEVPATH=${PERIDIO_PLATFORMFS_DEVPATH}
PERIDIO_PLATFORMFS_TYPE=${PERIDIO_PLATFORMFS_TYPE}
PERIDIO_ROOTFS_DEVPATH=${PERIDIO_ROOTFS_DEVPATH}
PERIDIO_ROOTFS_TYPE=${PERIDIO_ROOTFS_TYPE}
PERIDIO_DATAFS_DEVPATH=${PERIDIO_DATAFS_DEVPATH}
PERIDIO_DATAFS_TYPE=${PERIDIO_DATAFS_TYPE}
PERIDIO_DATAFS_TARGET=${PERIDIO_DATAFS_TARGET}
""" >> /mnt/root/etc/environment

# Source the environment when logging in
echo "source /etc/environment" >> /mnt/root/etc/profile

# Add an entry to fstab for the data partition
# systemd will initialize the partition if it fails to mount
echo "${PERIDIO_DATAFS_DEVPATH} ${PERIDIO_DATAFS_TARGET} ${PERIDIO_DATAFS_TYPE} nodev,x-systemd.makefs 0 2" >> /mnt/root/etc/fstab

if [[ $PERIDIO_INITRAMFS_SHELL == "true" ]]; then
	shell
else
	umount /proc
	umount /sys
	umount /dev

	exec switch_root /mnt/root /sbin/init
fi
