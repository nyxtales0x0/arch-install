#!/bin/bash

DISK="/dev/vda"
EFI_SYSTEM_PARTITION="${DISK}1"
ROOT_PARTITION="${DISK}2"

function setup_partition_table() {
    (
        echo "g"          # new GPT partition table
        echo "n"          # new partition
        echo              # partition number: default
        echo              # first sector: default
        echo "+100MiB"    # last sector
        echo "t"          # partition type
        echo "EFI System" # new partition type
        echo "n"          # new partition
        echo              # partition number: default
        echo              # first sector: default
        echo              # last sector: default
        echo "w"          # write table
    ) | fdisk $DISK
    mkfs.fat -F 32 $EFI_SYSTEM_PARTITION
    mkfs.ext4 $ROOT_PARTITION
}

function configure_pacman() {
    PACMAN_CONFIG="/etc/pacman.conf"
    sed -i "s/#Color/Color/" $PACMAN_CONFIG
    sed -i "s/#ParallelDownloads/ParallelDownloads/" $PACMAN_CONFIG
}

function install_base_system() {
    echo
    echo "======================="
    echo "Installing base system:"
    echo "======================="
    echo
    mount $ROOT_PARTITION /mnt
    pacstrap -K /mnt base linux linux-firmware networkmanager
    genfstab -U /mnt >> /mnt/etc/fstab
}

function post_install_configuration() {
    cp ./post_install.sh /mnt
    arch-chroot /mnt chmod +x ./post_install.sh
    arch-chroot /mnt ./post_install.sh
    arch-chroot /mnt rm ./post_install.sh
}

setup_partition_table

configure_pacman

install_base_system

post_install_configuration

exit
