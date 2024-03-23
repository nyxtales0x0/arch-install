#!/bin/bash

DISK="/dev/nvme0n1"
EFI_SYSTEM_PARTITION="${DISK}p1"
ROOT_PARTITION="${DISK}p5"

function setup_root_partition() {
    echo "=========================="
    echo "Formatting root partition:"
    echo "=========================="
    echo

    mkfs.ext4 $ROOT_PARTITION

    echo "[OK]: Press Enter to continue..."
    read
    clear
}

function configure_pacman() {
    echo "==================="
    echo "Configuring pacman:"
    echo "==================="
    echo

    PACMAN_CONFIG="/etc/pacman.conf"
    sed -i "s/#Color/Color/" $PACMAN_CONFIG
    sed -i "s/#ParallelDownloads/ParallelDownloads/" $PACMAN_CONFIG

    echo "[OK]: Press Enter to continue..."
    read
    clear
}

function install_base_system() {
    echo "======================="
    echo "Installing base system:"
    echo "======================="
    echo

    mount $ROOT_PARTITION /mnt
    pacstrap -K /mnt base linux linux-firmware networkmanager
    genfstab -U /mnt >> /mnt/etc/fstab

    echo "[OK]: Press Enter to continue..."
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

setup_root_partition

configure_pacman

install_base_system

post_install_configuration

shutdown now