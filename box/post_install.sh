#!/bin/sh

function setup_time_zone() {
    REGION_CITY="Asia/Kolkata"
    ln -sf /usr/share/zoneinfo/$REGION_CITY /etc/localtime
    hwclock --systohc
}

function setup_locale() {
    sed -i "s/#en_IN UTF-8/en_IN UTF-8/" /etc/locale.gen
    locale-gen
    echo "LANG=en_IN.UTF-8" >> /etc/locale.conf
}

function configure_network() {
    echo "coffee" >> /etc/hostname
    echo "# The following lines are desirable for IPv4 capable hosts" >> /etc/hosts
    echo "127.0.0.1       localhost"                                  >> /etc/hosts
    echo "# 127.0.1.1 is often used for the FQDN of the machine"      >> /etc/hosts
    echo "127.0.1.1       coffee"                                     >> /etc/hosts
    echo "# The following lines are desirable for IPv6 capable hosts" >> /etc/hosts
    echo "::1             localhost ip6-localhost ip6-loopback"       >> /etc/hosts
    echo "ff02::1         ip6-allnodes"                               >> /etc/hosts
    echo "ff02::2         ip6-allrouters"                             >> /etc/hosts
    systemctl enable NetworkManager
}

function configure_pacman() {
    PACMAN_CONFIG="/etc/pacman.conf"
    sed -i "s/#Color/Color/" $PACMAN_CONFIG
    sed -i "s/#ParallelDownloads/ParallelDownloads/" $PACMAN_CONFIG
}

function setup_grub() {
    mount /dev/vda1 /boot/efi --mkdir
    yes | pacman -S grub efibootmgr os-prober
    sed -i "s/#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=false/" /etc/default/grub
    grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Grub
    grub-mkconfig -o /boot/grub/grub.cfg
}

function setup_users() {
    yes "root" | passwd
    yes | pacman -S sudo
    useradd -m birb
    yes "birb" | passwd birb
    sed -i "s/root ALL=(ALL:ALL) ALL/root ALL=(ALL:ALL) ALL\nbirb ALL=(ALL:ALL) ALL/" /etc/sudoers
}

setup_time_zone

setup_locale

configure_network

configure_pacman

setup_grub

setup_users
