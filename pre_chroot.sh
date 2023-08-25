#!/bin/sh

# format the root partition
yes | mkfs.ext4 /dev/nvme0n1p5

# pacman configuration
sed -i "s/#Color/Color/" /etc/pacman.conf
sed -i "s/#ParallelDownloads = 5/ParallelDownloads = 5/" /etc/pacman.conf

# mount the root partition to /mnt
mount /dev/nvme0n1p5 /mnt

# install packages
pacstrap -K /mnt base linux linux-firmware networkmanager

# generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

# move post_chroot.sh to /mnt and execute it
cp ./post_chroot.sh /mnt
arch-chroot /mnt chmod +x ./post_chroot.sh
arch-chroot /mnt ./post_chroot.sh

# delete setup2.sh from /mnt
arch-chroot /mnt rm ./post_chroot.sh
