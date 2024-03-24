#!/bin/bash

function install_base_system () {
    echo "======================="
    echo "Installing base system:"
    echo "======================="
    echo

    mount /dev/nvme0n1p5 /mnt
    pacstrap -K /mnt base linux linux-firmware networkmanager sof-firmware
    genfstab -U /mnt >> /mnt/etc/fstab

    echo "[OK]: Press enter to continue..."
    read
    clear
}

install_base_system
