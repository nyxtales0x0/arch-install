#!/bin/bash

function instal_grub() {
    echo "==============="
    echo "Instlling grub:"
    echo "==============="
    echo

    mount /dev/nvme0n1p1 /boot/efi --mkdir
    pacman -S grub efibootmgr os-prober
    sed -i "s/#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=false/" /etc/default/grub
    grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
    grub-mkconfig -o /boot/grub/grub.cfg

    echo "[OK]: Press enter to continue..."
    read
    clear
}

instal_grub
