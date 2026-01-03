#!/usr/bin/env bash

set -e  # Exit on error

FSTAB="/etc/fstab"
SUBVOL="@.snapshots"

ROOT_MOUNT_POINT="/mnt/btrfs"
SNAPSHOT_MOUNT_POINT="/.snapshots"

# mount @ to create @.snapshots
sudo mkdir -p $ROOT_MOUNT_POINT
sudo mount UUID=$(findmnt -no UUID /) $ROOT_MOUNT_POINT
# create subvolume @.snapshots
sudo btrfs subvolume create $ROOT_MOUNT_POINT/@.snapshots
sudo mkdir /.snapshots
# cleanup
sudo umount $ROOT_MOUNT_POINT
sudo rmdir $ROOT_MOUNT_POINT

# Extract the device/UUID from existing btrfs entries
BTRFS_DEVICE=$(grep -m1 "btrfs.*subvol=/@" "$FSTAB" | awk '{print $1}')
# Extract mount options from existing btrfs entry (excluding subvol)
MOUNT_OPTIONS=$(grep -m1 "btrfs.*subvol=/@" "$FSTAB" | awk '{print $4}' | sed 's/subvol=[^,]*,\?//')
# Add subvol option
MOUNT_OPTIONS="subvol=/${SUBVOL},${MOUNT_OPTIONS}"
# Clean up any double commas
MOUNT_OPTIONS=$(echo "$MOUNT_OPTIONS" | sed 's/,,/,/g' | sed 's/^,//;s/,$//')

# Check if entry already exists
if grep -q "$SNAPSHOT_MOUNT_POINT" "$FSTAB"; then
    echo "Warning: Entry for $SNAPSHOT_MOUNT_POINT already exists in fstab"
    echo "Please check manually: $FSTAB"
    exit 1
fi

# Add new entry to fstab
echo "$BTRFS_DEVICE $SNAPSHOT_MOUNT_POINT btrfs   $MOUNT_OPTIONS 0 0" | sudo tee -a "$FSTAB" > /dev/null

echo "Added entry to fstab:"
echo "$BTRFS_DEVICE $SNAPSHOT_MOUNT_POINT btrfs   $MOUNT_OPTIONS 0 0"
