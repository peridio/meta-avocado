#!/bin/sh
echo "Avocado initramfs"

# Setup
mount -t devtmpfs none /dev
mount -t proc none /proc
mount -t sysfs none /sys

mkdir -p /run/lock

find_mount_devpath() {
	grep $1 /proc/mounts -m 1 | cut -d ' ' -f 1
}

shell() {
    echo "Starting shell"
    exec sh
}

# Read the variables from the UBoot env
PERIDIO_BOOT=$(fw_printenv -n peridio_active)
PERIDIO_INITRAMFS_SHELL=$(fw_printenv -n peridio_initramfs_shell)
PERIDIO_DISK_DEVPATH=$(fw_printenv -n peridio_disk_devpath)
PERIDIO_ROOTFS_DEVPATH=$(fw_printenv -n ${PERIDIO_BOOT}.peridio_rootfs_part_devpath)
PERIDIO_ROOTFS_TYPE=$(fw_printenv -n ${PERIDIO_BOOT}.peridio_rootfs_part_type)
PERIDIO_DATAFS_DEVPATH=$(fw_printenv -n ${PERIDIO_BOOT}.peridio_datafs_part_devpath)
PERIDIO_DATAFS_TYPE=$(fw_printenv -n ${PERIDIO_BOOT}.peridio_datafs_part_type)
PERIDIO_DATAFS_TARGET=$(fw_printenv -n ${PERIDIO_BOOT}.peridio_datafs_part_mountpoint)

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
# mount -t $PERIDIO_PLATFORMFS_TYPE $PERIDIO_PLATFORMFS_DEVPATH /mnt/platformfs
# mount -t overlay -o rw,lowerdir=/mnt/platformfs:/mnt/rootfs,upperdir=/mnt/overlay/upper,workdir=/mnt/overlay/work overlay /mnt/root
mount -t overlay -o rw,lowerdir=/mnt/rootfs,upperdir=/mnt/overlay/upper,workdir=/mnt/overlay/work overlay /mnt/root

# Calculate the devpaths incase PARTUUID or LABEL is being used as devpath
PERIDIO_ROOTFS_DEVPATH=$(find_mount_devpath /mnt/rootfs)
# if [[ $PERIDIO_DISK_DEVPATH == UUID* ]]; then
#   PERIDIO_DISK_DEVPATH="${PERIDIO_ROOTFS_DEVPATH%%+([[:digit:]])}"
# fi
# Save the environment for the new rootfs
echo """
PERIDIO_BOOT=${PERIDIO_BOOT}
PERIDIO_DISK_DEVPATH=${PERIDIO_DISK_DEVPATH}
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

if [[ $PERIDIO_INITRAMFS_SHELL == "1" ]]; then
	shell
else
	umount /proc
	umount /sys
	umount /dev

	exec switch_root /mnt/root /sbin/init
fi
