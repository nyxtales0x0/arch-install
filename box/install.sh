#!/bin/bash

DISK="/dev/vda"
ROOT_PARTITION="${DISK}1"

function setup_partition_table() {
    echo "===================="
    echo "Preparing Partitions"
    echo "===================="
    (
        echo "o"          # new MBR partition table
        echo "n"          # new partition
        echo "p"          # primary partition
        echo              # partition number
        echo              # first sector: default
        echo              # last sector: default
        echo "w"          # write table
    ) | fdisk $DISK
    mkfs.ext4 $ROOT_PARTITION
    echo "----------------------------------"
    echo "[DONE]: press Enter to continue..."
    read
    clear
}

function configure_pacman() {
    echo "=================="
    echo "Configuring Pacman"
    echo "=================="
    PACMAN_CONFIG="/etc/pacman.conf"
    sed -i "s/#Color/Color/" $PACMAN_CONFIG
    sed -i "s/#ParallelDownloads/ParallelDownloads/" $PACMAN_CONFIG
    echo "----------------------------------"
    echo "[DONE]: press Enter to continue..."
    read
    clear
}

function install_base_system() {
    echo "======================="
    echo "Installing base system:"
    echo "======================="
    mount $ROOT_PARTITION /mnt
    pacstrap -K /mnt base linux linux-firmware networkmanager
    genfstab -U /mnt >> /mnt/etc/fstab
    echo "----------------------------------"
    echo "[DONE]: press Enter to continue..."
    read
    clear
}

function post_install_configuration() {
    cp ./post_install.sh /mnt
    arch-chroot /mnt chmod +x ./post_install.sh
    arch-chroot /mnt ./post_install.sh
    arch-chroot /mnt rm ./post_install.sh
}

clear

setup_partition_table

configure_pacman

install_base_system

post_install_configuration

echo "OUT DONE"
echo "----------------------------------"
echo "[DONE]: press Enter to continue..."
read
clear